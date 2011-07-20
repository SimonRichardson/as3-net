package org.osflash.net.rest.actions
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestActionGet extends RestAction implements IRestActionGet
	{

		public function RestActionGet()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : RestActionType { return RestActionType.GET; }
	}
}
