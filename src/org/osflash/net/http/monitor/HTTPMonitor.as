package org.osflash.net.http.monitor
{
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.http.loaders.HTTPURLLoader;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.loaders.signals.HTTPLoaderObserver;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPMonitor
	{
		
		private static const DEFAULT_TIME : int = 10000;
		
		private static const DEFAULT_URI : String = 'http://google.co.uk/crossdomain.xml';
		
		/**
		 * @private
		 */
		private var _uri : String;
		
		/**
		 * @private
		 */
		private var _statusSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _queue : IHTTPQueue;
				
		/**
		 * @private
		 */
		private var _timer : Timer;
		
		/**
		 * @private
		 */
		private var _observer : HTTPLoaderObserver;
		
		/**
		 * @private
		 */
		private var _nativeTimerSignal : ISignal;
		
		public function HTTPMonitor(interval : int = DEFAULT_TIME)
		{
			_queue = new HTTPQueue();
			
			_uri = DEFAULT_URI;
			
			_observer = new HTTPLoaderObserver();
			_observer.httpStatusSignal.add(handleHTTPStatusSignal);
			_observer.completeSignal.add(handleCompleteSignal);
			_observer.ioErrorSignal.add(handleErrorSignal);
			_observer.securityErrorSignal.add(handleErrorSignal);
			
			_timer = new Timer(interval);
			
			_nativeTimerSignal = new NativeSignal(_timer, TimerEvent.TIMER, TimerEvent);
			_nativeTimerSignal.add(handleNativeTimerSignal);
		}
		
		public function start() : void
		{
			_timer.reset();
			_timer.start();
		}
		
		public function stop() : void
		{
			_timer.stop();
			
			_queue.removeAll(true);
		}
		
		/**
		 * @private
		 */
		private function handleNativeTimerSignal(event : TimerEvent) : void
		{
			const loader : HTTPURLLoader = HTTPURLLoader.fromURL(_uri);
			loader.registerObservable(_observer);
			
			_queue.add(loader);
		}
		
		/**
		 * @private
		 */
		private function handleHTTPStatusSignal(	loader : IHTTPLoader, 
													event : HTTPStatusEvent
													) : void
		{
			statusSignal.dispatch(event.status < HTTPStatusCode.BAD_REQUEST);
			
			loader;
		}
		
		/**
		 * @private
		 */
		private function handleCompleteSignal(loader : IHTTPLoader, event : Event) : void
		{
			loader;
			event;
		}
				
		/**
		 * @private
		 */
		private function handleErrorSignal(loader : IHTTPLoader, event : Event) : void
		{
			statusSignal.dispatch(false);
			
			loader;
			event;
		}
		
		public function get uri() : String { return _uri; }
		public function set uri(value : String) : void
		{
			if(null == value) throw new ArgumentError('Value can not be null');
			if(value.length == 0) throw new ArgumentError('Value can not be empty');
			
			if(_uri != value)
			{
				_uri = value;
				
				start();
			}
		}
		
		public function get interval() : int { return _timer.delay; }
		public function set interval(value : int) : void
		{
			if(value < 1000) throw new ArgumentError('Interval can not be less than 1000ms');
			
			if(_timer.delay != value)
			{
				_timer.delay = value;
				
				start();
			}
		}
		
		public function get statusSignal() : ISignal
		{
			if(null == _statusSignal) _statusSignal = new Signal(Boolean);
			return _statusSignal;
		}
	}
}
