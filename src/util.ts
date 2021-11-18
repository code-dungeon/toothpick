import * as path from 'path';
import * as fs from 'fs';

export function getPkgJsonDir(): string {
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
