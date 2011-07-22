package org.osflash.net.http
{
	import org.osflash.net.http.queues.IHTTPQueue;
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.net.http.loaders.HTTPURLLoader;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.loaders.signals.HTTPLoaderObserver;
	import org.osflash.net.http.queues.HTTPBulkQueue;

	import flash.events.Event;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPURLoaderBulkQueueTest
	{
		
		[Inject]
		public var async : IAsync;
		
		private var _queue : IHTTPQueue;
		
		[Before]
		public function setUp() : void
		{
			_queue = new HTTPBulkQueue(4);
		}

		[After]
		public function tearDown() : void
		{
			_queue = null;
		}

		[Test]
		public function create_one_loader_and_queue() : void
		{
			const observer : HTTPLoaderObserver = new HTTPLoaderObserver();
			observer.completeSignal.add(async.add(handleCompletedSignal, 10000));
			observer.ioErrorSignal.add(handleErrorSignal);
			observer.securityErrorSignal.add(handleErrorSignal);
			
			const loader : HTTPURLLoader = HTTPURLLoader.fromURL('http://google.co.uk/crossdomain.xml');
			loader.registerObservable(observer);
			
			_queue.add(loader);
			
			assertEquals('Queue length should equal 1', 1, _queue.length);
		}
		
		[Test]
		public function create_two_loaders_and_queue() : void
		{
			const observer : HTTPLoaderObserver = new HTTPLoaderObserver();
			observer.completeSignal.add(async.add(handleCompletedSignal, 2000));
			observer.ioErrorSignal.add(handleErrorSignal);
			observer.securityErrorSignal.add(handleErrorSignal);
			
			const loader0 : HTTPURLLoader = HTTPURLLoader.fromURL('http://google.co.uk/crossdomain.xml');
			loader0.registerObservable(observer);
			
			const loader1 : HTTPURLLoader = HTTPURLLoader.fromURL('http://video.google.co.uk/crossdomain.xml');
			loader1.registerObservable(observer);
			
			_queue.add(loader0);
			_queue.add(loader1);
			
			assertEquals('Queue length should equal 2', 2, _queue.length);
		}
		
		[Test]
		public function create_10_loaders_and_queue() : void
		{
			const observer : HTTPLoaderObserver = new HTTPLoaderObserver();
			observer.completeSignal.add(async.add(handleCompletedSignal, 2000));
			observer.ioErrorSignal.add(handleErrorSignal);
			observer.securityErrorSignal.add(handleErrorSignal);
			
			const total : int = 10;
			for(var i : int = 0; i<total; i++)
			{
				const uri : String = 'http://google.co.uk/crossdomain.xml#10-loaders-nocache=' + i;
				const loader : HTTPURLLoader = HTTPURLLoader.fromURL(uri);
				loader.registerObservable(observer);
				
				_queue.add(loader);
			}
			
			assertEquals('Queue length should equal ' + total, total, _queue.length);
		}
		
		[Test]
		public function create_10_loaders_and_queue_and_remove_5_from_front() : void
		{
			const observer : HTTPLoaderObserver = new HTTPLoaderObserver();
			observer.completeSignal.add(async.add(handleCompletedSignal, 2000));
			observer.ioErrorSignal.add(handleErrorSignal);
			observer.securityErrorSignal.add(handleErrorSignal);
			
			const loaders : Vector.<IHTTPLoader> = new Vector.<IHTTPLoader>();
			
			const total : int = 10;
			for(var i : int = 0; i<total; i++)
			{
				const uri : String = 'http://google.co.uk/crossdomain.xml#nocache=' + i;
				const loader : HTTPURLLoader = HTTPURLLoader.fromURL(uri);
				loader.registerObservable(observer);
				
				_queue.add(loader);
				
				if(i < total * 0.5) loaders.push(loader);
			}
			
			assertEquals('Queue length should equal ' + total, total, _queue.length);
			
			const newTotal : int = loaders.length;
			
			var index : int = newTotal;
			while(--index > -1)
			{
				_queue.remove(loaders[index]);
			}
			
			assertEquals('Queue length should equal ' + newTotal, newTotal, _queue.length);
		}
		
		[Test]
		public function create_10_loaders_and_queue_and_remove_5_from_rear() : void
		{
			const observer : HTTPLoaderObserver = new HTTPLoaderObserver();
			observer.completeSignal.add(async.add(handleCompletedSignal, 2000));
			observer.ioErrorSignal.add(handleErrorSignal);
			observer.securityErrorSignal.add(handleErrorSignal);
			
			const loaders : Vector.<IHTTPLoader> = new Vector.<IHTTPLoader>();
			
			const total : int = 10;
			for(var i : int = 0; i<total; i++)
			{
				const uri : String = 'http://google.co.uk/crossdomain.xml#nocache=' + i;
				const loader : HTTPURLLoader = HTTPURLLoader.fromURL(uri);
				loader.registerObservable(observer);
				
				_queue.add(loader);
				
				if(i >= total * 0.5) loaders.push(loader);
			}
			
			assertEquals('Queue length should equal ' + total, total, _queue.length);
			
			const newTotal : int = loaders.length;
			
			var index : int = newTotal;
			while(--index > -1)
			{
				_queue.remove(loaders[index]);
			}
			
			assertEquals('Queue length should equal ' + newTotal, newTotal, _queue.length);
		}
		
		private function handleCompletedSignal(loader : IHTTPLoader, event : Event) : void
		{
			assertNotNull('Loader can not be null', loader);
		}
		
		private function handleErrorSignal(service : IHTTPLoader, event : Event) : void
		{
			fail("Failed if called");
			
			service;
			event;
		}
	}
}
