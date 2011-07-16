package org.osflash.net.rest.services
{
	import org.osflash.net.rest.actions.IRestAction;
	import org.osflash.net.utils.getClassNameFromQname;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.utils.getQualifiedClassName;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestService implements IRestService
	{
		
		/**
		 * @private
		 */
		private var _name : String;
		
		/**
		 * @private
		 */
		private var _errorSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _completedSignal : ISignal;
		
		public function RestService()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function get name() : String
		{
			if(null != _name) return _name;
			else
			{
				_name = getClassNameFromQname(getQualifiedClassName(this));
				return _name;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get action() : IRestAction
		{
			throw new Error('Abstract method');
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorSignal() : ISignal
		{
			if(null == _errorSignal) _errorSignal = new Signal();
			return _errorSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get completedSignal() : ISignal
		{
			if(null == _completedSignal) _completedSignal = new Signal(IRestService);
			return _completedSignal;
		}
	}
}
