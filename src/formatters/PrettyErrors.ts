import { RuntimeLabel } from './RuntimeLabel';
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

const StackSpaceRegex: RegExp = new RegExp(/\n\s*/g);

function safeGetValueFromPropertyOnObject(obj: any, property: string): any {
  try {
    return obj[property];
  }
  catch (error) {
    return error;
  }
}
export class PrettyErrors implements Formatter {
  private stack: boolean;

  constructor(stack: boolean = false) {
    this.stack = Boolean(stack);
  }

  public transform(info: TransformableInfo): TransformableInfo {
    const seen: Set<any> = new Set();
    const { stack } = this;

    function visit(child: any): any {
      if (child === null || typeof child !== 'object') {
        return child;
      }

      if (seen.has(child)) {
        return child;
      }

      seen.add(child);

      if (Array.isArray(child)) {
        return child.map(visit);
      }

      if (child instanceof Error) {
        const error: PrettyError = {
          errorType: child.constructor.name,
          message: child.message
        };

        if (stack) {
          error.stack = child.stack.replace(StackSpaceRegex, '\n').split('\n');
        }

        return error;
      }

      const keys: Array<any> = [...Object.getOwnPropertyNames(child), ...Object.getOwnPropertySymbols(child)];

      return keys.reduce((result: any, key: string) => {
        result[key] = visit(safeGetValueFromPropertyOnObject(child, key));
        return result;
      }, {});
    }

    return visit(info);
  }
}

export function createPrettyErrors(opts: Options = {}): Formatter {
  return new PrettyErrors(opts.stack);
}
