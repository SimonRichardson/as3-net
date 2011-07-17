package org.osflash.net.rest.actions
{

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestAction
	{

		function format() : void;

		function get type() : RestActionType;
	}
}
