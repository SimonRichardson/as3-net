package org.osflash.net.http.queues
{
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPPriorityQueue extends IHTTPQueue
	{
		
		function addWithPriority(loader : IHTTPLoader, priority : int) : IHTTPLoader;
	}
}
