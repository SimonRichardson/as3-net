package org.osflash.net
{
	import org.osflash.net.http.HTTPQueueTest;
	import org.osflash.net.http.HTTPURLoaderBulkQueueTest;
	import org.osflash.net.http.HTTPURLoaderQueueTest;
	import org.osflash.net.rest.RestEchoTest;
	import org.osflash.net.rest.RestGetAllUsersTest;
	import org.osflash.net.rest.RestGetUserByIdTest;
	import org.osflash.net.rest.RestPostUserTest;
	[Suite]
	public class AllTests
	{
		
		public var _HTTPQueueTest : HTTPQueueTest;
		public var _HTTPURLoaderBulkQueueTest : HTTPURLoaderBulkQueueTest;
		public var _HTTPURLoaderQueueTest : HTTPURLoaderQueueTest;
		
		public var _RestEchoTest : RestEchoTest;
		public var _RestGetAllUsersTest : RestGetAllUsersTest;
		public var _RestGetUserByIdTest : RestGetUserByIdTest;
		public var _RestPostUserTest : RestPostUserTest;
	}
}
