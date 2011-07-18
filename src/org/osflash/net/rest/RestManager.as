package org.osflash.net.rest
{
	import org.osflash.net.rest.errors.RestError;
	import org.osflash.net.rest.output.IRestOutput;
	import org.osflash.net.rest.output.debug.RestDebugOutput;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.RestServiceExecutioner;
	import org.osflash.net.rest.services.RestServiceQueue;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestManager
	{
		
		/**
		 * @private
		 */
		private var _output : IRestOutput;
		
		/**
		 * @private
		 */
		private var _executioner : RestServiceExecutioner;
		
		/**
		 * @private
		 */
		private var _beginSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _commitSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _queue : RestServiceQueue;
		
		/**
		 * @private
		 */
		private var _queuing : Boolean;
		
		public function RestManager(output : IRestOutput = null)
		{
			_executioner = new RestServiceExecutioner(this);
			
			if(null != output) _output = output;
			else _output = new RestDebugOutput();
		}
		
		public function begin() : void
		{
			if(_queuing) throw new RestError('Unable to begin as already in begin state');
			
			_queuing = true;
			_queue = new RestServiceQueue();
		}
		
		public function release() : void
		{
			if(!_queuing) throw new RestError('Unable to commit as not in begin state');
			if(_queue.active) throw new RestError('Unable to commit, already active state');
			
			_executioner.remove(_queue);
			
			_queue = null;
			_queuing = false;
		}
		
		public function commit() : void
		{
			if(!_queuing) throw new RestError('Unable to commit as not in begin state');
			if(_queue.active) throw new RestError('Unable to commit, already active state');
			
			_executioner.add(_queue);
			_queuing = false;
		}
		
		public function add(service : IRestService) : IRestService
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			if(_queuing) _queue.add(service); 
			else _executioner.add(new RestServiceQueue(service));
			
			return service;
		}
		
		public function remove(service : IRestService) : IRestService
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			if(_queuing) _queue.remove(service);
			else 
			{
				const queue : RestServiceQueue = _executioner.find(service);
				if(null != queue) _executioner.remove(queue);
			}
			
			return service;
		}
		
		public function get output() : IRestOutput { return _output; }
		public function set output(value : IRestOutput) : void 
		{ 
			if(null == value) throw new ArgumentError('IRestOutput can not be null');
			if(null != _output)
			{
				_output.close();
				_output = null;
			}
			
			_output = value;
		}
		
		public function get beginSignal() : ISignal
		{
			if(null == _beginSignal) _beginSignal = new Signal();
			return _beginSignal;
		}
		
		public function get commitSignal() : ISignal
		{
			if(null == _commitSignal) _commitSignal = new Signal();
			return _commitSignal;
		}
	}
}
