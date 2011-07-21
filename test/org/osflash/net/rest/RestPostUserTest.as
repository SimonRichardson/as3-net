package org.osflash.net.rest
{
	import asunit.asserts.fail;
	import asunit.framework.IAsync;

	import org.osflash.logger.logs.debug;
	import org.osflash.net.http.queues.HTTPQueue;
	import org.osflash.net.http.queues.IHTTPQueue;
	import org.osflash.net.rest.events.RestErrorEvent;
	import org.osflash.net.rest.output.http.RestHTTPOutput;
	import org.osflash.net.rest.services.IRestService;
	import org.osflash.net.rest.support.services.PostUserService;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class RestPostUserTest
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
			const time : int = new Date().valueOf();
			const firstName : String = 'Firstname ' + time;
			const lastName : String = 'Lastname' + time;
			
			const service : IRestService = new PostUserService(firstName, lastName);
			service.completedSignal.add(async.add(handleCompletedSignal, 2000));
			service.errorSignal.add(handleErrorSignal);
			
			_rest.add(service);
		}
		
		private function handleCompletedSignal(service : IRestService) : void
		{
			debug(PostUserService(service).user);
		}
		
		private function handleErrorSignal(service : IRestService, event : RestErrorEvent) : void
		{
			fail("Failed if called");
			
			service;
			event;
		}
	}
}
