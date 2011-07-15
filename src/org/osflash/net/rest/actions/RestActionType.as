package org.osflash.net.rest.actions
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class RestActionType
	{
		
		public static const GET : RestActionType = new RestActionType('get');
		
		public static const PUT : RestActionType = new RestActionType('put');
		
		public static const POST : RestActionType = new RestActionType('post');
		
		public static const DELETE : RestActionType = new RestActionType('delete');

		/**
		 * @private
		 */
		private var _name : String;

		public function RestActionType(name : String)
		{
			_name = name;
		}

		public function get name() : String { return _name; }

	}
}
