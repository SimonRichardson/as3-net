package org.osflash.net.rest.actions
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestAction implements IRestAction
	{

		public function RestAction()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function get type() : RestActionType
		{
			throw new Error('Abstract method');
		}
	}
}
