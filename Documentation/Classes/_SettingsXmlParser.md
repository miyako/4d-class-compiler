# _SettingsXmlParser : _XmlParser

`_SettingsXmlParser` is a subclass of `_XmlParser` to retreive build-related information from a project's settings.

## .parse() 

**.parse**() : Object

The returned object contains the following properties:

|Property|Type|Description|
|:-|:-|:-|
|sdi_application|Boolean||
|allow_user_settings|Boolean||

## .setPortNumber() 

**.setPortNumber**($projectFile : 4D.File; $portNumber : Integer) 

Locates the `/SOURCES/settings.4DSettings` file related to the specified project and changes the application server port number.