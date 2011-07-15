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
		
		public function add(statement : IRestService) : void
		{
			if(_active) throw new RestError('Unable to add whilst active');
			
			if(_services.indexOf(statement) != -1) 
				throw new ArgumentError('IRestService already exists');
			
			_services.push(statement);
		}
		
		public function remove(statement : IRestService) : void
		{
			if(_active) throw new RestError('Unable to remove whilst active');
			
			const index : int = _services.indexOf(statement);
			if(index == -1)
				throw new ArgumentError('No such IRestService');
				
			const removed : IRestService = _services.splice(index, 1)[0];
			if(removed != statement)
				throw new RestError('IRestService mismatch');
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
