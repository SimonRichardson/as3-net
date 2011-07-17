package org.osflash.net.rest.services.echo
{
	import org.osflash.net.rest.actions.IRestAction;
	import org.osflash.net.rest.actions.echo.EchoAction;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.RestService;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class EchoService extends RestService implements IRestService
	{
		
		/**
		 * @private
		 */
		private var _action : EchoAction;
		
		public function EchoService(value : String)
		{
			_action = new EchoAction();
			_action.parameter.value = value;
		}
		
		public function response() : String
		{
			return '';
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
