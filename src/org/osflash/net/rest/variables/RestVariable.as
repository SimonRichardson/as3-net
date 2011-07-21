package org.osflash.net.rest.variables
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestVariable
	{
		
		/**
		 * @private
		 */
		private var _name : String;
		
		/**
		 * @private
		 */
		private var _type : int;
		
		/**
		 * @private
		 */
		private var _variableValue : *;
		
		public function RestVariable(name : String, type : int)
		{
			if(null == name) throw new ArgumentError('Name can not be null');
			if(name.length == 0) throw new ArgumentError('Name can not be empty');
			if(isNaN(type)) throw new ArgumentError('Type can not be a NaN');
			
			_name = name;
			_type = type;
		}
		
		public function get name() : String { return _name; }
		
		public function get type() : int { return _type; }
		
		public function get variableValue() : * { return _variableValue; }
		
		public function set variableValue(value : *) : void { _variableValue = value; }
		
		public function get variableAsString() : String { return String(_variableValue); }
	}
}
