package org.osflash.net.rest.actions
{
	import org.osflash.net.http.HTTPMIMEType;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.parameters.RestParameter;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestAction implements IRestAction
	{
		
		/**
		 * @private
		 */
		private var _service : IRestService;
		
		/**
		 * @private
		 */
		private var _mimeType : HTTPMIMEType;
		
		/**
		 * @private
		 */
		private var _parameters : Vector.<RestParameter>;

		public function RestAction(service : IRestService)
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			_service = service;
			
			_parameters = new Vector.<RestParameter>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function onActionData(data : *) : void
		{
			throw new Error('Abstract method');
		}
		
		/**
		 * @inheritDoc
		 */
		public function onActionStatus(status : int) : void
		{
			throw new Error('Abstract method');
		}
		
		/**
		 * @inheritDoc
		 */
		public function onActionError(error : RestError) : void
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
		
		/**
		 * @inheritDoc
		 */
		public function get mimeType() : HTTPMIMEType { return _mimeType; }
		public function set mimeType(value : HTTPMIMEType) : void 
		{ 
			if(null == value) throw new ArgumentError('Mime type can not be null');
			_mimeType = value; 
		}
		
		/**
		 * @inheritDoc
		 */
		public function get service() : IRestService { return _service; }
		
		/**
		 * @inheritDoc
		 */
		public function get parameters() : Vector.<RestParameter> { return _parameters; }
	}
}
