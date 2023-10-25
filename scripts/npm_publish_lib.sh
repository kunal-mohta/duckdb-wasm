#!/usr/bin/env bash

PROJECT_ROOT="$(cd $(dirname "$BASH_SOURCE[0]") && cd .. && pwd)" &> /dev/null

cd ${PROJECT_ROOT}/packages/duckdb-wasm

# Changing package name before publishing
# This is done here, and not directly in package.json, because a lot of other scripts depend on the package name being @duckdb/duckdb-wasm
python3 -c "import os; import json; p = json.load(open('package.json')); p['name'] = '@kunal-mohta/duckdb-wasm-pvt'; p['repository']['url'] = 'https://github.com/kunal-mohta/duckdb-wasm.git'; p['version'] = '1.0.0'; p['publishConfig'] = {}; p['publishConfig']['@kunal-mohta:registry'] = 'https://npm.pkg.github.com'; json.dump(p, open('package.json', 'w'), indent=2, ensure_ascii=False);"

mkdir -p ./dist/img
cp ${PROJECT_ROOT}/misc/duckdb.svg ./dist/img/duckdb.svg
cp ${PROJECT_ROOT}/misc/duckdb_wasm.svg ./dist/img/duckdb_wasm.svg
${PROJECT_ROOT}/scripts/build_duckdb_badge.sh > ./dist/img/duckdb_version_badge.svg

npm publish --ignore-scripts --access public ${TAG}
