package org.osflash.net.rest.parameters
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestUtfParameter extends RestParameter
	{

		public function RestUtfParameter()
		{
			super(RestParameterType.UTF);
		}
		
		public function get value() : String { return String(parameterValue); }
		
		public function set value(value : String) : void 
		{ 
			if(null == value) throw new ArgumentError('Value can not be null');
			
			parameterValue = value; 
		}
	}
}
