package org.osflash.net.rest
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertTrue;
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.logger.logs.debug;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.net.rest.output.http.RestHTTPOutput;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.support.services.GetUserByIdService;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class RestGetUserByIdTest
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
		public function get_user_by_id_1() : void
		{
			const service : IRestService = new GetUserByIdService(1);
			service.completedSignal.add(async.add(handleUserById1CompletedSignal, 2000));
			service.errorSignal.add(handleErrorSignal);
			
			_rest.add(service);
		}
		
		private function handleUserById1CompletedSignal(service : IRestService) : void
		{
			const getUserByIdService : GetUserByIdService = service as GetUserByIdService;
			
			assertTrue('Service should be GetUserByIdService', service is GetUserByIdService);
			assertNotNull('GetUserByIdService should not be null', getUserByIdService);
			assertNotNull('GetUserByIdService user should not be null', getUserByIdService.user);
			assertEquals('User id should equal 1', 1, getUserByIdService.user.id);
		}
		
		[Test]
		public function get_user_by_id_2() : void
		{
			const service : IRestService = new GetUserByIdService(2);
			service.completedSignal.add(async.add(handleUserById2CompletedSignal, 2000));
			service.errorSignal.add(handleErrorSignal);
			
			_rest.add(service);
		}
		
		private function handleUserById2CompletedSignal(service : IRestService) : void
		{
			const getUserByIdService : GetUserByIdService = service as GetUserByIdService;
			
			assertTrue('Service should be GetUserByIdService', service is GetUserByIdService);
			assertNotNull('GetUserByIdService should not be null', getUserByIdService);
			assertNotNull('GetUserByIdService user should not be null', getUserByIdService.user);
			assertEquals('User id should equal 2', 2, getUserByIdService.user.id);
		}
		
		[Test]
		public function get_user_by_id_999999() : void
		{
			const service : IRestService = new GetUserByIdService(999999);
			service.completedSignal.add(handleUserById999999CompletedSignal);
			service.errorSignal.add(async.add(handleUserById999999ErrorSignal, 10000));
			
			_rest.add(service);
		}
		
		private function handleUserById999999CompletedSignal(service : IRestService) : void
		{
			fail("Failed if called, there shouldn't be a user at 999999");
			
			service;
		}
		
		private function handleUserById999999ErrorSignal(service : IRestService, event : RestErrorEvent) : void
		{
			assertTrue('No user should be found at 999999');
			
			service;
			event;
		}
		
		private function handleErrorSignal(service : IRestService, event : RestErrorEvent) : void
		{
			fail("Failed if called");
			
			service;
			event;
		}
	}
}
