import { RuntimeLabel } from './RuntimeLabel';
import { Formatter, TransformableInfo } from './formatter';

interface Options {
  stack?: boolean;
  path?: string;
}

interface PrettyError {
  errorType: string;
  message: string;
}

const StackSpaceRegex: RegExp = new RegExp(/\n\s*/g);
export class PrettyErrors extends RuntimeLabel<Array<string>> implements Formatter {
  private stack: boolean;

  constructor(stack: boolean = false, path: string = 'stack') {
    super(path);
    this.stack = Boolean(stack);
  }

  public transform(info: TransformableInfo): TransformableInfo {
    this.convertObjectErrors(info, info);
    return info;
  }

  private convertObjectErrors(info: any, node: any): boolean {
    let errorFound: boolean = false;

    if (node === undefined || node === null) {
      return false;
    }

    for (const [key, value] of Object.entries(node)) {
      if (value instanceof Error) {
        errorFound = true;
        node[key] = this.convertError(info, value);
      } else if (typeof value === 'object') {
        errorFound = this.convertObjectErrors(info, value);
      }

      if (errorFound) {
        break;
      }
    }

    return errorFound;
  }

  private convertError(info: any, error: Error): PrettyError {
    const { stack } = this;

    if (stack && error.stack) {
      this.setTransformValue(error.stack.replace(StackSpaceRegex, '\n').split('\n'), info);
    }

    return { errorType: error.constructor.name, message: error.message };
  }
}

export function createPrettyErrors(opts: Options = {}): Formatter {
  return new PrettyErrors(opts.stack, opts.path);
}
