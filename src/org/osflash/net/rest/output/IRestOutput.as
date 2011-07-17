package org.osflash.net.rest.output
{
	import org.osflash.net.rest.services.IRestService;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestOutput
	{
		
		function close() : void;
		
		function execute(service : IRestService) : void;
	}
}
