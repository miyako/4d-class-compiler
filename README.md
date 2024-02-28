![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-class-compiler)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-class-compiler/total)

Classes to compile, build, sign a project.

# To build a project with tool4d

```
tool4d compiler.4DProject --startup-method=build --user-param=.4DSettings,.4DProject --dataless
```

other startup methods: `compile` `rebuild` `sign`

# To build a project with 4D

```4d
$buildProject:=File("{Settings}/BuildApp.4DSettings")
$compileProject:=File("{Project}/BuildApp.4DProject")

var $CLI : cs.BuildApp_CLI

$CLI:=cs.BuildApp_CLI.new()
$CLI.compile($compileProject)
$CLI.build($buildProject; $compileProject)
```

# Note

* Do not zip *4D.entitlements* or *SignApp.sh* on Windows. `codesign` will fail.
* *SignApp.sh* does not seem to work when a self hosted runner is launched as a service (requires invenstigation)

# Change log

* `1.0.0`: added `localbuild` start method to build in place (ignore destination path in build project)
