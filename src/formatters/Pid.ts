import { Formatter } from './formatter';
import { Label } from './Label';

class Pid extends Label<number> {
  constructor(path: string) {
    super(process.pid, path)
  }
}

export function createPid(path: string = 'pid'): Formatter {
  return new Pid(path);
}
