package org.osflash.net.http
{
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.net.http.monitor.HTTPMonitor;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPMonitorTest
	{
		
		[Inject]
		public var async : IAsync;
		
		private var _monitor : HTTPMonitor;
		
		[Before]
		public function setUp() : void
		{
			_monitor = new HTTPMonitor(1000);
		}

		[After]
		public function tearDown() : void
		{
			_monitor = null;
		}
		
		[Test]
		public function monitor_start() : void
		{
			_monitor.statusSignal.add(async.add(handleStatusSignal, 2000));
			_monitor.start();
		}
		
		private function handleStatusSignal(value : Boolean) : void
		{
			if(!value) fail('No internet found');
			else assertTrue('Internet found', value);
			
			_monitor.stop();
		}
	}
}
