# SignApp : _CLI

`SignApp` is a subclass of `_CLI` to execute the `SignApp.sh` script. 

## .sign()

**.sign**($application : 4D.Folder)->$this : cs.SignApp

Sign the specified application. The log is generated in `/LOGS/SignApp-{timestamp}.log`.

## .signAsync()

**.signAsync**($application : 4D.Folder)->$this : cs.SignApp

Sign the specified application in a dedicated worker. The log is printed to the standard output stream.