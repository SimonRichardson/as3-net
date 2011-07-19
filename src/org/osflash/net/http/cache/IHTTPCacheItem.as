package org.osflash.net.http.cache
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPCacheItem
	{
		
		function clear() : void;
		
		/**
		 * Id could be anything that is unique to the cache item i.e. the url or random uid
		 */
		function get id() : String;
		
		/**
		 * Get the content of the cache item. 
		 * 
		 * Note: Unfortunately we don't know what the content is going to be ahead of time, 
		 * hence why we use the wildcard type (AS3 generics anyone!?)
		 */
		function get content() : *;
		function set content(value : *) : void;
		
		/**
		 * The current HTTP status of the cache item.
		 * 
		 * @see HTTPStatusCode
		 */
		function get status() : int;
		function set status(value : int) : void;
		
		/**
		 * The time in seconds that the cache item can be alive.
		 * 
		 * @return int value which is from -1 to int.MAX_VALUE
		 */
		function get time() : int;

		/**
		 * The time in milliseconds for when the cache expires.
		 * 
		 * @return int
		 */
		function get expiry() : int;
	}
}
