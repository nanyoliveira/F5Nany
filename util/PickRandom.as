package F5Nany.util {
	/**
	 * @author aoliveira2
	 */
	public class PickRandom {
		
		/*
		 * pick a random item between a range of items in a Vector Array
		 */
		public function PickRandom():void
		{}
		
		
		public static function vector($vector:Vector.<Client>):Vector.<Client>
		{
			return $vector.splice(Math.round(Math.random()*($vector.length-1)), 1);
		}
	}
}
