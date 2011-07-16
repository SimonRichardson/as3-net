package org.osflash.net.rest.parameters
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestIntParameter extends RestParameter
	{

		public function RestIntParameter()
		{
			super(RestParameterType.INTEGER);
		}
		
		public function get value() : int { return int(parameterValue); }
		
		public function set value(value : int) : void 
		{ 
			if(isNaN(value)) throw new ArgumentError('Value can not be NaN');
			
			parameterValue = value; 
		}
	}
}
