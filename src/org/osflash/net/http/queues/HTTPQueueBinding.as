package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPQueueBinding implements IHTTPQueueBinding
	{
		
		/**
		 * @private
		 */
		private var _loader : IHTTPLoader;
		
		/**
		 * @private
		 */
		private var _priority : int;
		
		public function HTTPQueueBinding(loader : IHTTPLoader, priority : int)
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(isNaN(priority)) throw new ArgumentError('Priority can not be a NaN');
			
			_loader = loader;
			_priority = priority;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get loader() : IHTTPLoader { return _loader; }

		/**
		 * @inheritDoc
		 */
		public function get priority() : int { return _priority; }
	}
}
