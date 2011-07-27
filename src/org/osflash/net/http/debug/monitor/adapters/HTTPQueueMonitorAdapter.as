package org.osflash.net.http.debug.monitor.adapters
{
	import org.osflash.debug.monitor.adapters.IMonitorAdapter;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.net_namespace;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPQueueMonitorAdapter implements IMonitorAdapter
	{

		use namespace net_namespace;

		/**
		 * @private
		 */
		private var _queue : HTTPQueue;
		
		public function HTTPQueueMonitorAdapter(loader : HTTPQueue)
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			
			_queue = loader;
		}

		/**
		 * @inheritDoc
		 */
		public function get active() : int { return null != _queue.active ? 1 : 0; }

		/**
		 * @inheritDoc
		 */
		public function get free() : int { return _queue.queue.length; }
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _queue.length; }
	}
}
