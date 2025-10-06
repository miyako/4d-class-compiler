//%attributes = {"invisible":true}
#DECLARE($mode : Text)

If (Application info:C1599.headless)
	
/*
	
this method is designed to be executed in utility mode
https://developer.4d.com/docs/Admin/cli/#tool4d
	
*/
	
	$options:=Split string:C1554($mode; ","; sk ignore empty strings:K86:1 | sk trim spaces:K86:2)
	
	var $CLI : cs:C1710.BuildApp_CLI
	
	$CLI:=cs:C1710.BuildApp_CLI.new()
	
	$CLI.logo().version()
	
	ON ERR CALL:C155(Formula:C1597(generic_error_handler).source)
	
	$CLI.LF()
	
	var $userParamValue : Text
	$param:=Get database parameter:C643(User param value:K37:94; $userParamValue)
	$CLI._printTask("Parsing user params")
	
	Case of 
		: ($userParamValue="")
			$CLI._printStatus(False:C215)
		Else 
			$CLI._printStatus(True:C214)
			
			var $buildProject; $compileProject : 4D:C1709.File
			var $buildDestinationPath : Text
			var $volumeDesktopPath : Text
			var $serverRuntimePath : Text
			var $folder : 4D:C1709.Folder
			
			$paths:=Split string:C1554($userParamValue; ","; sk trim spaces:K86:2 | sk ignore empty strings:K86:1)
			
			For each ($path; $paths)
				$CLI.print($path; "244").LF()
				Case of 
					: (New collection:C1472(".xml"; ".4DSettings").includes(Path to object:C1547($path).extension))
						If (Is Windows:C1573)
							$buildProject:=File:C1566($path; fk platform path:K87:2)
							$buildProject:=$buildProject.exists ? $buildProject : File:C1566($path; fk posix path:K87:1)
						Else 
							$buildProject:=File:C1566($path; fk posix path:K87:1)
							$buildProject:=$buildProject.exists ? $buildProject : File:C1566($path; fk platform path:K87:2)
						End if 
					: (New collection:C1472(".json"; ".4DProject").includes(Path to object:C1547($path).extension))
						If (Is Windows:C1573)
							$compileProject:=File:C1566($path; fk platform path:K87:2)
							$compileProject:=$compileProject.exists ? $compileProject : File:C1566($path; fk posix path:K87:1)
						Else 
							$compileProject:=File:C1566($path; fk posix path:K87:1)
							$compileProject:=$compileProject.exists ? $compileProject : File:C1566($path; fk platform path:K87:2)
						End if 
					Else 
						//assume it's a folder
						If (Is Windows:C1573)
							$folder:=Folder:C1567($path; fk platform path:K87:2)
							$folder:=$folder.exists ? $folder : Folder:C1567($path; fk posix path:K87:1)
						Else 
							$folder:=Folder:C1567($path; fk posix path:K87:1)
							$folder:=$folder.exists ? $folder : Folder:C1567($path; fk platform path:K87:2)
						End if 
						Case of 
							: ($folder.name="4D Volume Desktop")
								$volumeDesktopPath:=$folder.platformPath
							: ($folder.name="4D Server")
								$serverRuntimePath:=$folder.platformPath
							Else 
								$buildDestinationPath:=$folder.platformPath
						End case 
				End case 
			End for each 
			
			If ($compileProject#Null:C1517)
				
/*
store environment for later
*/
				$BuildApp.PROJECT:=$compileProject
				
				If ($options.includes("clean"))
					$CLI.clean($compileProject)
				End if 
				
				Case of 
					: ($options.includes("compile"))
						$CLI.compile($compileProject)
						Case of 
							: ($options.includes("build-component"))  //PackProject=true,UseStandardZip=false
								$CLI.buildComponent($compileProject; $buildDestinationPath; True:C214; False:C215)
							: ($options.includes("build-component-project"))  //PackProject=false,UseStandardZip=false
								$CLI.buildComponent($compileProject; $buildDestinationPath; False:C215; False:C215)
							: ($options.includes("build-component-zip"))  //PackProject=true,UseStandardZip=true
								$CLI.buildComponent($compileProject; $buildDestinationPath; True:C214; True:C214)
						End case 
						If ($options.includes("build"))
							$CLI.build($buildProject; $compileProject; $buildDestinationPath; True:C214; $volumeDesktopPath; $serverRuntimePath)
						End if 
					: ($options.includes("build-component-source"))
						$CLI.buildDeveloperComponent($compileProject; $buildDestinationPath)
				End case 
				
			End if 
			
	End case 
	
	ON ERR CALL:C155("")
	
End if 