package org.osflash.net.http
{
	import asunit.asserts.assertEquals;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPQueueTest
	{
		
		private var _queue : IHTTPQueue;
		
		[Before]
		public function setUp() : void
		{
			_queue = new HTTPQueue();
		}

		[After]
		public function tearDown() : void
		{
			_queue = null;
		}
		
		[Test]
		public function length_should_be_zero() : void
		{
			assertEquals('Queue length should be 0', 0, _queue.length);
		}
		
		[Test]
		public function length_should_be_zero_after_advance() : void
		{
			_queue.advance();
			
			assertEquals('Queue length should be 0', 0, _queue.length);
		}
	}
}
