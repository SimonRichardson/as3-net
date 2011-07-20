package org.osflash.net.rest.actions
{
	import org.osflash.net.rest.errors.RestError;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestAction
	{
		
		function onActionData(data : *) : void;
		
		function onActionStatus(status : int) : void;

		function onActionError(error : RestError) : void;

		function get type() : RestActionType;
	}
}
