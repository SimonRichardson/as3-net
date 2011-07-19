package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.net_namespace;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPPriorityQueue extends HTTPQueue implements IHTTPPriorityQueue
	{

		use namespace net_namespace;
		
		public function HTTPPriorityQueue()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addWithPriority(loader : IHTTPLoader, priority : int) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(isNaN(priority)) throw new ArgumentError('Priority can not be NaN');
			
			var index : int = queue.length;
			while(--index > -1)
			{
				const binding : IHTTPQueueBinding = queue[index];
				if(priority < binding.priority)
				{
					queue.splice(index, 0, new HTTPQueueBinding(loader, priority));
				}
			}
			
			return loader;
		}
	}
}
