package org.osflash.net.ftp
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPFileGroupPermissions
	{
		
		public static const USER : FTPFileGroupPermissions = new FTPFileGroupPermissions('user');

		public static const GROUP : FTPFileGroupPermissions = new FTPFileGroupPermissions('group');

		public static const OTHER : FTPFileGroupPermissions = new FTPFileGroupPermissions('other');
		
		/**
		 * @private
		 */
		private var _type : String;

		public function FTPFileGroupPermissions(type : String)
		{
			if(null == type) throw new ArgumentError('Type can not be null');
			_type = type;
		}
		
		public function get type() : String { return _type; }
	}
}
