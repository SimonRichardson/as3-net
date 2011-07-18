package org.osflash.net.rest.output.http
{
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
		
		public function RestHTTPOutput(queue : IHTTPQueue)
		{
			if(null == queue) throw new ArgumentError('Queue can not be null');
			_queue = queue;
		}

		public function close() : void
		{
		}

		public function execute(service : IRestService) : void
		{
			
		}
	}
}
