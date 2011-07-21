package org.osflash.net.rest.output.utils
{
	import org.osflash.net.http.uri.HTTPURI;
	import org.osflash.net.rest.parameters.RestParameter;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function buildURI(	uri : HTTPURI, 
								method : String,
								parameters : Vector.<RestParameter>
								) : String
	{
		
		const base : String = uri.getBaseURI();
		const buffer : Vector.<String> = new Vector.<String>();
		
		buffer.push(base.substr(-1) == '/' ? base.substr(0, -1) : base);
		buffer.push(encodeURIComponent(method));
				
		const total : int = parameters.length;
		for(var i : int = 0; i < total; i++)
		{
			const parameter : RestParameter = parameters[i];
			buffer.push(parameter.parameterAsString);
		}
		
		const extension : String = uri.extension.length > 0 ? '.' + uri.extension : '';
		const uriParameters : String = uri.parameters.length > 0 ? 
													'?' + uri.getParametersAsString() : 
													'';
		
		return buffer.join('/') + extension + uriParameters;
	}
}
