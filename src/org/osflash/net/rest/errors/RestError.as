package org.osflash.net.rest.errors
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class RestError extends Error
	{

		public function RestError(message : String)
		{
			super(message);
		}
	}
}
