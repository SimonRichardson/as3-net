package org.osflash.net.rest.variables
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestUIntVariable extends RestVariable
	{

		public function RestUIntVariable(name : String)
		{
			super(name, RestVariableType.UNSIGNED_INTEGER);
		}
		
		public function get value() : uint { return uint(variableValue); }
		
		public function set value(value : uint) : void 
		{ 
			if(isNaN(value)) throw new ArgumentError('Value can not be NaN');
			if(value < 0) throw new ArgumentError('Value can not be less than 0');
			
			variableValue = value; 
		}
	}
}
