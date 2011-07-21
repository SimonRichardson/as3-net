package org.osflash.net.rest.parameters
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestParameter
	{
		
		/**
		 * @private
		 */
		private var _type : int;
		
		/**
		 * @private
		 */
		private var _parameterValue : *;
		
		public function RestParameter(type : int)
		{
			if(isNaN(type)) throw new ArgumentError('Type can not be a NaN');
			
			_type = type;
		}
		
		public function get type() : int { return _type; }
		
		public function get parameterValue() : * { return _parameterValue; }
		
		public function set parameterValue(value : *) : void { _parameterValue = value; }
		
		public function get parameterAsString() : String { return String(_parameterValue); }
	}
}
