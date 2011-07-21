package org.osflash.net.rest.support.actions
{
	import org.osflash.logger.logs.debug;
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.RestActionPost;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.support.services.PostUserService;
	import org.osflash.net.rest.variables.RestUIntVariable;
	import org.osflash.net.rest.variables.RestUtfVariable;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class PostUserAction extends RestActionPost
	{
		
		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _firstname : RestUtfVariable;
		
		/**
		 * @private
		 */
		private var _lastname : RestUtfVariable;
		
		/**
		 * @private
		 */
		private var _companyUID : RestUIntVariable;
		
		/**
		 * @private
		 */
		private var _service : PostUserService;

		public function PostUserAction(service : IRestService)
		{
			super(service);
			
			_service = PostUserService(service);
			
			variables.push(_firstname = new RestUtfVariable('firstname'));
			variables.push(_lastname = new RestUtfVariable('lastname'));
			variables.push(_companyUID = new RestUIntVariable('companyuid'));
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function onActionData(data : *, responseHeaders : Array = null) : void
		{
			debug(">> ", data);
			
			switch(mimeType)
			{
				case HTTPMIMEType.TEXT_XML:
					
					break;
				default:
					throw new RestError('Unsupported MIME Type');
					break;
			}
			
			super.onActionData(data, responseHeaders);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function onActionStatus(status : int) : void
		{
			if(	status >= HTTPStatusCode.BAD_REQUEST && 
				status < HTTPStatusCode.INTERNAL_SERVER_ERROR
				)
			{
				onActionError(new RestError('Status error : ' + status));
			}
		}
		
		public function get firstname() : RestUtfVariable { return _firstname; }
		
		public function get lastname() : RestUtfVariable { return _lastname; }
		
		public function get companyUID() : RestUIntVariable { return _companyUID; }
	}
}
