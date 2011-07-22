package org.osflash.net.http
{
	import asunit.asserts.assertEquals;

	import org.osflash.net.http.queues.HTTPBulkQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPBulkQueueTest
	{
		
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
