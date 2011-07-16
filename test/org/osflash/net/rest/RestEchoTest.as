package org.osflash.net.rest
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.services.echo.EchoService;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestEchoTest
	{

		[Inject]
		public var async : IAsync;
		
		private var _rest : Rest;

		[Before]
		public function setUp() : void
		{
			_rest = new Rest();
		}

		[After]
		public function tearDown() : void
		{
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
		
		private function handleErrorSignal() : void
		{
			fail("Failed if called");
		}
	}
}
