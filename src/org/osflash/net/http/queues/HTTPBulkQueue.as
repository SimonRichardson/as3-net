package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPBulkQueue implements IHTTPQueue
	{
		
		/**
		 * @private
		 */
		private var _queues : Vector.<IHTTPQueue>;
		
		public function HTTPBulkQueue(numQueues : int)
		{
			if(numQueues < 1) throw new ArgumentError('Queues can not be less than 1');
			
			_queues = new Vector.<IHTTPQueue>();
			
			for(var i : int = 0; i < numQueues; i++)
			{
				_queues.push(new HTTPQueue());
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		public function add(loader : IHTTPLoader) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(contains(loader)) throw new ArgumentError('Can not add loader more than once');
			
			var index : int = _queues.length;
			
			var queue0 : IHTTPQueue = _queues[index - 1];
			
			// Work out the queue with the least items and add to that one.
			while(--index > -1)
			{
				const queue1 : IHTTPQueue = _queues[index];
				if(queue1.length < queue0.length) queue0 = queue1;
			}
			
			return queue0.add(loader);
		}

		/**
		 * @inheritDoc
		 */		
		public function remove(loader : IHTTPLoader) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			
			var index : int = _queues.length;
			while(--index > -1)
			{
				const queue : IHTTPQueue = _queues[index];
				if(queue.contains(loader)) return queue.remove(loader);
			}
			
			return null;
		}

		/**
		 * @inheritDoc
		 */		
		public function contains(loader : IHTTPLoader) : Boolean
		{
			var index : int = _queues.length;
			while(--index > -1)
			{
				const queue : IHTTPQueue = _queues[index];
				if(queue.contains(loader)) return true;
			}
			
			return false;
		}

		/**
		 * @inheritDoc
		 */	
		public function advance() : void
		{
			var index : int = _queues.length;
			while(--index > -1)
			{
				const queue : IHTTPQueue = _queues[index];
				queue.advance();
			}
		}
		
		public function get length() : int { return _queues.length;	}
	}
}
