package org.osflash.net.http.cache
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.system.System;
	import flash.utils.getTimer;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPCacheItem implements IHTTPCacheItem
	{
		
		/**
		 * @private
		 */
		private var _id : String;
		
		/**
		 * @private
		 */
		private var _content : *;
		
		/**
		 * @private
		 */
		private var _status : int;
		
		/**
		 * @private
		 */
		private var _time : int;
				
		public function HTTPCacheItem(	id : String, 
										status : int = -1, 
										time : int = NaN, 
										content : * = null
										)
		{
			if(null == id) throw new ArgumentError('ID can not be null');
			if(isNaN(status)) throw new ArgumentError('Status can not be NaN');
			
			_id = id;
			_status = status;
			_time = isNaN(time) ? getTimer() : time;
			
			_content = content;
		}

		/**
		 * @inheritDoc
		 */
		public function clear() : void
		{
			if(_content is Bitmap) Bitmap(_content).bitmapData.dispose();
			else if(_content is BitmapData) BitmapData(_content).dispose();
			else if(_content is XML)
			{
				if('disposeXML' in System) System['disposeXML'](_content);
			}
			
			_content = null;
		}

		/**
		 * @inheritDoc
		 */
		public function get id() : String { return _id; }

		/**
		 * @inheritDoc
		 */
		public function get content() : * { return _content; }
		public function set content(value : *) : void { _content = value; }

		/**
		 * @inheritDoc
		 */
		public function get status() : int { return _status; }
		public function set status(value : int) : void { _status = value; }

		/**
		 * @inheritDoc
		 */
		public function get time() : int { return _time; }

		/**
		 * @inheritDoc
		 */
		public function get expiry() : int { return getTimer() - _time; }
	}
}
