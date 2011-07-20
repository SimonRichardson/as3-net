package org.osflash.net.rest.output.http
{
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import org.osflash.net.http.loaders.HTTPLoaderObserver;
	import org.osflash.net.http.loaders.HTTPURLLoader;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.loaders.IHTTPLoaderObserver;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.output.IRestOutput;
	import org.osflash.net.rest.services.IRestService;

	import flash.utils.Dictionary;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestHTTPOutput implements IRestOutput
	{

		/**
		 * @private
		 */
		private var _queue : IHTTPQueue;
		
		/**
		 * @private
		 */
		private var _loaders : Dictionary;

		public function RestHTTPOutput(queue : IHTTPQueue)
		{
			if (null == queue) throw new ArgumentError('Queue can not be null');

			_queue = queue;
			
			_loaders = new Dictionary();
		}

		/**
		 * @inheritDoc
		 */
		public function close() : void
		{
			// Key in this instance is a IRestService
			for(var key : * in _loaders)
			{
				const loader : IHTTPLoader = _loaders[key];
				if(null != loader)
				{
					if(_queue.contains(loader)) _queue.remove(loader);
				}
				
				_loaders[key];
				delete _loaders[key];
			}
		}

		/**
		 * @inheritDoc
		 */
		public function execute(service : IRestService) : void
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			const urlLoader : URLLoader = new URLLoader();
			const urlRequest : URLRequest = new URLRequest();
			
			const observable : IHTTPLoaderObserver = new HTTPLoaderObserver();
			
			const loader : IHTTPLoader = new HTTPURLLoader(urlLoader, urlRequest);
			loader.registerObservable(observable);
			
			// Assign to the service to the loader
			_loaders[service] = loader;
			
			_queue.add(loader);
		}
	}
}
