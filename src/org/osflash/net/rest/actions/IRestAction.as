package org.osflash.net.rest.actions
{
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.parameters.RestParameter;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.variables.RestVariable;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestAction
	{
		
		function onActionData(data : *, responseHeaders : Array = null) : void;
		
		function onActionStatus(status : int) : void;

		function onActionError(error : RestError) : void;

		function get type() : RestActionType;
		
		function get mimeType() : HTTPMIMEType;
		function set mimeType(value : HTTPMIMEType) : void;
		
		function get service() : IRestService;
		
		function get variables() : Vector.<RestVariable>;
		function get parameters() : Vector.<RestParameter>;
	}
}
