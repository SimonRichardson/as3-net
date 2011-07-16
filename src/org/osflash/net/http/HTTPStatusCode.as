package org.osflash.net.http
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class HTTPStatusCode
	{
		
		public static const CONTINUE : int = 100;

		public static const SWITCHING_PROTOCOLS : int = 101;

		public static const PROCESSING : int = 102;

		public static const OK : int = 200;

		public static const CREATED : int = 201;

		public static const ACCEPTED : int = 202;

		public static const NON_AUTHORATIVE_INFORMATION : int = 203;

		public static const NO_CONTENT : int = 204;

		public static const RESET_CONTENT : int = 205;

		public static const PARTIAL_CONTENT : int = 206;

		public static const MULTI_STATUS : int = 207;

		public static const MULTIPLE_CHOICE : int = 300;

		public static const MOVED_PERMANENTLY : int = 301;

		public static const FOUND : int = 302;

		public static const SEE_OTHER : int = 303;

		public static const NOT_MODIFIED : int = 304;

		public static const USE_PROXY : int = 305;

		public static const TEMPORARY_REDIRECT : int = 307;

		public static const BAD_REQUEST : int = 400;

		public static const UNAUTHORIZED : int = 401;

		public static const FORBIDDEN : int = 403;

		public static const NOT_FOUND : int = 404;

		public static const METHOD_NOT_ALLOWED : int = 405;

		public static const NOT_ACCEPTABLE : int = 406;

		public static const PROXY_AUTHENTICATION_REQUIRED : int = 407;

		public static const REQUEST_TIMEOUT : int = 408;

		public static const CONFLICT : int = 409;

		public static const GONE : int = 410;

		public static const LENGTH_REQUIRED : int = 411;

		public static const PRECONDITION_FAILED : int = 412;

		public static const REQUEST_ENTITY_TOO_LARGE : int = 413;

		public static const REQUEST_URI_TOO_LONG : int = 414;

		public static const UNSUPPORTED_MEDIA_TYPE : int = 415;

		public static const REQUEST_RANGE_NOT_SATISFIABLE : int = 416;

		public static const EXPECTATION_FAILED : int = 414;

		public static const TOO_MANY_CONNECTIONS : int = 421;

		public static const UNPROCESSABLE_ENTITY : int = 422;

		public static const LOCKED : int = 423;

		public static const FAILED_DEPENDENCY : int = 424;

		public static const UNORDERED_COLLECTION : int = 425;

		public static const UPGRADE_REQUIRED : int = 426;

		public static const INTERNAL_SERVER_ERROR : int = 500;

		public static const NOT_IMPLEMENTED : int = 501;

		public static const BAD_GATEWAY : int = 502;

		public static const SERVICE_UNAVAILABLE : int = 503;

		public static const GATEWAY_TIMEOUT : int = 504;

		public static const HTTP_VERSION_NOT_SUPPORTED : int = 505;

		public static const VERIANT_ALSO_NEGOTIATES : int = 506;

		public static const INSUFFICIENT_STORAGE : int = 507;

		public static const BANDWIDTH_LIMIT_EXCEEDED : int = 509;

		public static const NOT_EXTENDED : int = 510;
		
		public static function codeToString(code : int) : String 
		{
			switch(code)
			{
				case CONTINUE:
					return "CONTINUE";
                
				case SWITCHING_PROTOCOLS:
					return "SWITCHING_PROTOCOLS";
                
				case PROCESSING:
					return "PROCESSING";
                
				case OK:
					return "OK";
                
				case CREATED:
					return "CREATED";
                
				case ACCEPTED:
					return "ACCEPTED";
                
				case NON_AUTHORATIVE_INFORMATION:
					return "NON_AUTHORATIVE_INFORMATION";
                
				case NO_CONTENT:
					return "NO_CONTENT";
                
				case RESET_CONTENT:
					return "RESET_CONTENT";
                
				case PARTIAL_CONTENT:
					return "PARTIAL_CONTENT";
                
				case MULTI_STATUS:
					return "MULTI_STATUS";
                
				case MULTIPLE_CHOICE:
					return "MULTIPLE_CHOICE";
                
				case MOVED_PERMANENTLY:
					return "MOVED_PERMANENTLY";
                
				case FOUND:
					return "FOUND";
                
				case SEE_OTHER:
					return "SEE_OTHER";
                
				case NOT_MODIFIED:
					return "NOT_MODIFIED";
                
				case USE_PROXY:
					return "USE_PROXY";
                
				case TEMPORARY_REDIRECT:
					return "TEMPORARY_REDIRECT";
                
				case BAD_REQUEST:
					return "BAD_REQUEST";
                
				case UNAUTHORIZED:
					return "UNAUTHORIZED";
                
				case FORBIDDEN:
					return "FORBIDDEN";
                
				case NOT_FOUND:
					return "NOT_FOUND";
                
				case METHOD_NOT_ALLOWED:
					return "METHOD_NOT_ALLOWED";
                
				case NOT_ACCEPTABLE:
					return "NOT_ACCEPTABLE";
                
				case PROXY_AUTHENTICATION_REQUIRED:
					return "PROXY_AUTHENTICATION_REQUIRED";
                
				case REQUEST_TIMEOUT:
					return "REQUEST_TIMEOUT";
                
				case CONFLICT:
					return "CONFLICT";
                
				case GONE:
					return "GONE";
                
				case LENGTH_REQUIRED:
					return "LENGTH_REQUIRED";
                
				case PRECONDITION_FAILED:
					return "PRECONDITION_FAILED";
                
				case REQUEST_ENTITY_TOO_LARGE:
					return "REQUEST_ENTITY_TOO_LARGE";
                
				case REQUEST_URI_TOO_LONG:
					return "REQUEST_URI_TOO_LONG";
                
				case UNSUPPORTED_MEDIA_TYPE:
					return "UNSUPPORTED_MEDIA_TYPE";
                
				case REQUEST_RANGE_NOT_SATISFIABLE:
					return "REQUEST_RANGE_NOT_SATISFIABLE";
                
				case EXPECTATION_FAILED:
					return "EXPECTATION_FAILED";
                
				case TOO_MANY_CONNECTIONS:
					return "TOO_MANY_CONNECTIONS";
                
				case UNPROCESSABLE_ENTITY:
					return "UNPROCESSABLE_ENTITY";
                
				case LOCKED:
					return "LOCKED";
                
				case FAILED_DEPENDENCY:
					return "FAILED_DEPENDENCY";
                
				case UNORDERED_COLLECTION:
					return "UNORDERED_COLLECTION";
                
				case UPGRADE_REQUIRED:
					return "UPGRADE_REQUIRED";
                
				case INTERNAL_SERVER_ERROR:
					return "INTERNAL_SERVER_ERROR";
                
				case NOT_IMPLEMENTED:
					return "NOT_IMPLEMENTED";
                
				case BAD_GATEWAY:
					return "BAD_GATEWAY";
                
				case SERVICE_UNAVAILABLE:
					return "SERVICE_UNAVAILABLE";
                
				case GATEWAY_TIMEOUT:
					return "GATEWAY_TIMEOUT";
                
				case HTTP_VERSION_NOT_SUPPORTED:
					return "HTTP_VERSION_NOT_SUPPORTED";
                
				case VERIANT_ALSO_NEGOTIATES:
					return "VERIANT_ALSO_NEGOTIATES";
                
				case INSUFFICIENT_STORAGE:
					return "INSUFFICIENT_STORAGE";
                
				case BANDWIDTH_LIMIT_EXCEEDED:
					return "BANDWIDTH_LIMIT_EXCEEDED";
                
				case NOT_EXTENDED:
					return "NOT_EXTENDED";
                
				default:
					return "(Unknown: " + code + ")";
			}
		}
	}
}
