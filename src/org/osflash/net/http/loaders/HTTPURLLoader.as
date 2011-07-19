package org.osflash.net.http.loaders
{
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.net_namespace;

	import flash.net.URLLoader;
	import flash.net.URLRequest;
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

		public function HTTPURLLoader(loader : URLLoader, request : URLRequest)
		{
			super(loader);
			
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(null == request) throw new ArgumentError('Request can not be null');
			
			_loader = loader;
			_request = request;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function start(queue : IHTTPQueue) : void
		{
			super.start(queue);
			
			register();
			
			startSignal.dispatch(this);
			
			_loader.load(request);
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
			catch (error : Error) { }
			
			stopSignal.dispatch(this);
		}
		
		public function get loader() : URLLoader { return _loader; }
		
		public function get request() : URLRequest { return _request; }
		
		override public function get content() : * { return _loader.data; }
	}
}
