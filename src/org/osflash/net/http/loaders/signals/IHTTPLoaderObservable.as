package org.osflash.net.http.loaders.signals
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPLoaderObservable
	{
		
		function registerObservable(observer : IHTTPLoaderObserver) : void;
		
		function unregisterObservable(observer : IHTTPLoaderObserver) : void;
	}
}
