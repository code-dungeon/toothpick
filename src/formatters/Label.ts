import { RuntimeLabel } from './RuntimeLabel';
import { Formatter, TransformableInfo } from './formatter';

export class Label<T> extends RuntimeLabel<T> implements Formatter {
  readonly label: T;

  constructor(label: T, path: string) {
    super(path);
    this.label = label;
  }

  public transform(info: TransformableInfo): TransformableInfo {
    const { label } = this;
    return this.setTransformValue(label, info);
  }
}

export function createLabel<T>(label: T, path: string): Formatter {
  return new Label<T>(label, path);
}
