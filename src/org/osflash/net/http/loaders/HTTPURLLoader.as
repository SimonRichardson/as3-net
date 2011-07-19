package org.osflash.net.http.loaders
{
	import org.osflash.net.http.queues.IHTTPQueue;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPURLLoader implements IHTTPLoader
	{

		public function HTTPURLLoader()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function start(queue : IHTTPQueue) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function stop() : void
		{
		}
	}
}
