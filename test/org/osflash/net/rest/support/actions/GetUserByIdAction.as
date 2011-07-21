package org.osflash.net.rest.support.actions
{
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.RestActionGet;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.parameters.RestUIntParameter;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.support.User;
	import org.osflash.net.rest.support.services.GetUserByIdService;

	import flash.system.System;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class GetUserByIdAction extends RestActionGet
	{
		
		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _parameter : RestUIntParameter;
		
		/**
		 * @private
		 */
		private var _service : GetUserByIdService;

		public function GetUserByIdAction(service : IRestService)
		{
			super(service);
			
			_service = GetUserByIdService(service);
			
			parameters.push(_parameter = new RestUIntParameter());
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function onActionData(data : *) : void
		{
			switch(mimeType)
			{
				case HTTPMIMEType.TEXT_XML:
					try
					{
						const xml : XML = new XML(data);
						const uid : int = parseInt(xml.child('uid').text());
						const firstname : String = xml.child('firstname').text();
						const lastname : String = xml.child('lastname').text();
						const companyUID : int = parseInt(xml.child('company_uid').text());
						
						const user : User = new User(uid, firstname, lastname, companyUID);
						_service.data = user;
					}
					catch (error : Error)
					{
						throw new RestError('Invalid response for MIME Type (xml)');
					}
					finally
					{
						if('disposeXML' in System) System['disposeXML'](xml);
					}
					break;
				default:
					throw new RestError('Unsupported MIME Type');
					break;
			}
			
			super.onActionData(data);
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
		
		public function get parameter() : RestUIntParameter { return _parameter; }
	}
}
