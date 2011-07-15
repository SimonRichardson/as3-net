package org.osflash.net.rest.services
{
	import org.osflash.net.rest.actions.IRestAction;
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestService
	{
		
		function get name() : String;
		
		function get action() : IRestAction;
		
		function get errorSignal() : ISignal;
		
		function get completedSignal() : ISignal;
	}
}
