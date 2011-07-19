package org.osflash.net.http.loaders
{
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.net_namespace;

	import flash.display.Loader;
	import flash.net.URLRequest;
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
		
		public function HTTPLoader(loader : Loader, request : URLRequest, context : LoaderContext)
		{
			super(loader.contentLoaderInfo);
			
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(null == request) throw new ArgumentError('Request can not be null');
			
			_loader = loader;
			_request = request;
			_context = context;
		}

		/**
		 * @inheritDoc
		 */
		override public function start(queue : IHTTPQueue) : void
		{
			super.start(queue);
			
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
			catch (error : Error) { }
			
			stopSignal.dispatch(this);
		}
		
		public function get request() : URLRequest { return _request; }
		
		public function get context() : LoaderContext { return _context; }
	}
}
