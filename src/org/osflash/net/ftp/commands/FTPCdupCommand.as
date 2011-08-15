package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPCdupCommand extends FTPCommand
	{

		public static const NAME : String = 'CDUP';

		public function FTPCdupCommand()
		{
			super(NAME);
		}
	}
}
