# _XmlParser

`_XmlParser` is a base class for utility XML parsers.

## .setIntValue() 

**.setIntValue**($dom : Text; $path : Text; $intValue : Integer)

Specify an attribute using XPath followed by `@` and an attribute name. 

## .getBoolValue() 

**.getBoolValue**($dom : Text; $path : Text)->$boolValue : Variant

Returns `Null` if the attribute does not exist.

## .getStringValue() 

**.getStringValue**($dom : Text; $path : Text)->$stringValue : Variant

Returns `Null` if the attribute does not exist.

