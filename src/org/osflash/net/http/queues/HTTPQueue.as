package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPQueue implements IHTTPQueue
	{
		
		private var _queue : Vector.<IHTTPLoader>;
		
		public function HTTPQueue()
		{
			_queue = new Vector.<IHTTPLoader>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(loader : IHTTPLoader) : IHTTPLoader
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(loader : IHTTPLoader) : IHTTPLoader
		{
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function contains(loader : IHTTPLoader) : Boolean
		{
			return _queue.indexOf(loader) >= 0;
		}

		/**
		 * @inheritDoc
		 */
		public function advance() : void
		{
		}
		
		public function get length() : int { return _queue.length; }
	}
}
