package org.osflash.net.rest.support.services
{
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.IRestAction;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.RestService;
	import org.osflash.net.rest.support.User;
	import org.osflash.net.rest.support.actions.GetUserByIdAction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class GetUserByIdService extends RestService implements IRestService
	{

		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _data : User;
		
		/**
		 * @private
		 */
		private var _action : GetUserByIdAction;
		
		public function GetUserByIdService(value : int, mimeType : HTTPMIMEType = null)
		{
			_action = new GetUserByIdAction(this);
			_action.parameter.value = value;
			
			if(null != mimeType) _action.mimeType = mimeType;
		}
		
		public function get user() : User
		{
			return _data;
		}

		net_namespace function set data(value : User) : void
		{
			_data = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get name() : String { return 'user'; }
		
		/**
		 * @inheritDoc
		 */
		override public function get action() : IRestAction { return _action; }
	}
}
