package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPUserCommand extends FTPCommand
	{

		public static const NAME : String = 'USER';

		public function FTPUserCommand()
		{
			super(NAME);
		}
	}
}
