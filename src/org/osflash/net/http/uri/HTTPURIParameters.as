package org.osflash.net.http.uri
{
	import org.osflash.net.http.errors.HTTPError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPURIParameters
	{
		
		/**
		 * @private
		 */
		private var _name : String;

		/**
		 * @private
		 */
		private var _value : String;

		/**
		 * @param name value of the URI parameter
		 * @param value of the URI parameter
		 */
		public function HTTPURIParameters(name : String, value : String)
		{
			if(null == name) throw new ArgumentError('Name can not be null');
			if(name.length == 0) throw new ArgumentError('Name can not be empty');
			if(null == value) throw new ArgumentError('Value can not be null');
			
			_name = name;
			_value = value;
		}

		/**
		 * Create a Parameter pair from a uniformed string, in this case 'a=1', where there is
		 * an equals sign that splits the parameter
		 * 
		 * @return HTTPUniformResourceIdentifierParameters
		 */
		public static function fromUniformedString(	parameter : String
													) : HTTPURIParameters
		{
			const split : Array = parameter.split("=");
			if (split.length != 2) throw new HTTPError("Unable to split the parameters");
			
			return new HTTPURIParameters(split[0], split[1]);
		}

		/**
		 * Get the name of the parameter
		 * 
		 * @return String
		 */
		public function get name() : String { return _name; }

		/**
		 * Get the value of the parameter
		 * 
		 * @return String
		 */
		public function get value() : String { return _value; }		
	}
}
