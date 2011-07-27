package org.osflash.net.http.debug.monitor.adapters
{
	import org.osflash.debug.monitor.adapters.IMonitorAdapter;
	import org.osflash.net.http.queues.HTTPBulkQueue;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.net_namespace;

	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPBulkQueueMonitorAdapter implements IMonitorAdapter
	{

		use namespace net_namespace;

		/**
		 * @private
		 */
		private var _queue : HTTPBulkQueue;
		
		public function HTTPBulkQueueMonitorAdapter(loader : HTTPBulkQueue)
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			
			_queue = loader;
		}

		/**
		 * @inheritDoc
		 */
		public function get active() : int 
		{ 
			var num : int = 0;
			
			var index0 : int = _queue.queues.length;
			while(--index0 > -1)
			{
				const queue0 : IHTTPQueue = _queue.queues[index0];
				
				if(queue0 is HTTPQueue) num += (null != HTTPQueue(queue0).active) ? 1 : 0;
				else if(queue0 is HTTPBulkQueue)
				{
					const queues : Vector.<IHTTPQueue> = HTTPBulkQueue(queue0).queues;
					
					var index1 : int = queues.length;
					while(--index1 > -1)
					{
						const queue1 : IHTTPQueue = queues[index1];
						if(queue1 is HTTPQueue) num += (null != HTTPQueue(queue1).active) ? 1 : 0;
						else throw new IllegalOperationError('Unsupported loader found');
					}
				}
				else throw new IllegalOperationError('Unsupported loader found');
			}
			
			return num; 
		}

		/**
		 * @inheritDoc
		 */
		public function get free() : int 
		{ 
			var num : int = 0;
			
			var index : int = _queue.queues.length;
			while(--index > -1)
			{
				const queue : IHTTPQueue = _queue.queues[index];
				if(queue is HTTPQueue) num += HTTPQueue(queue).queue.length;
				else if(queue is HTTPBulkQueue) num += HTTPBulkQueue(queue).queues.length;
				else throw new IllegalOperationError('Unsupported loader found');
			}
			
			return num; 
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _queue.length; }
	}
}
