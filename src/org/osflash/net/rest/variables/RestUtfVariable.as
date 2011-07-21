package org.osflash.net.rest.variables
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestUtfVariable extends RestVariable
	{

		public function RestUtfVariable(name : String)
		{
			super(name, RestVariableType.UTF);
		}
		
		public function get value() : String { return String(variableValue); }
		
		public function set value(value : String) : void 
		{ 
			if(null == value) throw new ArgumentError('Value can not be null');
			
			variableValue = value; 
		}
	}
}
