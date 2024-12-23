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
    let node: TransformableInfo = info;

    for (let i = 0; i < length; i++) {
      const key: string = path[i];

      if (i == last) {
        if (typeof node[key] === 'object' && typeof value === 'object' && Array.isArray(value) === false) {
          node[key] = { ...node[key], ...value };
        } else {
          node[key] = value;
        }
      } else {
        node = node[key] = node[key] || {};
      }
    }

    return info;
  }

  /* eslint-disable-next-line @typescript-eslint/no-explicit-any */
  public abstract transform(info: TransformableInfo, opts?: any): TransformableInfo;
}
