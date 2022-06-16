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

  private toJSON(seen: Map<any, any>, child: any) {
    let result: any;
    try{
      result = child.toJSON();
    }catch( error ) {
      result = this.toPrettyError(error);
    }
    seen.set(child, result);

    return result;
  }

  private fromArray(seen: Map<any, any>, child:Array<any>){
    const {length} = child;
    const array: Array<any> = [];
    seen.set(child, array);

    for( let i = 0; i < length; ++i){
      array.push(this.visit(seen, child[i]));
    }

    return array;
  }

  private visit(seen: Map<any, any>, child: any): any {
    if (seen.has(child)) {
      return seen.get(child);
    }

    if (child === undefined || child === null || typeof child !== 'object') {
      return child;
    }

    if (Array.isArray(child)) {
      return this.fromArray(seen, child);
    }

    if( typeof child.toJSON === 'function' ){
      return this.toJSON(seen, child);
    }

    if (child instanceof Error) {
      const error = this.toPrettyError(child);
      seen.set(child, error);
      return error;
    }

    const keys: Array<any> = Object.keys(child);
    if( keys.length === 0 ){
      seen.set(child, child);
      return child;
    }

    const copy = {};
    seen.set(child, copy);
    return keys.reduce((result: any, key: string) => {
      const value = this.safeGetValueFromPropertyOnObject(child, key);
      result[key] = this.visit(seen, value);
      return result;
    }, copy);
  }

  public transform(info: TransformableInfo): TransformableInfo {
    const seen: Map<any, any> = new Map();

    info.message = this.visit(seen, info.message);

    return info;
  }
}

export function createPrettyErrors(opts: Options = {}): Formatter {
  return new PrettyErrors(opts.stack);
}

/* eslint-enable @typescript-eslint/no-explicit-any */
