//%attributes = {}
$buildProject:=Folder:C1567(fk database folder:K87:14).file("tests/DatabaseToEmbedInClient.4DSettings")
$compileProject:=File:C1566(Structure file:C489; fk platform path:K87:2).parent.parent.parent.parent.file("Advanced Options for the Application Builder/example/Project/example.4DProject")

If (True:C214)
	
	var $platform : Text
	
	$platform:=(Is macOS:C1572 ? "Mac" : "Win")
	$appExtension:=(Is macOS:C1572 ? ".app" : "")
	$iconExtension:=(Is macOS:C1572 ? ".icns" : ".ico")
	
	If (Is Windows:C1573)
		$appFolder:=Folder:C1567(fk applications folder:K87:20).parent.folder("Program Files").folder("4D")
	Else 
		$appFolder:=Folder:C1567(fk applications folder:K87:20)
	End if 
	
	var $CLI : cs:C1710.BuildApp_CLI
	
	$CLI:=cs:C1710.BuildApp_CLI.new()
	
	var $BuildApp : cs:C1710.BuildApp
	
	$BuildApp:=cs:C1710.BuildApp.new($buildProject)
	
	$BuildDestFolder:="Build"+$platform+"DestFolder"
	$BuildApp[$BuildDestFolder]:=Folder:C1567(fk desktop folder:K87:19).platformPath
	
	$platformIcon:=File:C1566(Structure file:C489; fk platform path:K87:2).parent.parent.parent.file("BuildApp/Resources/BuildApp"+$iconExtension).platformPath
	
	$ServerFolder:="Server"+$platform+"Folder"
	$BuildApp.SourcesFiles.CS[$ServerFolder]:=$appFolder.file("4D v20.1/4D Server"+$appExtension).platformPath
	
	$ClientFolder:="Client"+$platform+"FolderTo"+$platform
	$BuildApp.SourcesFiles.CS[$ClientFolder]:=$appFolder.file("4D v20.1/4D Volume Desktop"+$appExtension).platformPath
	
	$ServerIconPath:="ServerIcon"+$platform+"Path"
	$BuildApp.SourcesFiles.CS[$ServerIconPath]:=$platformIcon
	
	$ClientIconFolder:="Client"+$platform+"IconFor"+$platform+"Path"
	$BuildApp.SourcesFiles.CS[$ClientIconFolder]:=$platformIcon
	
	$ClientIncludeIt:="Client"+$platform+"IncludeIt"
	$BuildApp.SourcesFiles.CS[$ClientIncludeIt]:=True:C214
	
	$DatabaseToEmbedInClient:="DatabaseToEmbedInClient"+$platform+"Folder"
	$DatabaseToEmbed:=File:C1566(Structure file:C489; fk platform path:K87:2).parent.parent.parent.file("Compiled Database/example-startup").platformPath
	$BuildApp.SourcesFiles.CS[$DatabaseToEmbedInClient]:=$DatabaseToEmbed
	
	//$BuildApp.CS.MacCompiledDatabaseToWinIncludeIt:=True
	//$BuildApp.CS.MacCompiledDatabaseToWin:=File(Structure file; fk platform path).parent.parent.parent.folder("Compiled Database/example").platformPath
	
	$BuildApp.findCertificates("name == :1 and kind == :2"; "@miyako@"; "Developer ID Application")
	$BuildApp.SignApplication.MacSignature:=True:C214
	$BuildApp.AdHocSign:=False:C215
	
	$fileName:="BuildApp-"+Replace string:C233(String:C10(Current date:C33; ISO date:K1:8; Current time:C178); ":"; "-"; *)+".4DSettings"
	
	$buildProject:=Folder:C1567("/LOGS/").file($fileName)
	
	$BuildApp.toFile($buildProject)
	
End if 

$CLI.compile($compileProject)

$CLI.build($buildProject; $compileProject)