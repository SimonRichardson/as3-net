package org.osflash.net.rest.actions.echo
{
	import org.osflash.net.rest.actions.RestActionType;
	import org.osflash.net.rest.actions.RestAction;
	import org.osflash.net.rest.actions.IRestActionGet;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class EchoAction extends RestAction implements IRestActionGet
	{

		public function EchoAction()
		{
		}

		/**
		 * @inheritDoc
		 */
		override public function get type() : RestActionType { return RestActionType.GET; }
	}
}
