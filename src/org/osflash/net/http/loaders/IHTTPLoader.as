package org.osflash.net.http.loaders
{
	import org.osflash.net.http.loaders.signals.IHTTPLoaderObservable;
	import org.osflash.net.http.loaders.signals.IHTTPLoaderSignals;
	import org.osflash.net.http.queues.IHTTPQueue;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IHTTPLoader extends IHTTPLoaderSignals, IHTTPLoaderObservable
	{

		function start(queue : IHTTPQueue) : void;

		function stop() : void;
		
		function get content() : *;
	}
}
