package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IHTTPQueue
	{
		
		function add(loader : IHTTPLoader) : IHTTPLoader;
		
		function remove(loader : IHTTPLoader) : IHTTPLoader;
		
		function removeAll() : void;
		
		function contains(loader : IHTTPLoader) : Boolean;
		
		function advance() : void;
		
		function get length() : int;
	}
}
