package org.osflash.net.rest.events
{
	import org.osflash.net.rest.errors.RestError;

	import flash.events.Event;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestErrorEvent extends Event
	{
		
		/**
		 * @private
		 */
		private var _error : RestError;

		public function RestErrorEvent(message : String, error : RestError)
		{
			super(message);
			
			_error = error;
		}

		public function get error() : RestError { return _error; }
	}
}
