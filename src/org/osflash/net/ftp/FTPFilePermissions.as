package org.osflash.net.ftp
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class FTPFilePermissions
	{

		public static const NO_PERMISSIONS : FTPFilePermissions = 
														new FTPFilePermissions('no_permissions');

		public static const EXECUTE : FTPFilePermissions = 
														new FTPFilePermissions('execute');

		public static const WRITE : FTPFilePermissions = 
														new FTPFilePermissions('write');
		
		public static const WRITE_EXECUTE : FTPFilePermissions = 
														new FTPFilePermissions('write_execute');

		public static const READ : FTPFilePermissions = 
														new FTPFilePermissions('read');

		public static const READ_EXECUTE : FTPFilePermissions = 
														new FTPFilePermissions('read_execute');

		public static const READ_WRITE : FTPFilePermissions = 
														new FTPFilePermissions('read_write');

		public static const READ_WRITE_EXECUTE : FTPFilePermissions = 
														new FTPFilePermissions('read_write_execute');
		
		/**
		 * @private
		 */
		private var _type : String;

		public function FTPFilePermissions(type : String)
		{
			if(null == type) throw new ArgumentError('Type can not be null');
			_type = type;
		}
		
		public function get type() : String { return _type; }

	}
}
