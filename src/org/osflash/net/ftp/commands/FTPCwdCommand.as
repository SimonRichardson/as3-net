package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPCwdCommand extends FTPCommand
	{

		public static const NAME : String = 'CWD';

		public function FTPCwdCommand()
		{
			super(NAME);
		}
	}
}
