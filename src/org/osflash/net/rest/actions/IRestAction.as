package org.osflash.net.rest.actions
{

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestAction
	{
		
		function onActionData(data : *) : void;
		
		function onActionError(error : int) : void;

		function get type() : RestActionType;
	}
}
