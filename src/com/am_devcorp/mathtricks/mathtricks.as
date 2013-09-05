package com.am_devcorp.mathtricks 
{
	import flash.geom.Point;
	/**
	 * Just because
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public final class mathtricks 
	{
		/**
		 * cosine of angle between vectors 
		 * @param	x1
		 * @param	x2
		 * @param	y1
		 * @param	y2
		 * @param	z1
		 * @param	z2
		 * @return cosine of angle between vectors in radians
		 */
		public static function angle(x1:Number,x2:Number,y1:Number,y2:Number,z1:Number = 0, z2:Number = 0):Number
		{
			return ((x1*x2+y1*y2+z1*z2)/(Math.sqrt(x1*x1+y1*y1+z1*z1)*Math.sqrt(x2*x2+y2*y2+z2*z2)))
		}
		
		/**
		 * decimal logarithm
		 */
		public static function lg(x:Number):Number
		{
			return Math.log(x)/Math.LN10
		}
		/**
		 * binary logarithm
		 */
		public static function lb(x:Number):Number
		{
			return Math.log(x)/Math.LN2
		}
		/**
		 * mean value
		 */
		public static function mean(...rest):Number
		{
			var m:Number = 0
			for (var i:int = 0; i < rest.length; i++) 
			{
				m += rest[i]
			}
			return m/rest.length
		}
		/**
		 * Indicates which way we turn at point B, when we go on the route ABC. Left turn — negative return, right turn — positive
		 * @param	A Point A
		 * @param	B Point B
		 * @param	C Point C
		 */
		public static function rotate(A:Point,B:Point,C:Point):Number 
		{
			var aaa:Number = (B.x-A.x)*(C.y-B.y)-(B.y-A.y)*(C.x-B.x)
			return aaa
		}
		//I <3 Python
		public static function range(...rest):Vector.<uint>
		{
			var r:Vector.<uint> = new Vector.<uint>
			switch(rest.length)
			{
				case 1:
					var limit:uint = rest[0] as uint
					for (var i:int = 0; i < limit; i++) 
					{
						r.push(i)
					}
				break;
			case 2:
					var start:uint = rest[0] as uint
					var end:uint = rest[1] as uint
					for (var i2:int = start; i2< limit; i2++) 
					{
						r.push(i2)
					}
				break
			}
			return r
		}
		/**
		 *
		 * @return two Number values which represent how intersection point [x] divides segments [0]-[1] and [2]-[3]. It looks like [0]=0 => [x]=i => [1]=1 and [2]=0 => [x]=j => [3]=1
		 */
		//public static function getIntersect(i:Vector.<Number>, j:Vector.<Number>):Vector.<Number>
		public static function getIntersect(i0:Number,i1:Number,i2:Number,i3:Number,j0:Number,j1:Number,j2:Number,j3:Number):Vector.<Number>
		{
			//if (j.length != i.length && i.length !=4) 
			//{
			//	return null
			//}
			var result:Vector.<Number> = new <Number>[0,0];
			result[0] = (((j0 - j2) * (i3 - i2) - (i0 - i2) * (j3 - j2)) / ((i1 - i0) * (j3 - j2) - (j1 - j0) * (i3 - i2)));
			result[1] = (((j2 - j0) * (i1 - i0) - (i2 - i0) * (j1 - j0)) / ((i3 - i2) * (j1 - j0) - (j3 - j2) * (i1 - i0)));
			return result
		}
		public static function minProp(coefficient:Function, obj:Array):uint
		{
			var minIndex:uint = 0
			for (var i:int = 1; i < obj.length; i++) 
			{
				if (coefficient(obj[i]) < coefficient(obj[minIndex])) 
				{
					minIndex = i
				}
			}
			return minIndex
		}
		
	}

}