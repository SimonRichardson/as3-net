package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPAcctCommand extends FTPCommand
	{

		public static const NAME : String = 'ACCT';

		public function FTPAcctCommand()
		{
			super(NAME);
		}
	}
}
