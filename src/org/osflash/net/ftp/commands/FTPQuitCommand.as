package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPQuitCommand extends FTPCommand
	{

		public static const NAME : String = 'QUIT';

		public function FTPQuitCommand()
		{
			super(NAME);
		}
	}
}
