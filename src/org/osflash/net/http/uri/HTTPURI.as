package org.osflash.net.http.uri
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPURI
	{
		/**
		 * Regular expression to split the host pattern
		 */
		private static const PATTERN : RegExp = /(?P<protocol>[a-zA-Z]+):\/\/(?P<host>[^:\/]*)(:(?P<port>\d+))?((?P<path>[^?]*))?((?P<parameters>.*))?/x;
		
		private static const DEFAULT_PROTOCOL : String = 'http';
		
		/**
		 * @private
		 */
		private var _uri : String;

		/**
		 * @private
		 */
		private var _protocol : String;

		/**
		 * @private
		 */
		private var _host : String;

		/**
		 * @private
		 */
		private var _port : Number;

		/**
		 * @private
		 */
		private var _path : String;

		/**
		 * @private
		 */
		private var _paths : Vector.<String>;

		/**
		 * @private
		 */
		private var _extension : String;
		
		/**
		 * @private
		 */
		private var _parameters : Vector.<HTTPURIParameter>;

		/**
		 * Constructor for the HTTP URI Parser
		 * 
		 * @param uri String
		 */
		public function HTTPURI(uri : String)
		{
			_uri = uri;

			parse();
		}

		private function parse() : void
		{
			const results : Object = PATTERN.exec(_uri);

			if (null == results)
			{
				// Make sure we have a default protocol.
				if(uri.indexOf(DEFAULT_PROTOCOL + '://') == -1) 
				{
					_uri = DEFAULT_PROTOCOL + '://' + uri;
					parse();
				}
				
				return;
			}

			_protocol = encodeURIComponent(results["protocol"]);
			_host = encodeURIComponent(results["host"]);
			_port = 80;

			if (null == results["port"] || results["port"] == "")
			{
				_port = isNaN(parseInt(results["port"])) ? 80 : parseInt(results["port"]);
			}

			_path = encodeURI(results["path"]);

			const paths : String = results["path"];
			const pathsValue : Array = paths.split("/");
			const pathsTotal : int = pathsValue.length;
			
			_paths = new Vector.<String>(pathsTotal, true);
			_extension = "";

			for (var j : int = 0; j < pathsTotal; j++)
			{
				var p : String = pathsValue[j];
				if (j == pathsTotal - 1)
				{
					const index : int = p.lastIndexOf(".");
					if (index >= 0)
					{
						_extension = p.slice(index + 1);
						p = p.slice(0, index);
					}
				}
				
				_paths[j] = encodeURIComponent(p);
			}
			
			_parameters = new Vector.<HTTPURIParameter>();

			var params : String = results["parameters"];
			if (null != params && params != "")
			{
				if (params.charCodeAt(0) == 63) params = params.substring(1);
				
				// This doesn't cater for &amp;
				const pairs : Array = params.split("&");
				const total : int = pairs.length;
				for (var i : int = 0; i < total; i++)
				{
					_parameters.push(HTTPURIParameter.fromUniformedString(pairs[i]));
				}
			}
		}
		
		public function getBaseURI() : String
		{
			const buffer : Vector.<String> = new Vector.<String>();
			
			buffer.push(protocol);
			buffer.push('://');
			buffer.push(host);
			
			if(port != 80) buffer.push(':', port);
			
			if(null != paths && paths.length > 0) 
				buffer.splice.apply(null, [buffer.length, 0, paths.join('/')]);
			
			return buffer.join('');
		}
		
		public function getParametersAsString() : String
		{
			const total : int = _parameters.length;
			if(total == 0) return '';
			else if(total == 1) return _parameters[0].getParameterAsString();
			else 
			{
				const buffer : Vector.<String> = new Vector.<String>();
				
				for(var i : int = 0; i<total; i++)
				{
					const parameter : HTTPURIParameter = _parameters[i];
					buffer.push(parameter.getParameterAsString());
				}
				
				return buffer.join('&');
			}
		}
		
		/**
		 * Get the original URI
		 * 
		 * @return String
		 */
		public function get uri() : String { return _uri; }

		/**
		 * Get the Protocol from the URI
		 * 
		 * @return String
		 */
		public function get protocol() : String { return _protocol; }

		/**
		 * Get the Host from the URI
		 * 
		 * @return String
		 */
		public function get host() : String { return _host; }

		/**
		 * Get the Port from the URI
		 * 
		 * @return String
		 */
		public function get port() : int { return _port; }

		/**
		 * Get the Path from the URI
		 * 
		 * @return String
		 */
		public function get path() : String { return _path; }

		/**
		 * Get the path as a Vector.<String>
		 * 
		 * @return Vector.<String>
		 */
		public function get paths() : Vector.<String> { return _paths; }

		/**
		 * Get the extension of the URI
		 * 
		 * @return String
		 */
		public function get extension() : String { return _extension; }

		/**
		 * Get the Parameters from the URI
		 * 
		 * @return Vector.<HTTPUniformResourceIdentifierParameters>
		 */
		public function get parameters() : Vector.<HTTPURIParameter> { return _parameters; }
	}
}
