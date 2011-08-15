package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPPassCommand extends FTPCommand
	{

		public static const NAME : String = 'PASS';

		public function FTPPassCommand()
		{
			super(NAME);
		}
	}
}
