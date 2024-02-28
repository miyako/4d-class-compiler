//%attributes = {}
$buildProject:=File:C1566("/Users/miyako/Library/Application Support/4D/BuildApp/Logs/BuildApp-2024-02-16T14-25-12.4DSettings")
$compileProject:=File:C1566("/Users/miyako/Documents/GitHub/4d-topic-cicd/application/Project/application.4DProject")

var $CLI : cs:C1710.BuildApp_CLI

$CLI:=cs:C1710.BuildApp_CLI.new()

$CLI.compile($compileProject)

$CLI.build($buildProject; $compileProject)