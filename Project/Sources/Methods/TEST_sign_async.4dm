//%attributes = {"invisible":true}
#DECLARE($signal : 4D:C1709.Signal)

/*

Sign the specified application in a dedicated worker. The log is printed to the standard output stream.

*/

If (Count parameters:C259=0)
	
	$signal:=New signal:C1641
	
	CALL WORKER:C1389("signApp"; Current method name:C684; $signal)
	
	$signal.wait()
	
Else 
	
	$appExtension:=(Is macOS:C1572 ? ".app" : "")
	
	var $SignApp : cs:C1710.SignApp
	
	$application:=Folder:C1567(fk desktop folder:K87:19).folder("Final Application/application"+$appExtension)
	$SignApp:=cs:C1710.SignApp.new(cs:C1710.SignApp_Controller; $signal)
	
	$SignApp.signAsync($application)
	
End if 