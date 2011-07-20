package org.osflash.net.rest.actions
{
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.net.rest.services.IRestService;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestActionGet extends RestAction implements IRestActionGet
	{
		
		/**
		 * @private
		 */
		private var _service : IRestService;

		public function RestActionGet(service : IRestService)
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			_service = service;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function onActionData(data : *) : void
		{
			// TODO : set the data on the service?
			
			_service.completedSignal.dispatch(_service);
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
			_service.errorSignal.dispatch(_service, new RestErrorEvent(error.message, error));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : RestActionType { return RestActionType.GET; }
	}
}
