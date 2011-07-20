package org.osflash.net.rest.output.utils
{
	import org.osflash.net.rest.parameters.RestParameter;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function buildURI(	uri : String, 
								method : String, 
								parameters : Vector.<RestParameter>
								) : String
	{
		const euri : String = encodeURI(uri);
		const emethod : String = encodeURI(method);
		
		const buffer : Vector.<String> = new Vector.<String>();
		
		buffer.push(euri.substr(-1) == '/' ? euri.substr(0, -1) : euri);
		buffer.push(emethod);
				
		const total : int = parameters.length;
		for(var i : int = 0; i < total; i++)
		{
			const parameter : RestParameter = parameters[i];
			buffer.push(parameter.parameterAsString);
		}
		
		return buffer.join('/');
	}
}
