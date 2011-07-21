package org.osflash.net.http.loaders.signals
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPLoaderObserver implements IHTTPLoaderObserver, IHTTPLoaderSignals
	{
		
		/**
		 * @private
		 */
		private var _startSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _stopSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _completeSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _httpStatusSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _progressSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _ioErrorSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _securityErrorSignal : ISignal;
		
		public function HTTPLoaderObserver()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function handleStartSignal(loader : IHTTPLoader) : void
		{
			startSignal.dispatch(loader);
		}

		/**
		 * @inheritDoc
		 */
		public function handleStopSignal(loader : IHTTPLoader) : void
		{
			stopSignal.dispatch(loader);
		}

		/**
		 * @inheritDoc
		 */
		public function handleCompleteSignal(loader : IHTTPLoader, event : Event) : void
		{
			completeSignal.dispatch(loader, event);
		}

		/**
		 * @inheritDoc
		 */
		public function handleHTTPStatusSignal(loader : IHTTPLoader, event : HTTPStatusEvent) : void
		{
			httpStatusSignal.dispatch(loader, event);
		}

		/**
		 * @inheritDoc
		 */
		public function handleProgressSignal(loader : IHTTPLoader, event : ProgressEvent) : void
		{
			progressSignal.dispatch(loader, event);
		}

		/**
		 * @inheritDoc
		 */
		public function handleIOErrorSignal(loader : IHTTPLoader, event : IOErrorEvent) : void
		{
			ioErrorSignal.dispatch(loader, event);
		}

		/**
		 * @inheritDoc
		 */
		public function handleSecurityErrorSignal(	loader : IHTTPLoader, 
													event : SecurityErrorEvent
													) : void
		{
			securityErrorSignal.dispatch(loader, event);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get startSignal() : ISignal
		{
			if(null == _startSignal) _startSignal = new Signal(IHTTPLoader);
			return _startSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get stopSignal() : ISignal
		{
			if(null == _stopSignal) _stopSignal = new Signal(IHTTPLoader);
			return _stopSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get completeSignal() : ISignal
		{
			if(null == _completeSignal) _completeSignal = new Signal(IHTTPLoader, Event);
			return _completeSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get httpStatusSignal() : ISignal
		{
			if(null == _httpStatusSignal) _httpStatusSignal = new Signal(	IHTTPLoader, 
																			HTTPStatusEvent
																			);
			return _httpStatusSignal;
		}

		/**
		 * @inheritDoc
		 */
		public function get progressSignal() : ISignal
		{
			if(null == _progressSignal) _progressSignal = new Signal(IHTTPLoader, ProgressEvent);
			return _progressSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get ioErrorSignal() : ISignal
		{
			if(null == _ioErrorSignal) _ioErrorSignal = new Signal(IHTTPLoader, IOErrorEvent);
			return _ioErrorSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get securityErrorSignal() : ISignal
		{
			if(null == _securityErrorSignal) _securityErrorSignal = new Signal(	IHTTPLoader, 
																				SecurityErrorEvent
																				);
			return _securityErrorSignal;
		}
	}
}
