package org.osflash.net.rest.services
{
	import org.osflash.net.rest.errors.RestError;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestServiceQueue
	{
		
		/**
		 * @private
		 */
		private var _active : Boolean;
		
		/**
		 * @private
		 */
		private var _services : Vector.<IRestService>;

		public function RestServiceQueue(initialStatement : IRestService = null)
		{
			_active = false;
			_services = new Vector.<IRestService>();
			
			if(null != initialStatement) add(initialStatement);
		}
		
		public function add(service : IRestService) : void
		{
			if(_active) throw new RestError('Unable to add whilst active');
			
			if(_services.indexOf(service) != -1) 
				throw new ArgumentError('IRestService already exists');
			
			_services.push(service);
		}
		
		public function remove(service : IRestService) : void
		{
			if(_active) throw new RestError('Unable to remove whilst active');
			
			const index : int = _services.indexOf(service);
			if(index == -1)
				throw new ArgumentError('No such IRestService');
				
			const removed : IRestService = _services.splice(index, 1)[0];
			if(removed != service)
				throw new RestError('IRestService mismatch');
		}
		
		public function contains(service : IRestService) : Boolean
		{
			return _services.indexOf(service) >= 0;
		}
		
		public function getAtIndex(index : int) : IRestService
		{
			if(index < 0 || index >= _services.length) throw new RangeError('Index out of range');
			
			return _services[index];
		}
		
		public function get iterator() : RestServiceQueueIterator
		{
			return new RestServiceQueueIterator(this, _services);
		}
		
		public function get length() : int { return _services.length; }
		
		public function get active() : Boolean { return _active; }
		public function set active(value : Boolean) : void { _active = value; }
	}
}
