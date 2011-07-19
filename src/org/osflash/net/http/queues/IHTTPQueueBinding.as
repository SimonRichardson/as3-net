package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPQueueBinding
	{
		
		function get loader() : IHTTPLoader;
		
		function get priority() : int;
	}
}
