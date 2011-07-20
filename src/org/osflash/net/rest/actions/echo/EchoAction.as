package org.osflash.net.rest.actions.echo
{
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.actions.RestActionGet;
	import org.osflash.net.rest.parameters.RestUtfParameter;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class EchoAction extends RestActionGet
	{
		
		/**
		 * @private
		 */
		private var _parameter : RestUtfParameter;

		public function EchoAction(service : IRestService)
		{
			super(service);
			
			_parameter = new RestUtfParameter();
		}
		
		public function get parameter() : RestUtfParameter { return _parameter; }
	}
}
