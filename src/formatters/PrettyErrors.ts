import { Formatter, TransformableInfo } from './formatter';

interface Options {
  stack?: boolean;
  path?: string;
}

interface PrettyError {
  errorType: string;
  message: string;
  stack?: Array<string>;
}

const StackSpaceRegex = new RegExp(/\n\s*/g);

/* eslint-disable @typescript-eslint/no-explicit-any */
export class PrettyErrors implements Formatter {
  private stack: boolean;

  constructor(stack = false) {
    this.stack = Boolean(stack);
  }

  private toPrettyError(err: Error): PrettyError {
    const {stack} = this;

    const error: PrettyError = {
      errorType: err.constructor.name,
      message: err.message
    };

    if (stack) {
      error.stack = err.stack.replace(StackSpaceRegex, '\n').split('\n');
    }

    return error;
  }

  private safeGetValueFromPropertyOnObject(obj: any, property: string): any | PrettyError {
    try {
      let value: any = obj[property];

      if( typeof value === 'function') {
        return undefined;
      }

      return value;
    }
    catch (error) {
      return this.toPrettyError(error);
    }
  }

  private visit(seen: Set<any>, child: any): any {
    if (child === undefined || child === null || typeof child !== 'object') {
      return child;
    }

    if (seen.has(child)) {
      return child;
    }

    seen.add(child);

    if (Array.isArray(child)) {
      return child.map(this.visit.bind(this, seen));
    }

    if( typeof child.toJSON === 'function' ){
      try{
        return child.toJSON();
      } catch(error) {
        return this.toPrettyError(error);
      }
    }

    if (child instanceof Error) {
      return this.toPrettyError(child);
    }

    const keys: Array<any> = Object.keys(child);
    if( keys.length === 0 ){
      return undefined;
    }

    return keys.reduce((result: any, key: string) => {
      const value = this.safeGetValueFromPropertyOnObject(child, key);
      result[key] = this.visit(seen, value);
      return result;
    }, {});
  }

  public transform(info: TransformableInfo): TransformableInfo {
    const seen: Set<any> = new Set();

    return this.visit(seen, info);
  }
}

export function createPrettyErrors(opts: Options = {}): Formatter {
  return new PrettyErrors(opts.stack);
}

/* eslint-enable @typescript-eslint/no-explicit-any */
