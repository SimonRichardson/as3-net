package org.osflash.net.rest.services
{
	import org.osflash.net.utils.getClassNameFromQname;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestService implements IRestService
	{
		
		/**
		 * @private
		 */
		private var _name : String;
		
		public function RestService()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function get name() : String
		{
			if(null != _name) return _name;
			else
			{
				_name = getClassNameFromQname(getQualifiedClassName(this));
				return _name;
			}
		}
	}
}
