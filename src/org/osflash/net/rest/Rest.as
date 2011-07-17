package org.osflash.net.rest
{
	import org.osflash.net.rest.output.IRestOutput;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.RestServiceExecutioner;
	import org.osflash.net.rest.services.RestServiceQueue;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class Rest
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
		
		public function Rest(output : IRestOutput = null)
		{
			_executioner = new RestServiceExecutioner(this);
			
			if(null != output) _output = output;
		}
		
		public function begin() : void
		{
		}
		
		public function commit() : void
		{
		}
		
		public function add(service : IRestService) : IRestService
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			_executioner.add(new RestServiceQueue(service));
			
			return service;
		}
		
		public function remove(service : IRestService) : IRestService
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
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
