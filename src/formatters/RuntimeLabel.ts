import { TransformableInfo } from './formatter';

export abstract class RuntimeLabel<T> {
  readonly path: Array<string>;

  constructor(path: string) {
    this.path = path.split('.');
  }

  protected setTransformValue(value: T, info: TransformableInfo): TransformableInfo {
    const { path } = this;
    const { length } = path;
    const last: number = length - 1;

    // change to indexable type
    let node: any = info;

    for (let i: number = 0; i < length; i++) {
      const key: string = path[i];

      if (i == last) {
        node[key] = value;
      } else {
        node = node[key] = node[key] || {};
      }
    }

    return info;
  }

  public abstract transform(info: TransformableInfo, opts?: any): TransformableInfo;
}
