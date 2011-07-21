package org.osflash.net.http
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPMIMEType
	{

		public static const TEXT_XML : HTTPMIMEType = new HTTPMIMEType('text/xml');
		
		public static const TEXT_PLAIN : HTTPMIMEType = new HTTPMIMEType('text/plain');
		
		public static const TEXT_HTML : HTTPMIMEType = new HTTPMIMEType('text/html');
		
		public static const APPLICATION_JSON : HTTPMIMEType = new HTTPMIMEType('application/json');
		
		/**
		 * @private
		 */
		private var _type : String;

		public function HTTPMIMEType(type : String)
		{
			if(null == type) throw new ArgumentError('Type can not be null');
			if(type.length == 0) throw new ArgumentError('Type can not be empty');
			
			_type = type;
		}
		
		public static function getMimeTypeByName(value : String) : HTTPMIMEType
		{
			switch(value.toLowerCase())
			{
				case 'htm':
				case 'html':
				case 'xhtml':
					return TEXT_HTML;
				case 'txt':
				case 'plain':
					return TEXT_PLAIN;
				case 'json':
				case 'jsonp':
					return APPLICATION_JSON;
				case 'xml': 
				default:
					return TEXT_XML;
			}
		}
		
		public function get type() : String { return _type; }
	}
}
