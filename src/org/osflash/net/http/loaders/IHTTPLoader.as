package org.osflash.net.http.loaders
{
	import org.osflash.net.http.queues.IHTTPQueue;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IHTTPLoader
	{

		function start(queue : IHTTPQueue) : void;

		function stop() : void;
		
		function get content() : *;
	}
}
