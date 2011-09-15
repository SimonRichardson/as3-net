package org.osflash.net.rest
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.net.rest.output.http.RestHTTPOutput;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.support.services.GetAllUsersService;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class RestGetAllUsersTest
	{
		
		[Inject]
		public var async : IAsync;
		
		private var _rest : RestManager;

		[Before]
		public function setUp() : void
		{
			const queue : IHTTPQueue = new HTTPQueue();
			
			const host : RestHost = new RestHost('rest.com');
			
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
			const service : IRestService = new GetAllUsersService();
			service.completedSignal.add(async.add(handleCompletedSignal, 2000));
			service.errorSignal.add(handleErrorSignal);
			
			_rest.add(service);
		}
		
		private function handleCompletedSignal(service : IRestService) : void
		{
			const getAllUsersService : GetAllUsersService = service as GetAllUsersService;
			
			assertTrue('Service should be GetAllUsersService', service is GetAllUsersService);
			assertNotNull('GetAllUsersService should not be null', getAllUsersService);
			assertNotNull('GetAllUsersService users should not be null', getAllUsersService.users);
			assertTrue('Users should be greater than 0', getAllUsersService.users.length > 0);
		}
		
		private function handleErrorSignal(service : IRestService, event : RestErrorEvent) : void
		{
			fail("Failed if called");
			
			service;
			event;
		}
	}
}
