package org.osflash.net.http.cache
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPCache implements IHTTPCache
	{
		
		/**
		 * @private
		 */
		private var _items : Vector.<IHTTPCacheItem>;
		
		public function HTTPCache()
		{
			_items = new Vector.<IHTTPCacheItem>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(item : IHTTPCacheItem) : IHTTPCacheItem
		{
			if(null == item) throw new ArgumentError('Item can not be null');
			if(_items.indexOf(item) >= 0) throw new ArgumentError('Item must be unique');
			
			_items.push(item);
			
			return item;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(item : IHTTPCacheItem) : IHTTPCacheItem
		{
			if(null == item) throw new ArgumentError('Item can not be null');
			
			const index : int = _items.indexOf(item);
			if(index >= 0) _items.splice(index, 1);
			
			return item;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getByIndex(index : int) : IHTTPCacheItem
		{
			if(index < 0 || index >= _items.length) throw new RangeError();
			
			return _items[index];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getById(id : String) : IHTTPCacheItem
		{
			var index : int = _items.length;
			while(--index > -1)
			{
				const item : IHTTPCacheItem = _items[index];
				if(item.id == id) return item;
			}
			
			return null;
		}

		/**
		 * @inheritDoc
		 */
		public function contains(item : IHTTPCacheItem) : Boolean
		{
			return _items.indexOf(item) >= 0;
		}

		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			var index : int = _items.length;
			while(--index > -1)
			{
				const item : IHTTPCacheItem = _items.pop();
				item.clear();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function validate() : void
		{
			var index : int = _items.length;
			while(--index > -1)
			{
				const item : IHTTPCacheItem = _items[index];
				if(item.expiry < 0 || null == item.content) 
				{
					_items.splice(index, 1);
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _items.length; }
	}
}
