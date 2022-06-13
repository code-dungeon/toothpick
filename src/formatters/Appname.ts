import { Formatter } from './formatter';
import { Label } from './Label';
import { getPkgJsonDir } from '../util';
import * as path from 'path';

function getAppname() {
  const dir: string = getPkgJsonDir();
  /* eslint-disable-next-line */
  const { name } = require(path.resolve(dir, 'package.json'));

  return name;
}

export function createAppname(path = 'app'): Formatter {
  const name: string = getAppname();
  return new Label<string>(name, path);
}
