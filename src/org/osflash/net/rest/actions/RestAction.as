package org.osflash.net.rest.actions
{
	import org.osflash.net.rest.parameters.RestParameter;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestAction implements IRestAction
	{
		
		/**
		 * @private
		 */
		private var _parameters : Vector.<RestParameter>;

		public function RestAction()
		{
			_parameters = new Vector.<RestParameter>();
		}
		
		public function format() : void
		{
			throw new Error('Abstract method');
		}
		
		/**
		 * @inheritDoc
		 */
		public function get type() : RestActionType
		{
			throw new Error('Abstract method');
		}
		
		public function get parameters() : Vector.<RestParameter> { return _parameters; }
	}
}
