# BuildApp_CLI : CLI

`BuildApp_CLI` is a subclass of `CLI` to compile or build a project.

## .build() 

**.build**($buildProject : 4D.File; $compileProject : 4D.File) : cs.BuildApp_CLI

Build a project.

## .clean() 

**.clean**($compileProject : 4D.File) : cs.BuildApp_CLI

Delete derived data and compiler intermediate files.

## .compile() 

**.compile**($compileProject : 4D.File) : cs.BuildApp_CLI

Compile a project.

## .quickSign()

**.quickSign**($BuildApp : cs.BuildApp; $RuntimeFolder : 4D.Folder) : cs.BuildApp_CLI

Sign an app using the `SignApp.sh` script file. Internally launches a worker and waits for its completion.