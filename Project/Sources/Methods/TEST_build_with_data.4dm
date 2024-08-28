//%attributes = {}
var $BuildApp : cs:C1710.BuildApp
$BuildApp:=cs:C1710.BuildApp.new()

$BuildDestFolder:="BuildMacDestFolder"
$BuildApp[$BuildDestFolder]:=Folder:C1567(fk desktop folder:K87:19).platformPath

$RuntimeVLFolder:="RuntimeVLMacFolder"
$BuildApp.SourcesFiles.RuntimeVL[$RuntimeVLFolder]:="Macintosh HD:Applications:4D 20 R6:100140:4D Volume Desktop.app:"

$fileName:="BuildApp-"+Replace string:C233(String:C10(Current date:C33; ISO date:K1:8; Current time:C178); ":"; "-"; *)+".4DSettings"
$buildProject:=Folder:C1567("/LOGS/").file($fileName)

$BuildApp.findLicenses(["4DDP"; "4UUD"])
$BuildApp.SourcesFiles.RuntimeVL.RuntimeVLIncludeIt:=True:C214
$BuildApp.BuildApplicationSerialized:=True:C214
$BuildApp.DataFilePath:="Macintosh HD:Users:miyako:Desktop:xx:Data:data.4DD"

$BuildApp.BuildApplicationName:="TEST"

//%W-550.12
$BuildApp.findCertificates("name == :1 and kind == :2"; "@miyako@"; "Developer ID Application")
//%W+550.12
$BuildApp.SignApplication.MacSignature:=True:C214
$BuildApp.AdHocSign:=False:C215

$BuildApp.toFile($buildProject)

//BUILD APPLICATION($buildProject.platformPath)

$compileProject:=File:C1566(Structure file:C489; fk platform path:K87:2)

$CLI:=cs:C1710.BuildApp_CLI.new()
//$CLI.clean($compileProject)
$CLI.compile($compileProject)
$CLI.build($buildProject; $compileProject)