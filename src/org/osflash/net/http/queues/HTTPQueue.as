package org.osflash.net.http.queues
{
	import org.osflash.net.http.errors.HTTPError;
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPQueue implements IHTTPQueue
	{
		
		/**
		 * @private
		 */
		private var _active : Boolean;
		
		/**
		 * @private
		 */
		private var _queue : Vector.<IHTTPLoader>;
		
		public function HTTPQueue()
		{
			_active = false;
			_queue = new Vector.<IHTTPLoader>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(loader : IHTTPLoader) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(contains(loader)) throw new ArgumentError('Can not add loader more than once');
			
			_queue.push(loader);
			
			return loader;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(loader : IHTTPLoader) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			
			const index : int = _queue.indexOf(loader);
			if(index >= 0)
			{
				const item : IHTTPLoader = _queue.splice(index, 1) as IHTTPLoader;
				if(item != loader) throw new HTTPError('IHTTPLoader mismatch');
			}
			
			return loader;
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
			if(_active) return;
		}
		
		public function get length() : int { return _queue.length; }
	}
}
