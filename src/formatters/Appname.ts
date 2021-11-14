import { Formatter } from './formatter';
import { Label } from './Label';
import * as path from 'path';
import * as fs from 'fs';

function getPkgJsonDir() {
  const { dirname } = path;
  const { accessSync, constants } = fs;

  for (let path of module.paths) {
    try {
      const prospectivePkgJsonDir = dirname(path);
      accessSync(path, constants.F_OK);
      return prospectivePkgJsonDir;
    } catch (e) { }
  }
}

function getAppname() {
  const dir: string = getPkgJsonDir();
  const { name } = require(path.resolve(dir, 'package.json'));

  return name;
}
export function createAppname(path: string = 'app'): Formatter {
  const name: string = getAppname();
  return new Label<string>(name, path);
}
