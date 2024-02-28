//%attributes = {"invisible":true,"shared":true}
If (Get application info:C1599.headless)
	
	var $CLI : cs:C1710.BuildApp_CLI
	
	$CLI:=cs:C1710.BuildApp_CLI.new()
	
	$CLI.logo().version()
	
	ON ERR CALL:C155(Formula:C1597(generic_error_handler).source)
	
	$CLI.LF()
	
	If (Is compiled mode:C492)
		$CLI.print("application must not be running in compiled mode!"; "red;bold").LF()
	Else 
		
		var $applicationType : Text
		$applicationType:=Choose:C955(Application type:C494; "4D Local mode"; "4D Volume desktop"; ""; "4D Desktop"; "4D Remote mode"; "4D Server"; "tool4d")
		
		$CLI.print("Application type"; "bold").print("...")
		$CLI.print($applicationType; "82;bold").LF()
		
		var $userParamValue : Text
		$param:=Get database parameter:C643(User param value:K37:94; $userParamValue)
		
		Case of 
			: ($userParamValue="")
				$CLI.print("--user-param is missing!"; "red;bold").LF()
			Else 
				
				If ($applicationType#"4D Local mode")
					$CLI.print("Application type must be 4D Local mode!"; "red;bold").LF()
				Else 
					
					var $buildProject : 4D:C1709.File
					var $buildDestinationPath : Text
					
					$paths:=Split string:C1554($userParamValue; ","; sk trim spaces:K86:2 | sk ignore empty strings:K86:1)
					
					For each ($path; $paths)
						
						Case of 
							: (New collection:C1472(".xml"; ".4DSettings").includes(Path to object:C1547($path).extension))
								$buildProject:=File:C1566($path; fk posix path:K87:1)
								$buildProject:=$buildProject.exists ? $buildProject : File:C1566($path; fk platform path:K87:2)
							Else 
								$buildDestinationPath:=$path
						End case 
					End for each 
					
					If ($buildProject=Null:C1517)
						$buildProject:=File:C1566(Build application settings file:K5:60)
					End if 
					
					If ($buildProject=Null:C1517)
						$CLI.print("Build project path is invalid!"; "red;bold").LF()
					Else 
						
						$originalBuildProject:=$buildProject
						
						If ($buildDestinationPath#"")
							
							var $BuildApp : cs:C1710.BuildApp
							$BuildApp:=cs:C1710.BuildApp.new($buildProject)
							
							$CLI._setDestination($BuildApp; $buildDestinationPath)
							
							$tempFolder:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).folder(Generate UUID:C1066)
							$tempFolder.create()
							
							$buildProject:=$tempFolder.file("buildApp.4DSettings")
							
							$BuildApp.toFile($buildProject)
							
						End if 
						
						$CLI.print("Build application"; "bold").print("...")
						
						BUILD APPLICATION:C871($buildProject.platformPath)
						
						If (OK=1)
							$CLI.print("success"; "82;bold").LF()
						Else 
							$CLI.print("failure"; "196;bold").LF()
						End if 
						
						$CLI.print($originalBuildProject.path; "244").LF()
						
						var $buildLog : Text
						$buildLog:=File:C1566(Build application log file:K5:46).getText("utf-8"; Document with CR:K24:21)
						
						$dom:=DOM Parse XML variable:C720($buildLog)
						
						var $stringValue : Text
						
						If (OK=1)
							ARRAY TEXT:C222($MessageTypes; 0)
							$MessageType:=DOM Find XML element:C864($dom; "/BuildApplicationLog/Log/MessageType[text()='Comment']"; $MessageTypes)
							
							For ($i; 1; Size of array:C274($MessageTypes))
								$MessageType:=$MessageTypes{$i}
								$Message:=DOM Find XML element:C864($MessageType; "../Message")
								DOM GET XML ELEMENT VALUE:C731($Message; $stringValue)
								$CLI.print($stringValue; "39").LF()
								$CodeDesc:=DOM Find XML element:C864($MessageType; "../CodeDesc")
								DOM GET XML ELEMENT VALUE:C731($CodeDesc; $stringValue)
								$CLI.print($stringValue+" "; "244")
								$CodeId:=DOM Find XML element:C864($MessageType; "../CodeId")
								DOM GET XML ELEMENT VALUE:C731($CodeId; $stringValue)
								$CLI.print("("+$stringValue+")"; "244").LF()
							End for 
							
							DOM CLOSE XML:C722($dom)
						End if 
						
					End if 
					
				End if 
				
		End case 
		
	End if 
	
	ON ERR CALL:C155("")
	
	If (Application type:C494#6)  //unlike tool4d, 4D doesn't quit automatically
		QUIT 4D:C291
	End if 
	
End if 