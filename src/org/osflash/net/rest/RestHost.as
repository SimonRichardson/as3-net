package org.osflash.net.rest
{
	import org.osflash.net.http.uri.HTTPURI;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class RestHost
	{
		
		/**
		 * @private
		 */
		private var _uri : HTTPURI;
		
		public function RestHost(uri : String)
		{
			if(null == uri) throw new ArgumentError('URI can not be null');
			if(uri.length == 0) throw new ArgumentError('URI can not be empty');
			
			_uri = new HTTPURI(uri);
		}
		
		public function get uri() : String { return _uri.uri; }
	}
}
