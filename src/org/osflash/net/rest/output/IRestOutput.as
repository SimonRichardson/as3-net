package org.osflash.net.rest.output
{
	import org.osflash.net.rest.RestHost;
	import org.osflash.net.rest.services.IRestService;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IRestOutput
	{
		
		function close() : void;
		
		function execute(service : IRestService) : void;
		
		function get host() : RestHost;
		function set host(value : RestHost) : void;
	}
}
