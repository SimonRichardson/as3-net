package org.osflash.net.rest.output.http
{
	import flash.net.URLRequestHeader;
	import org.osflash.net.rest.output.utils.buildURI;
	import flash.net.URLRequestMethod;
	import org.osflash.net.rest.actions.IRestAction;
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.http.loaders.HTTPURLLoader;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.loaders.signals.HTTPLoaderObserver;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.RestHost;
	import org.osflash.net.rest.actions.RestActionType;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.output.IRestOutput;
	import org.osflash.net.rest.services.IRestService;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
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
		private var _host : RestHost;

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
			_observer.httpStatusSignal.add(handleHTTPStatusSignal);
			_observer.completeSignal.add(handleCompleteSignal);
			_observer.ioErrorSignal.add(handleIOErrorSignal);
			_observer.securityErrorSignal.add(handleSecurityErrorSignal);
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
			if(null == service.action) throw new ArgumentError('Service Action can not be null');
			if(null == host) throw new RestError('RestHost can not be null');
			
			const action : IRestAction = service.action;
			
			const uri : String = buildURI(_host.baseURI, service.name, action.parameters);
			
			const urlLoader : URLLoader = new URLLoader();
			const urlRequest : URLRequest = new URLRequest(uri);
			
			const requestHeaders : Array = [];
			
			switch(action.type)
			{
				case RestActionType.PUT:
					requestHeaders.push(new URLRequestHeader('X-HTTP-Method-Override', 'PUT'));
					break;
				case RestActionType.DELETE:
					requestHeaders.push(new URLRequestHeader('X-HTTP-Method-Override', 'DELETE'));
					break;
			}
			
			urlRequest.requestHeaders = requestHeaders;
			urlRequest.method = action.type == RestActionType.GET ? 
																URLRequestMethod.GET : 
																URLRequestMethod.POST; 
			
			const loader : IHTTPLoader = new HTTPURLLoader(urlLoader, urlRequest);
			loader.registerObservable(_observer);
			
			// Assign to the service to the loader
			_loaders[service] = loader;
			_services[loader] = service;
			
			_queue.add(loader);
		}
		
		protected function remove(loader : IHTTPLoader) : void
		{
			if(null != _services[loader])
			{
				const service : IRestService = _services[loader] as IRestService;
				
				loader.unregisterObservable(_observer);
				
				_loaders[service] = null;
				delete _loaders[service];
				
				_services[loader] = null;
				delete _services[loader];
			}
			else throw new RestError('Unable to locate the loader');
		}
		
		protected function handleHTTPStatusSignal(	loader : IHTTPLoader, 
													event : HTTPStatusEvent
													) : void
		{
			if(null != _services[loader])
			{
				const service : IRestService = _services[loader] as IRestService;
				if(null == service) throw new RestError('Service can not be null');
				if(null == service.action) throw new RestError('Service Action can not be null');
				
				const status : int = event.status;
				if(	status >= HTTPStatusCode.BAD_REQUEST && 
					status < HTTPStatusCode.INTERNAL_SERVER_ERROR
					)
				{	
					service.action.onActionStatus(status);
				}
			}
			else throw new RestError('Unable to locate the loader');
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
						service.action.onActionData(loader.content);
						break;
				}
				
				remove(loader);
			}
			else throw new RestError('Unable to locate the loader');
		}
		
		protected function handleIOErrorSignal(loader : IHTTPLoader, event : IOErrorEvent) : void
		{
			if(null != _services[loader])
			{
				const service : IRestService = _services[loader] as IRestService;
				if(null == service) throw new RestError('Service can not be null');
				if(null == service.action) throw new RestError('Service Action can not be null');
				
				service.action.onActionError(new RestError(event.text));
				
				remove(loader);
			}
			else throw new RestError('Unable to locate the loader');
		}
		
		protected function handleSecurityErrorSignal(	loader : IHTTPLoader,
														event : SecurityError
														) : void
		{
			if(null != _services[loader])
			{
				const service : IRestService = _services[loader] as IRestService;
				if(null == service) throw new RestError('Service can not be null');
				if(null == service.action) throw new RestError('Service Action can not be null');
				
				service.action.onActionError(new RestError(event.message));
				
				remove(loader);
			}
			else throw new RestError('Unable to locate the loader');
		}
		
		/**
		 * @inheritDoc
		 */
		public function get host() : RestHost { return _host; }
		public function set host(value : RestHost) : void { if(_host != value) _host = value; }
	}
}
