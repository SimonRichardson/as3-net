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
		private var _parameterType : int;
		
		/**
		 * @private
		 */
		private var _parameterValue : *;
		
		public function RestParameter(type : int)
		{
			if(isNaN(type)) throw new ArgumentError('Type can not be a NaN');
			
			_parameterType = type;
		}
		
		public function get parameterType() : int { return _parameterType; }
		
		public function get parameterValue() : * { return _parameterValue; }
		
		public function set parameterValue(value : *) : void { _parameterValue = value; }

	}
}
