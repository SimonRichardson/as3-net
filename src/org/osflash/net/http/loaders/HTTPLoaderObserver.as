package org.osflash.net.http.loaders
{
	import org.osflash.signals.ISignal;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPLoaderObserver implements IHTTPLoaderObserver, IHTTPLoaderSignals
	{

		public function HTTPLoaderObserver()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function handleStartSignal(loader : IHTTPLoader) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function handleStopSignal(loader : IHTTPLoader) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function handleCompleteSignal(loader : IHTTPLoader, event : Event) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function handleHTTPStatusSignal(loader : IHTTPLoader, event : HTTPStatusEvent) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function handleProgressSignal(loader : IHTTPLoader, event : ProgressEvent) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function handleIOErrorSignal(loader : IHTTPLoader, event : IOErrorEvent) : void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function handleSecurityErrorSignal(loader : IHTTPLoader, event : SecurityErrorEvent) : void
		{
		}

		public function registerObservable(observer : IHTTPLoaderObserver) : void
		{
		}

		public function unregisterObservable(observer : IHTTPLoaderObserver) : void
		{
		}

		public function get startSignal() : ISignal
		{
			return null;
		}

		public function get stopSignal() : ISignal
		{
			return null;
		}

		public function get completeSignal() : ISignal
		{
			return null;
		}

		public function get httpStatusSignal() : ISignal
		{
			return null;
		}

		public function get progressSignal() : ISignal
		{
			return null;
		}

		public function get ioErrorSignal() : ISignal
		{
			return null;
		}

		public function get securityErrorSignal() : ISignal
		{
			return null;
		}
	}
}
