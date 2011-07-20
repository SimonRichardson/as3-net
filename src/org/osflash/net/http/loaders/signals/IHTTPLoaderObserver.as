package org.osflash.net.http.loaders.signals
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import org.osflash.net.http.loaders.IHTTPLoader;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPLoaderObserver
	{

		function handleStartSignal(loader : IHTTPLoader) : void;

		function handleStopSignal(loader : IHTTPLoader) : void;

		function handleCompleteSignal(loader : IHTTPLoader, event : Event) : void;

		function handleHTTPStatusSignal(loader : IHTTPLoader, event : HTTPStatusEvent) : void;

		function handleProgressSignal(loader : IHTTPLoader, event : ProgressEvent) : void;

		function handleIOErrorSignal(loader : IHTTPLoader, event : IOErrorEvent) : void;

		function handleSecurityErrorSignal(loader : IHTTPLoader, event : SecurityErrorEvent) : void;
	}
}
