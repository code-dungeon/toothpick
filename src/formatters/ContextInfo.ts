import { Formatter, TransformableInfo } from './formatter';
import { RuntimeLabel } from './RuntimeLabel';

interface GetContextInfo {
  (): object;
}

class ContextInfo extends RuntimeLabel<object> implements Formatter {
  private getContextInfo: GetContextInfo;

  constructor(getContextInfo: GetContextInfo, path: string) {
    super(path)
    this.getContextInfo = getContextInfo;
  }

  public transform(info: TransformableInfo): TransformableInfo {
    let ctxInfo: object;

    if (typeof this.getContextInfo === 'function') {
      ctxInfo = this.getContextInfo();
    }

    if (ctxInfo !== undefined && ctxInfo !== null) {
      this.setTransformValue(ctxInfo, info);
    }

    return info;
  }
}

export function createContextInfo(getContextInfo: GetContextInfo, path: string = 'ctx') {
  return new ContextInfo(getContextInfo, path);
}
