```
swift package init --type executable --name wordsmith
```

This creates a `Package.swift` file as well as `Sources/wordsmith` within which should be placed the source files for compiling.

There is also a `Tests` directory.

`swift run` runs the application

`swiftc * -o wordsmith` produces a compiled binary called wordsmith. The compiler automatically works out dependencies

https://theswiftdev.com/the-swift-compiler-for-beginners/

https://www.avanderlee.com/swift/command-line-tool-package-manager/
