package org.osflash.net.rest.output.http
{
	import org.osflash.net.http.loaders.HTTPURLLoader;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.loaders.signals.HTTPLoaderObserver;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.actions.IRestActionGet;
	import org.osflash.net.rest.actions.RestActionType;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.output.IRestOutput;
	import org.osflash.net.rest.services.IRestService;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
		private var _observer : HTTPLoaderObserver;
		
		/**
		 * @private
		 */
		private var _loaders : Dictionary;
		
		/**
		 * @private
		 */
		private var _services : Dictionary;

		public function RestHTTPOutput(queue : IHTTPQueue)
		{
			if (null == queue) throw new ArgumentError('Queue can not be null');

			_queue = queue;
			
			_loaders = new Dictionary();
			_services = new Dictionary();
			
			_observer = new HTTPLoaderObserver();
			_observer.completeSignal.add(handleCompleteSignal);
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
				
				_services[loader] = null;
				delete _services[loader];
				
				_loaders[key] = null;
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
			
			const loader : IHTTPLoader = new HTTPURLLoader(urlLoader, urlRequest);
			loader.registerObservable(_observer);
			
			// Assign to the service to the loader
			_loaders[service] = loader;
			_services[loader] = service;
			
			_queue.add(loader);
		}
		
		protected function handleCompleteSignal(loader : IHTTPLoader, event : Event) : void
		{
			if(null != _services[loader])
			{
				const service : IRestService = _services[loader] as IRestService;
				if(null == service) throw new RestError('Service can not be null');
				if(null == service.action) throw new RestError('Service Action can not be null');
				
				switch(service.action.type)
				{
					case RestActionType.GET:
						const actionGet : IRestActionGet = service.action as IRestActionGet;
						actionGet.onActionData(loader.content);
						break;
				}
				
				loader.unregisterObservable(_observer);
				
				_loaders[service] = null;
				delete _loaders[service];
				
				_services[loader] = null;
				delete _services[loader];
			}
			else
			{
				throw new RestError('Unable to locate the loader');
			}
		}
	}
}
