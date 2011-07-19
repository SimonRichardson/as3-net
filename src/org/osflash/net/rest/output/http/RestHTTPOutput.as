package org.osflash.net.rest.output.http
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.output.IRestOutput;
	import org.osflash.net.rest.services.IRestService;

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
		private var _loaders : Vector.<IHTTPLoader>;

		public function RestHTTPOutput(queue : IHTTPQueue)
		{
			if (null == queue) throw new ArgumentError('Queue can not be null');

			_queue = queue;
			
			_loaders = new Vector.<IHTTPLoader>();
		}

		/**
		 * @inheritDoc
		 */
		public function close() : void
		{
			var index : int = _loaders.length;
			while(--index > -1)
			{
				const loader : IHTTPLoader = _loaders.pop();
				if(_queue.contains(loader)) _queue.remove(loader);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function execute(service : IRestService) : void
		{
			
		}
	}
}
