package org.osflash.net.rest.actions
{
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.net.rest.services.IRestService;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class RestActionPut extends RestAction implements IRestActionGet
	{
		
		public function RestActionPut(service : IRestService)
		{
			super(service);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function onActionData(data : *) : void
		{
			service.completedSignal.dispatch(service);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onActionStatus(status : int) : void
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onActionError(error : RestError) : void
		{
			service.errorSignal.dispatch(service, new RestErrorEvent(error.message, error));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : RestActionType { return RestActionType.PUT; }
	}
}
