package org.osflash.net.rest.parameters
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestUIntParameter extends RestParameter
	{

		public function RestUIntParameter()
		{
			super(RestParameterType.UNSIGNED_INTEGER);
		}
		
		public function get value() : uint { return uint(parameterValue); }
		
		public function set value(value : uint) : void 
		{ 
			if(isNaN(value)) throw new ArgumentError('Value can not be NaN');
			if(value < 0) throw new ArgumentError('Value can not be less than 0');
			
			parameterValue = value; 
		}
	}
}
