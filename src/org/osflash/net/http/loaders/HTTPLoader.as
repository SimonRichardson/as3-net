package org.osflash.net.http.loaders
{
	import org.osflash.logger.logs.error;
	import org.osflash.logger.logs.info;
	import org.osflash.logger.utils.getDefaultLogger;
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.net_namespace;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import flash.system.LoaderContext;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPLoader extends HTTPBaseLoader implements IHTTPLoader
	{

		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _loader : Loader;

		/**
		 * @private
		 */
		private var _request : URLRequest;

		/**
		 * @private
		 */
		private var _context : LoaderContext;
		
		public function HTTPLoader(	loader : Loader, 
									request : URLRequest, 
									context : LoaderContext = null
									)
		{
			super(loader.contentLoaderInfo);
			
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(null == request) throw new ArgumentError('Request can not be null');
			
			_loader = loader;
			_request = request;
			_context = context;
		}
		
		public static function fromURL(uri : String) : HTTPLoader
		{
			return new HTTPLoader(new Loader(), new URLRequest(uri));
		}
		
		public static function fromURLRequest(request : URLRequest) : HTTPLoader
		{
			return new HTTPLoader(new Loader(), request);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function start(queue : IHTTPQueue) : void
		{
			super.start(queue);
			
			if(getDefaultLogger().enabled)
			{
				info("Start loading", _request.url, "(" + _request.method + ")");
				
				var requestHeaders : Array = _request.requestHeaders;
				var n : int = requestHeaders.length;
				while (--n > -1)
				{
	                const urlRequestHeader : URLRequestHeader = requestHeaders[n];
					info("\t", urlRequestHeader.name + ":" + urlRequestHeader.value);
				}
				if (_request.data != null && _request.data is URLVariables)
				{
					const urlVariables : URLVariables = URLVariables(_request.data);
					
					for (var item : String in urlVariables)
					{
						info("\t", item + "=" + urlVariables[item]);
					}
				}
			}
			
			register();
			
			startSignal.dispatch(this);
			
			_loader.load(request, context);
		}

		/**
		 * @inheritDoc
		 */
		override public function stop() : void
		{
			unregister();
			
			try
			{
				_loader.close();
			}
			catch (e : Error) { }
			
			stopSignal.dispatch(this);
		}
		
		
		/**
		 * @inheritDoc
		 */
		override protected function handleCompleteSignal(event : Event) : void 
		{
			if(getDefaultLogger().enabled)
			{
				info("Complete:", _request.url);
			}
			
			super.handleCompleteSignal(event);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleHTTPStatusSignal(event : HTTPStatusEvent) : void 
		{
			if(getDefaultLogger().enabled)
			{
				info("Status:", _request.url, HTTPStatusCode.codeToString(event.status));
			}
			
			super.handleHTTPStatusSignal(event);
		}

		/**
		 * @inheritDoc
		 */
		override protected function handleIOErrorSignal(event : IOErrorEvent) : void 
		{
			if(getDefaultLogger().enabled)
			{
				error("IOError:", _request.url, event.text);
			}
			
			super.handleIOErrorSignal(event);
		}

		/**
		 * @inheritDoc
		 */
		override protected function handleSecurityErrorSignal(event : SecurityErrorEvent) : void 
		{
			if(getDefaultLogger().enabled)
			{
				error("SecurityError:", _request.url, event.text);
			}
			
			super.handleSecurityErrorSignal(event);
		}
		
		public function get loader() : Loader { return _loader; }
		
		public function get request() : URLRequest { return _request; }
		
		public function get context() : LoaderContext { return _context; }
		
		override public function get content() : * { return _loader.content; }
	}
}
