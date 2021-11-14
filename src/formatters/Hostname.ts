import { Formatter } from './formatter';
import {Label} from './Label';
import * as os from 'os';

class Hostname extends Label<string> {
  constructor(path: string) {
    super(os.hostname(), path)
  }
}

export function createHostname(path: string = 'hostname'): Formatter {
  return new Hostname(path);
}
