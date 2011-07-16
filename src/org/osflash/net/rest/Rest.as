package org.osflash.net.rest
{
	import org.osflash.net.rest.services.IRestService;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class Rest
	{
		
		public function Rest()
		{
		}
		
		public function add(service : IRestService) : IRestService
		{
			return service;
		}
		
		public function remove(service : IRestService) : IRestService
		{
			return service;
		}
		
		public function contains(service : IRestService) : Boolean
		{
			return false;
		}
	}
}
