package org.osflash.net.rest.services.echo
{
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.IRestAction;
	import org.osflash.net.rest.actions.echo.EchoAction;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.RestService;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class EchoService extends RestService implements IRestService
	{

		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _data : String;
		
		/**
		 * @private
		 */
		private var _action : EchoAction;
		
		public function EchoService(value : String, mimeType : HTTPMIMEType = null)
		{
			_action = new EchoAction(this);
			_action.parameter.value = value;
			
			if(null != mimeType) _action.mimeType = mimeType;
		}
		
		public function get response() : String
		{
			return _data;
		}

		net_namespace function set data(value : String) : void
		{
			_data = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get name() : String { return 'echo'; }
		
		/**
		 * @inheritDoc
		 */
		override public function get action() : IRestAction { return _action; }
	}
}
