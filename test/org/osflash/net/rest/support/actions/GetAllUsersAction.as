package org.osflash.net.rest.support.actions
{
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.RestActionGet;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.support.User;
	import org.osflash.net.rest.support.services.GetAllUsersService;

	import flash.system.System;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class GetAllUsersAction extends RestActionGet
	{

		use namespace net_namespace;
		/**
		 * @private
		 */
		private var _service : GetAllUsersService;

		public function GetAllUsersAction(service : IRestService)
		{
			super(service);

			_service = GetAllUsersService(service);
		}

		/**
		 * @inheritDoc
		 */
		override public function onActionData(data : *) : void
		{
			const users : Vector.<User> = new Vector.<User>();
			
			switch(mimeType)
			{
				case HTTPMIMEType.TEXT_XML:
					try
					{
						const xml : XML = new XML(data);
						const rows : XMLList = xml.child('row');
						for each(var row : XML in rows)
						{
							const userId : int = parseInt(row.text());
							const user : User = new User(userId);
							
							users.push(user);
						}
						
						_service.data = users;
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
	}
}
