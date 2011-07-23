package org.osflash.net.http.loaders
{
	import org.osflash.net.http.cache.IHTTPCacheItem;
	import org.osflash.net.http.cache.HTTPCacheItem;
	import org.osflash.net.http.cache.IHTTPCache;
	import org.osflash.logger.utils.getDefaultLogger;
	import org.osflash.logger.logs.debug;
	import org.osflash.logger.logs.error;
	import org.osflash.logger.logs.info;
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.net_namespace;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPURLLoader extends HTTPBaseLoader implements IHTTPLoader
	{
		
		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _loader : URLLoader;

		/**
		 * @private
		 */
		private var _request : URLRequest;
		
		/**
		 * @private
		 */
		private var _cacheItem : IHTTPCacheItem;

		public function HTTPURLLoader(loader : URLLoader, request : URLRequest)
		{
			super(loader);
			
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(null == request) throw new ArgumentError('Request can not be null');
			
			_loader = loader;
			_request = request;
		}
		
		public static function fromURL(uri : String) : HTTPURLLoader
		{
			return new HTTPURLLoader(new URLLoader(), new URLRequest(uri));
		}
		
		public static function fromURLRequest(request : URLRequest) : HTTPURLLoader
		{
			return new HTTPURLLoader(new URLLoader(), request);
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
				register();
				
				startSignal.dispatch(this);
				
				_loader.load(request);
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
				
				try
				{
					if (_loader.data is String)
					{
						debug(indent(new XML(String(_loader.data)).toXMLString()));
					}
	                else if (_loader.data is XML)
					{
						debug(indent(XML(_loader.data).toXMLString()));
					}
					else
					{
						debug("\t(Unknown)", _loader.data);
					}
				}
	            catch (e : Error)
				{
					error(e);
				}
			}
			
			if(null != _cacheItem) _cacheItem.content = _loader.data;
			
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
		
		/**
		 * @private
		 */
		private function indent(value : String) : String 
		{
			const lines : Array = value.split("\n");
			
			var index : int = lines.length;
			while (--index > -1)
			{
                lines[index] = "\t" + String(lines[index]);
			}
			return lines.join("\n");
		}
		
		public function get loader() : URLLoader { return _loader; }
		
		public function get request() : URLRequest { return _request; }
		
		/**
		 * @inheritDoc
		 */	
		override public function get content() : * 
		{
			// Return the cached response as the loader might be gc'd?
			if(null != cache && null != _cacheItem && null != _cacheItem.content) 
				return _cacheItem.content;
			else return _loader.data; 
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function get responseHeaders() : Array { return null; }
		
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
	}
}
