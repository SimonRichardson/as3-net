package org.osflash.net.rest.actions.echo
{
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.RestActionGet;
	import org.osflash.net.rest.parameters.RestUtfParameter;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.echo.EchoService;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class EchoAction extends RestActionGet
	{
		
		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _parameter : RestUtfParameter;
		
		/**
		 * @private
		 */
		private var _service : EchoService;

		public function EchoAction(service : IRestService)
		{
			super(service);
			
			_service = EchoService(service);
			
			parameters.push(_parameter = new RestUtfParameter());
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function onActionData(data : *) : void
		{
			// TODO : do different mime types!
			const xml : XML = new XML(data);
			_service.data = xml.child('response');
			
			super.onActionData(data);
		}
		
		public function get parameter() : RestUtfParameter { return _parameter; }
	}
}
