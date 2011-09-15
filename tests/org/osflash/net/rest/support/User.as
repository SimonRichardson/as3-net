package org.osflash.net.rest.support
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class User
	{
		
		public var id : int;
		
		public var firstname : String;
		
		public var lastname : String;
		
		public var company : int;

		public function User(	id : int, 
								firstname : String = '', 
								lastname : String = '', 
								company : int = 0
								)
		{
			if(isNaN(id)) throw new ArgumentError('Id can not be NaN');
			
			this.id = id;
			this.firstname = firstname;
			this.lastname = lastname;
			this.company = company;
		}
	}
}
