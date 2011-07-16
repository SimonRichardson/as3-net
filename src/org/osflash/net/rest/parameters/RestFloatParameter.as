package org.osflash.net.rest.parameters
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestFloatParameter extends RestParameter
	{

		public function RestFloatParameter()
		{
			super(RestParameterType.FLOAT);
		}
		
		public function get value() : Number { return Number(parameterValue); }
		
		public function set value(value : Number) : void 
		{ 
			if(isNaN(value)) throw new ArgumentError('Value can not be NaN');
			
			parameterValue = value; 
		}
	}
}
