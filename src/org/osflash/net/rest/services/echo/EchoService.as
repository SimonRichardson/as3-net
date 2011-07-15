package org.osflash.net.rest.services.echo
{
	import org.osflash.net.rest.services.IRestService;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class EchoService implements IRestService
	{

		public function EchoService()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function get name() : String { return 'echo'; }
	}
}
