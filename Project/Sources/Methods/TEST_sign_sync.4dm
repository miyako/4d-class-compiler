//%attributes = {"invisible":true}
/*

Sign the specified application. The log is generated in /LOGS/SignApp-{timestamp}.log.

*/

$appExtension:=(Is macOS:C1572 ? ".app" : "")

var $SignApp : cs:C1710.SignApp

$application:=Folder:C1567(fk desktop folder:K87:19).folder("Final Application/application"+$appExtension)
$SignApp:=cs:C1710.SignApp.new(cs:C1710.SignApp_Controller)

$SignApp.sign($application)

$logFile:=$SignApp.logFile