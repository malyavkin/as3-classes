package com.am_devcorp.algo.terrain
{
	import am_devcorp.mathtricks.mathtricks;
	import flash.display.InterpolationMethod;
	import foxaweb.utils.Raster;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class disq 
	{
		public var map:Vector.<Vector.<Number>>
		public var size:int
		public function disq(a:int) 
		{
			size = a
		}
		private function initMap():void 
		{
			size = Math.pow(2, Math.ceil(mathtricks.lb(size)))
			map = new Vector.<Vector.<Number>>;
			map.length = size+1
			for (var i:int = 0; i < map.length; i++) 
			{
				map[i] = new Vector.<Number>
				map[i].length = size+1
			}
		}
		public function getPeaks():void 
		{
			
		}
		public function mapgen(rgh:Number = 1):void 
		{
			
			initMap()
			var step:int  = map.length - 1
			var map_d:int = map.length-1
			var map_r:int = map[0].length - 1 
			
			map[0][0] 			= Math.random() * rgh
			map[0][map_r] 		= Math.random() * rgh
			map[map_d][map_r] 	= Math.random() * rgh
			map[map_d][0] 		= Math.random() * rgh
			
			while (step>1) 
			{
				var noise:Number = rgh * step
				//square
				for (var i:int = 0; i < map_d/step; i++) 
				{
					for (var j:int = 0; j < map_r/step; j++) 
					{
						//base points
						var l:int = step * j
						var r:int = l + step
						var t:int = step * i
						var d:int = t + step 
						var x:int = (l + r) / 2
						var y:int = (t + d) / 2
						//center
						map[y][x] = mathtricks.mean(map[t][l],map[t][r],map[d][r],map[d][l]) + (Math.random()-0.5) *noise
					}
				}
				//diamond
				for (var i:int = 0; i < map_d/step; i++) 
				{
					for (var j:int = 0; j < map_r/step; j++) 
					{
						//base points
						var l:int = step * j
						var r:int = l + step
						var t:int = step * i
						var d:int = t + step 
						var x:int = (l + r) / 2
						var y:int = (t + d) / 2
						//extra points
						var ll:int = 2 * l - x
						var tt:int = 2 * t - y
						var rr:int = 2 * r - x
						var dd:int = 2 * d - y
						//up
						if (!map[t][x])
						{
							if (t > 0)
							{
								map[t][x] = mathtricks.mean(map[tt][x],map[t][r],map[y][x],map[t][l])
							} else {
								map[t][x] = mathtricks.mean(map[t][r],map[y][x],map[t][l])
							}
							map[t][x]+= (Math.random()-0.5) *noise
						}
						//right
						if (!map[y][r])
						{
							if (r < map_r)
							{
								map[y][r] = mathtricks.mean(map[t][r],map[y][rr],map[d][r],map[y][x])
							} else {
								map[y][r] = mathtricks.mean(map[t][r],map[d][r],map[y][x])
							}
							map[y][r]+= (Math.random()-0.5) *noise
						}
						
						//down
						if (!map[d][x])
						{
							if (d < map_d)
							{
								map[d][x] = mathtricks.mean(map[y][x],map[d][r],map[dd][x],map[d][l])
							} else {
								map[d][x] = mathtricks.mean(map[y][x],map[d][r],map[d][l])
							}
							map[d][x]+= (Math.random()-0.5) *noise
						}
						
						//left
						if (!map[y][l])
						{
							if (l > 0)
							{
								map[y][l] = mathtricks.mean(map[t][l],map[y][x],map[d][l],map[y][ll])
							} else {
								map[y][l] = mathtricks.mean(map[t][l],map[y][x],map[d][l])
							}
							map[y][l]+= (Math.random()-0.5) *noise
						}
					}
				}
				step /= 2
			}
			
			return;
		}		
		public function normalizeExceptZeros():void  // matrice must be [0;1]
		{
			var success:Boolean = true
			var highest:Number = 0
			var lowest:Number = 1
			//analyzing
			for (var i:int = 0; i < map.length; i++) 
			{
				for (var j:int = 0; j < map[0].length; j++) 
				{
					if (map[i][j] > 1 || map[i][j] < 0 )
					{
						success = false
					}
					if (map[i][j] > highest)
					{
						highest = map[i][j]
					}
					if (map[i][j] < lowest && map[i][j])
					{
						lowest = map[i][j]
					}
				}
			}
			//working
			if (success) 
			{
				var d:Number = highest - lowest
				var b:Number = -(lowest/d)
				//normalizing
				for (var i:int = 0; i < map.length; i++) 
				{
					for (var j:int = 0; j < map[0].length; j++) 
					{
						if(map[i][j])map[i][j] = map[i][j]/d+b
					}
				}
			}
		}
		public function normalize(min:Number,max:Number):void 
		{
			var highest:Number = map[0][0];
			var lowest:Number = map[0][0];
			//analyzing
			for (var i:int = 0; i < map.length; i++) 
			{
				for (var j:int = 0; j < map[0].length; j++) 
				{
					if (map[i][j]> highest) highest = map[i][j]
					if (map[i][j]< lowest)	lowest = map[i][j]
				}
			}
			var d:Number = highest - lowest
			var b:Number = min-(lowest/d)
			//normalizing
			for (var i:int = 0; i < map.length; i++) 
			{
				for (var j:int = 0; j < map[0].length; j++) 
				{
					map[i][j] = map[i][j]/d+b
				}
			}
			
		}
		public function treshold(lvl:Number):void 
		{
			var highest:Number = map[0][0];
			var lowest:Number = map[0][0];
			//analyzing
			for (var i:int = 0; i < map.length; i++) 
			{
				for (var j:int = 0; j < map[0].length; j++) 
				{
					if (map[i][j]> highest) highest = map[i][j]
					if (map[i][j]< lowest)	lowest = map[i][j]
				}
			}
			var level:Number = lvl * (highest - lowest) + lowest
			//modifying
			for (var i:int = 0; i < map.length; i++) 
			{
				for (var j:int = 0; j < map[0].length; j++) 
				{
					if (map[i][j]< level) map[i][j] = lowest
				}
			}
		}
	}
	
}