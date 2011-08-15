package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPSmntCommand extends FTPCommand
	{

		public static const NAME : String = 'SMNT';

		public function FTPSmntCommand()
		{
			super(NAME);
		}
	}
}
