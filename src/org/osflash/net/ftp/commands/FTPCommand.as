package org.osflash.net.ftp.commands
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class FTPCommand
	{
		
		/**
		 * @private
		 */
		private var _name : String;

		public function FTPCommand(name : String)
		{
			if(null == name) throw new ArgumentError('Name can not be null');
			if(name.length == 0) throw new ArgumentError('Name can not be empty');
			
			_name = name;
		}
		
		public function get name() : String { return _name; }
	}
}
