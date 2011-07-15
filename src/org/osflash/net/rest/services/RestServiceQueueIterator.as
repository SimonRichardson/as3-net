package org.osflash.net.rest.services
{
	import org.osflash.net.net_namespace;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestServiceQueueIterator
	{
		/**
		 * @private
		 */
		private var _cursor : int;
		
		/**
		 * @private
		 */
		private var _queue : RestServiceQueue;
		
		/**
		 * @private
		 */
		private var _services : Vector.<IRestService>;
		
		public function RestServiceQueueIterator(	queue : RestServiceQueue,
													services : Vector.<IRestService>
													)
		{
			if(null == queue) throw new ArgumentError('Queue can not be null');
			if(null == services) throw new ArgumentError('Services can not be null');
			
			_cursor = 0;
			
			_queue = queue;
			_queue.active = true;
			
			_services = services;
		}
		
		public function get hasNext() : Boolean
		{
			return _cursor < _services.length;
		}
		
		public function get next() : IRestService
		{
			if(_cursor >= _services.length) throw new RangeError('Index out of range');
			
			const service : IRestService = _services[_cursor];
			
			_cursor++;
			
			return service;
		}
		
		net_namespace function get queue() : RestServiceQueue { return _queue; }
		
		net_namespace function get length() : int { return _queue.length; }
	}
}
