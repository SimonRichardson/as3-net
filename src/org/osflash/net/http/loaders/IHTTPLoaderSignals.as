package org.osflash.net.http.loaders
{
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPLoaderSignals
	{
		
		function registerObservable(observer : IHTTPLoaderObserver) : void;
		
		function unregisterObservable(observer : IHTTPLoaderObserver) : void;
		
		function get startSignal() : ISignal;
		
		function get stopSignal() : ISignal;
		
		function get completeSignal() : ISignal;
		
		function get httpStatusSignal() : ISignal;

		function get progressSignal() : ISignal;
		
		function get ioErrorSignal() : ISignal
		
		function get securityErrorSignal() : ISignal;
	}
}
