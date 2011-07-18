package org.osflash.net.rest.services
{
	import org.osflash.net.net_namespace;
	import org.osflash.net.rest.RestManager;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestServiceExecutioner
	{
		use namespace net_namespace;
		
		/**
		 * @private
		 */
		private var _queues : Vector.<RestServiceQueue>;
		
		/**
		 * @private
		 */
		private var _queue : RestServiceQueueIterator;
		
		/**
		 * @private
		 */
		private var _manager : RestManager;
		
		/**
		 * @private
		 */
		private var _running : Boolean;
		
		/**
		 * @private
		 */
		private var _executedSignal : ISignal;
				
		public function RestServiceExecutioner(manager : RestManager)
		{
			if(null == manager) throw new ArgumentError('Manager can not be null');
			_manager = manager;
			
			_running = false;
			_queues = new Vector.<RestServiceQueue>();
		}
		
		public function add(queue : RestServiceQueue) : void
		{
			if(_queues.indexOf(queue) != -1) 
				throw new ArgumentError('RestServiceQueue already exists');
			
			_queues.push(queue);
			
			if(!_running) advance();
		}
		
		public function remove(queue : RestServiceQueue) : void
		{
			const index : int = _queues.indexOf(queue);
			if(index == -1)
				throw new ArgumentError('No such RestServiceQueue');
				
			const removed : RestServiceQueue = _queues.splice(index, 1)[0];
			if(removed != queue)
				throw new RestError('RestServiceQueue mismatch');
		}
		
		public function find(service : IRestService) : RestServiceQueue
		{
			// We do this in reverse because statistically you'll want to remove something that
			// you recently added.
			var index : int = _queues.length;
			while(--index > -1)
			{
				const queue : RestServiceQueue = _queues[index];
				if(queue.contains(service)) return queue;
			}
			
			return null;
		}
		
		/**
		 * @private
		 */
		private function execute() : void
		{
			if(_running) return;
			if(null == _queue || !_queue.hasNext)
			{
				_running = false;
				return;
			}
			
			_running = true;
			
			const service : IRestService = _queue.next;
			
			if(service.executing) 
				throw new IllegalOperationError('IRestService is already executing');
			
			service.completedSignal.add(handleCompletedSignal);
			service.errorSignal.add(handleErrorSignal);
			
			_manager.output.execute(service);
		}
		
		/**
		 * @private
		 */
		net_namespace function advance() : void
		{
			_running = false;
			
			if(null != _queue && _queue.hasNext) execute();
			else
			{
				 if(_queues.length == 0) 
				 {
					if(null != _queue) _queue.queue.active = false;
					
					_queue = null;
				 }
				 else 
				 {
					if(_queues.length > 0) 
					{
						if(null != _queue) _queue.queue.active = false;
						
						const queue : RestServiceQueue = _queues.shift();
						_queue = queue.iterator;
						_queue.queue.active = true;
					}
					else throw new RestError('Unable to begin statement queue');
					
					if(_queue.length > 1)
					{
						_manager.beginSignal.addOnce(handleBeginSignal);
						_manager.begin();
					}
					else handleBeginSignal();
				 }
			}
		}
		
		/**
		 * @private
		 */
		private function handleBeginSignal() : void
		{
			execute();
		}
		
		/**
		 * @private
		 */
		private function handleCommitSignal() : void
		{
			executedSignal.dispatch();
			
			advance();
		}
		
		/**
		 * @private
		 */
		private function handleCompletedSignal(service : RestService) : void
		{
			if(!_queue.hasNext) 
			{
				if(_queue.length > 1)
				{
					_manager.commitSignal.addOnce(handleCommitSignal);
					_manager.commit();
				} else handleCommitSignal();
			}
			else advance();
			
			service;
		}
		
		/**
		 * @private
		 */
		private function handleErrorSignal(service : RestService, event : RestErrorEvent) : void
		{
			advance();
			
			service;
			event;
		}
		
		public function get executedSignal() : ISignal
		{
			if(null == _executedSignal) _executedSignal = new Signal();
			return _executedSignal;
		}
	}
}
