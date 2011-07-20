package org.osflash.net.rest.output.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function buildURI(uri : String, method : String) : String
	{
		const euri : String = encodeURI(uri);
		const emethod : String = encodeURI(method);
		
		return (euri.substr(-1) == '/' ? euri : euri + '/') + emethod;
	}
}
