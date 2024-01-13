# vivavideos

A online catalog to get an overview from newest movies.

## Getting Started

v1 - Everything seems to works like a charm.

## Important Notes

convert utf-8 to iso-8859-1 to easily mock jsons
https://www.motobit.com/util/charset-codepage-conversion.asp

you should have the env.json to make this works, but maybe you don't have it :P
If you do, put this line in you launch.json

  "toolArgs": ["--dart-define-from-file","env.json"]

for build use the same syntax above to build apk

for create the mocks you should run this command
dart run build_runner build --delete-conflicting-outputs;  