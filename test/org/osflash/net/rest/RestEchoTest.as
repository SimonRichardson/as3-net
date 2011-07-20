package org.osflash.net.rest
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.logger.logs.error;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.net.rest.output.http.RestHTTPOutput;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.echo.EchoService;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestEchoTest
	{

		[Inject]
		public var async : IAsync;
		
		private var _rest : RestManager;

		[Before]
		public function setUp() : void
		{
			const queue : IHTTPQueue = new HTTPQueue();
			
			const host : RestHost = new RestHost('http://www.rest.com:80/?platform=yv');
			
			_rest = new RestManager(host);
			_rest.output = new RestHTTPOutput(queue);
		}

		[After]
		public function tearDown() : void
		{
			_rest = null;
		}

		[Test]
		public function create_service_and_execute() : void
		{
			const service : IRestService = new EchoService('ping');
			service.completedSignal.add(async.add(handleCompletedSignal, 1000));
			service.errorSignal.add(handleErrorSignal);
			
			_rest.add(service);
		}
		
		private function handleCompletedSignal(service : IRestService) : void
		{
			const echoService : EchoService = service as EchoService;
			
			assertTrue('Service should be EchoService', service is EchoService);
			assertNotNull('EchoService should not be null', echoService);
			assertEquals('Rest result should equal ping', 'ping', echoService.response);
		}
		
		private function handleErrorSignal(service : IRestService, event : RestErrorEvent) : void
		{
			error(service, event);
			
			fail("Failed if called");
		}
	}
}
