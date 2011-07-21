package org.osflash.net.rest.actions.echo
{
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.actions.RestActionGet;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.parameters.RestUtfParameter;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.echo.EchoService;

	import flash.system.System;

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
			switch(mimeType)
			{
				case HTTPMIMEType.TEXT_XML:
					try
					{
						const xml : XML = new XML(data);
						_service.data = xml.child('response');
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
				case HTTPMIMEType.TEXT_HTML:
					try
					{
						const html : XML = new XML(data);
						const htmlBody : XMLList = html.child('body');
						const htmlH1 : XMLList = htmlBody.child('h1');
						
						_service.data = htmlH1.child('span').(@id=='response');
					}
					catch (error : Error)
					{
						throw new RestError('Invalid response for MIME Type (html)');
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
		
		public function get parameter() : RestUtfParameter { return _parameter; }
	}
}
