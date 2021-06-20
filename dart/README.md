```
dart create -t console-full wordsmith
```
(`-t console-full` specifies a cli template for the project)

A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

Compile for macOS (on macOS):
```
dart compile exe bin/wordsmith.dart -o bin/wordsmith
```

`dart run` to run locally without compiling.

To supply arguments, must use the program name otherwise it will try to apply arguments to the run command:

`dart run wordsmith -a there three`
