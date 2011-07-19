package org.osflash.net.http.cache
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPCache
	{
		
		function add(item : IHTTPCacheItem) : IHTTPCacheItem;
		
		function remove(item : IHTTPCacheItem) : IHTTPCacheItem;
		
		function contains(item : IHTTPCacheItem) : Boolean;
		
		function getByIndex(index : int) : IHTTPCacheItem;
		
		function getById(id : String) : IHTTPCacheItem;
		
		/**
		 * Clear the cache emptying all of the items within the cache.
		 */
		function clear() : void;
		
		/**
		 * Validate the cache and determin if there are any items within the cache that could of
		 * expired or have been made null (considering weak references or other external sources).
		 */		
		function validate() : void; 
		
		function get length() : int;
	}
}
