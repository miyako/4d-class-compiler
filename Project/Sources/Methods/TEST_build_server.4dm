//%attributes = {}
var $BuildApp : cs:C1710.BuildApp
$BuildApp:=cs:C1710.BuildApp.new()
$BuildApp.BuildMacDestFolder:=Folder:C1567(fk desktop folder:K87:19).platformPath
$platformIcon:=File:C1566(Structure file:C489; fk platform path:K87:2).parent.parent.parent.file("BuildApp/Resources/BuildApp.icns").platformPath
$BuildApp.SourcesFiles.CS.ClientMacFolderToMac:="Macintosh HD:Applications:4D 20.4:Hotfix 1:4D Volume Desktop.app:"
$BuildApp.SourcesFiles.CS.ServerMacFolder:="Macintosh HD:Applications:4D 20.4:Hotfix 1:4D Server.app:"
$BuildApp.SourcesFiles.CS.ServerIconMacPath:=$platformIcon
$BuildApp.SourcesFiles.CS.ClientMacIconForMacPath:=$platformIcon
$BuildApp.SourcesFiles.CS.ClientMacIncludeIt:=True:C214
$BuildApp.SourcesFiles.CS.ServerIncludeIt:=True:C214

$BuildApp.findLicenses(["4DDP"; "4UUD"])

//$BuildApp.DataFilePath:=Data file
$BuildApp.BuildApplicationName:="TEST"

//%W-550.12
$BuildApp.findCertificates("name == :1 and kind == :2"; "@miyako@"; "Developer ID Application")
//%W+550.12

$BuildApp.CS.BuildServerApplication:=True:C214
$BuildApp.CS.ServerStructureFolderName:="GEORGIA"
$BuildApp.CS.ClientServerSystemFolderName:="ATLANTA"

$BuildApp.SignApplication.MacSignature:=True:C214
$BuildApp.AdHocSign:=False:C215

$fileName:="BuildApp-"+Replace string:C233(String:C10(Current date:C33; ISO date:K1:8; Current time:C178); ":"; "-"; *)+".4DSettings"
$buildProject:=Folder:C1567("/LOGS/").file($fileName)

$BuildApp.toFile($buildProject)

If (False:C215)
	BUILD APPLICATION:C871($buildProject.platformPath)
Else 
	$compileProject:=File:C1566(Structure file:C489; fk platform path:K87:2)
	$CLI:=cs:C1710.BuildApp_CLI.new()
	$CLI.clean($compileProject)
	$CLI.compile($compileProject)
	$CLI.build($buildProject; $compileProject)
End if 