package org.osflash.net.http.loaders
{
	import org.osflash.logger.logs.error;
	import org.osflash.logger.logs.info;
	import org.osflash.logger.utils.getDefaultLogger;
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.http.cache.HTTPCacheItem;
	import org.osflash.net.http.cache.IHTTPCache;
	import org.osflash.net.http.cache.IHTTPCacheItem;
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
		
		/**
		 * @private
		 */
		private var _cacheItem : IHTTPCacheItem;
		
		/**
		 * @private
		 */
		private var _possibleCachedContent : Boolean;
		
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
			
			_possibleCachedContent = false;
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
			
			if(null != _cacheItem && null != _cacheItem.content) 
			{
				if(getDefaultLogger().enabled)
				{
					info("Cache response", _request.url, "(" + _request.method + ")");
				}
				
				_possibleCachedContent = true;
				
				// Response back with a successful sequence.
				startSignal.dispatch(this);
				handleHTTPStatusSignal(new HTTPStatusEvent(	HTTPStatusEvent.HTTP_STATUS,
															false,
															false, 
															HTTPStatusCode.NOT_MODIFIED
															));
				completeSignal.dispatch(this, new Event(Event.COMPLETE));
			}
			else
			{
				_possibleCachedContent = false;
				
				register();
			
				startSignal.dispatch(this);
			
				_loader.load(request, context);
			}
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
			
			if(null != _cacheItem) _cacheItem.content = _loader.content;
			
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
			
			if(null != _cacheItem) _cacheItem.status = event.status;
			
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
			
			if(null != _cacheItem) _cacheItem.content = null;
			
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
			
			if(null != _cacheItem) _cacheItem.content = null;
			
			super.handleSecurityErrorSignal(event);
		}
		
		public function get loader() : Loader { return _loader; }
		
		public function get request() : URLRequest { return _request; }
		
		public function get context() : LoaderContext { return _context; }
		
		/**
		 * @inheritDoc
		 */	
		override public function get content() : * 
		{
			// Return the cached response as the loader might be gc'd?
			if(null != _cacheItem && null != _cacheItem.content) return _cacheItem.content;
			else return _loader.content; 
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function set cache(value : IHTTPCache) : void
		{
			// Remove any previous cache item
			if(null != cache && null != _cacheItem && cache.contains(_cacheItem))
				cache.remove(_cacheItem);
			
			// Set the new cache
			super.cache = value;
			
			// Add it to the new cache
			if(null != cache) 
			{
				if(null == _cacheItem) cache.add(_cacheItem = new HTTPCacheItem(request.url));
				else cache.add(_cacheItem);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get cachedContent() : Boolean
		{
			if(null == cache) return false;
			else return _possibleCachedContent && null != _cacheItem.content;
		}
	}
}
