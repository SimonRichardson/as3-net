package org.osflash.net.rest.variables
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestIntVariable extends RestVariable
	{

		public function RestIntVariable(name : String)
		{
			super(name, RestVariableType.INTEGER);
		}
		
		public function get value() : int { return int(variableValue); }
		
		public function set value(value : int) : void 
		{ 
			if(isNaN(value)) throw new ArgumentError('Value can not be NaN');
			
			variableValue = value; 
		}
	}
}
