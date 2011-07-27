package org.osflash.net.http.loaders
{
	import org.osflash.net.http.cache.IHTTPCache;
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
		
		function get responseHeaders() : Array;
		
		function get cache() : IHTTPCache;
		function set cache(value : IHTTPCache) : void;
		
		function get cachedContent() : Boolean;
	}
}
