package org.osflash.net.rest.variables
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestFloatVariable extends RestVariable
	{

		public function RestFloatVariable(name : String)
		{
			super(name, RestVariableType.FLOAT);
		}
		
		public function get value() : Number { return Number(variableValue); }
		
		public function set value(value : Number) : void 
		{ 
			if(isNaN(value)) throw new ArgumentError('Value can not be NaN');
			
			variableValue = value; 
		}
	}
}
