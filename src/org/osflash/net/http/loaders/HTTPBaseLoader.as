package org.osflash.net.http.loaders
{
	import org.osflash.net.http.cache.IHTTPCache;
	import org.osflash.net.http.loaders.signals.IHTTPLoaderObserver;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.net_namespace;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;


	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPBaseLoader implements IHTTPLoader
	{
		
		/**
		 * @private
		 */
		private var _cache : IHTTPCache;
		
		/**
		 * @private
		 */
		private var _queue : IHTTPQueue;
		
		/**
		 * @private
		 */
		private var _listening : Boolean;
		
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
		
		/**
		 * @private
		 */
		private var _nativeCompleteSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _nativeHTTPStatusSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _nativeProgressSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _nativeIOErrorSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _nativeSecurityErrorSignal : ISignal;
		
		public function HTTPBaseLoader(dispatcher : EventDispatcher)
		{
			init(dispatcher);
			
			_listening = false;
		}

		/**
		 * @inheritDoc
		 */
		public function start(queue : IHTTPQueue) : void
		{
			if (null == queue) throw new ArgumentError('Queue can not be null');

			_queue = queue;
		}

		/**
		 * @inheritDoc
		 */
		public function stop() : void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function registerObservable(observer : IHTTPLoaderObserver) : void
		{
			if(null == observer) throw new ArgumentError('Observer can not be null');
			
			startSignal.add(observer.handleStartSignal);
			stopSignal.add(observer.handleStopSignal);
			completeSignal.add(observer.handleCompleteSignal);
			httpStatusSignal.add(observer.handleHTTPStatusSignal);
			progressSignal.add(observer.handleProgressSignal);
			ioErrorSignal.add(observer.handleIOErrorSignal);
			securityErrorSignal.add(observer.handleSecurityErrorSignal);
		}
		
		/**
		 * @inheritDoc
		 */
		public function unregisterObservable(observer : IHTTPLoaderObserver) : void
		{
			if(null == observer) throw new ArgumentError('Observer can not be null');
			
			startSignal.remove(observer.handleStartSignal);
			stopSignal.remove(observer.handleStopSignal);
			completeSignal.remove(observer.handleCompleteSignal);
			httpStatusSignal.remove(observer.handleHTTPStatusSignal);
			progressSignal.remove(observer.handleProgressSignal);
			ioErrorSignal.remove(observer.handleIOErrorSignal);
			securityErrorSignal.remove(observer.handleSecurityErrorSignal);
		}
		
		protected function init(dispatcher : EventDispatcher) : void
		{
			if(null == dispatcher) throw new ArgumentError('EventDispatcher can not be null');
			
			_nativeCompleteSignal = new NativeSignal(dispatcher, Event.COMPLETE);
			_nativeHTTPStatusSignal = new NativeSignal(	dispatcher, 
														HTTPStatusEvent.HTTP_STATUS, 
														HTTPStatusEvent
														);
			_nativeProgressSignal = new NativeSignal(	dispatcher, 
														ProgressEvent.PROGRESS, 
														ProgressEvent
														);
			_nativeIOErrorSignal = new NativeSignal(	dispatcher,
														IOErrorEvent.IO_ERROR,
														IOErrorEvent
														);
			_nativeSecurityErrorSignal = new NativeSignal(	dispatcher,
															SecurityErrorEvent.SECURITY_ERROR,
															SecurityErrorEvent
															);
		}
		
		protected function register() : void
		{
			_nativeCompleteSignal.add(handleCompleteSignal);
			_nativeHTTPStatusSignal.add(handleHTTPStatusSignal);
			_nativeProgressSignal.add(handleProgressSignal);
			_nativeIOErrorSignal.add(handleIOErrorSignal);
			_nativeSecurityErrorSignal.add(handleSecurityErrorSignal);
			
			_listening = true;
		}
		
		protected function unregister() : void
		{
			_listening = false;
			
			_nativeCompleteSignal.remove(handleCompleteSignal);
			_nativeHTTPStatusSignal.remove(handleHTTPStatusSignal);
			_nativeProgressSignal.remove(handleProgressSignal);
			_nativeIOErrorSignal.remove(handleIOErrorSignal);
			_nativeSecurityErrorSignal.remove(handleSecurityErrorSignal);
		}
		
		protected function handleCompleteSignal(event : Event) : void
		{
			if(_listening) completeSignal.dispatch(this, event);
		}
		
		protected function handleHTTPStatusSignal(event : HTTPStatusEvent) : void
		{
			if(_listening) httpStatusSignal.dispatch(this, event);
		}
		
		protected function handleProgressSignal(event : ProgressEvent) : void
		{
			if(_listening) progressSignal.dispatch(this, event);
		}
		
		protected function handleIOErrorSignal(event : IOErrorEvent) : void
		{
			if(_listening) ioErrorSignal.dispatch(this, event);
		}
		
		protected function handleSecurityErrorSignal(event : SecurityErrorEvent) : void
		{
			if(_listening) securityErrorSignal.dispatch(this, event);
		}
		
		public function get content() : * 
		{
			throw new Error('Abstract method');
		}
		
		public function get responseHeaders() : Array
		{
			throw new Error('Abstract method');
		}
		
		public function get startSignal() : ISignal
		{
			if(null == _startSignal) _startSignal = new Signal(IHTTPLoader);
			return _startSignal;
		}
		
		public function get stopSignal() : ISignal
		{
			if(null == _stopSignal) _stopSignal = new Signal(IHTTPLoader);
			return _stopSignal;
		}
		
		public function get completeSignal() : ISignal
		{
			if(null == _completeSignal) _completeSignal = new Signal(IHTTPLoader, Event);
			return _completeSignal;
		}
		
		public function get httpStatusSignal() : ISignal
		{
			if(null == _httpStatusSignal) _httpStatusSignal = new Signal(	IHTTPLoader, 
																			HTTPStatusEvent
																			);
			return _httpStatusSignal;
		}

		public function get progressSignal() : ISignal
		{
			if(null == _progressSignal) _progressSignal = new Signal(IHTTPLoader, ProgressEvent);
			return _progressSignal;
		}
		
		public function get ioErrorSignal() : ISignal
		{
			if(null == _ioErrorSignal) _ioErrorSignal = new Signal(IHTTPLoader, IOErrorEvent);
			return _ioErrorSignal;
		}
		
		public function get securityErrorSignal() : ISignal
		{
			if(null == _securityErrorSignal) _securityErrorSignal = new Signal(	IHTTPLoader, 
																				SecurityErrorEvent
																				);
			return _securityErrorSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get cache() : IHTTPCache { return _cache; }
		public function set cache(value : IHTTPCache) : void { _cache = value; }
		
		/**
		 * @private
		 */
		net_namespace function get queue() : IHTTPQueue { return _queue; }
	}
}
