package com.am_devcorp.algo.terrain 
{
	import com.am_devcorp.algo.terrain.materials.*
	import com.am_devcorp.mathtricks.mathtricks;
	/**
	 * ...
	 * @author Alexey Malyavkin <a@malyavk.in>
	 */
	public class mpdp 
	{
		private var heightmap:Vector.<Number>
		public var map:Vector.<Vector.<material>>
		var size:int
		var height:int
		public function mpdp(s:int, landscapeHeight:int ) 
		{
			height = landscapeHeight
			size = s
		}
		private function initMap():void 
		{
			size = Math.pow(2, Math.ceil(mathtricks.lb(size)))
			heightmap = new Vector.<Number>;
			heightmap.length = size + 1;
			
			map = new Vector.<Vector.<material>>
			map.length = size + 1;
			for (var i:int = 0; i < map.length; i++) 
			{
				map[i] =  new Vector.<material>;
				map[i].length = height + 1;
			}
		}
		public function mapgen(rgh:Number = 1):Boolean 
		{
			var pure_land:Boolean
			initMap()
			heightmap[0] = Math.random() * height
			heightmap[size] = Math.random() * height
			process(0, size, rgh/2);
			pure_land = fit()
			//normalize(0, 64)
			round()
			for (var i:int = 0; i < heightmap.length; i++) 
			{
				map[i][heightmap[i]] = new material_grass()
				for (var j:int = 0; j < heightmap[i]; j++) 
				{
					map[i][j] = new material_stone()
				}
			}
			return pure_land;
		}
		private function process(l:int, r:int, rgh:Number = 1):void 
		{
			if (r - l - 1)
			{
				var i:int = (r + l) / 2
				heightmap[i] = mathtricks.mean(heightmap[l], heightmap[r]) + (Math.random()*(2*rgh * (r - l)) - rgh * (r - l))
				if (i - l - 1)
				{
					process(l, i, rgh)
					process(i, r, rgh)
				}
			}
			return;
		}
		private function round():void 
		{
			for (var i:int = 0; i < heightmap.length; i++) 
			{
				heightmap[i] = Math.round(heightmap[i])
			}
		}
		private function fit():Boolean 
		{
			var highest:Number = heightmap[0]
			var lowest:Number = heightmap[0]
			//analyzing
			for (var i:int = 0; i < heightmap.length; i++) 
			{
				if (heightmap[i]> highest) highest = heightmap[i]
				if (heightmap[i]< lowest)	lowest = heightmap[i]
			
			}
			var success:Boolean = true
			if (lowest < 0) // lift it up
			{
				success = false
				for (var i:int = 0; i < heightmap.length; i++) 
				{
					heightmap[i] -=lowest
				}
				highest -= lowest
				lowest = 0
			}
			
			if (highest > height)
			{
				success = false
				for (var i:int = 0; i < heightmap.length; i++) 
				{
					heightmap[i]*= (height/highest)
				}
				highest = height
				lowest*= (height/highest)
			}
			return(success)
		}
		private function normalize(min:Number, max:Number):void 
		{
			var highest:Number = heightmap[0]
			var lowest:Number = heightmap[0]
			//analyzing
			for (var i:int = 0; i < heightmap.length; i++) 
			{
				if (heightmap[i]> highest) highest = heightmap[i]
				if (heightmap[i]< lowest)	lowest = heightmap[i]
			
			}
			trace(highest,lowest)
			var d:Number = (highest - lowest)/(max-min)
			var b:Number = min-(lowest/d)
			//normalizing
			for (var i:int = 0; i < heightmap.length; i++) 
			{
				heightmap[i] = (heightmap[i]/d+b)
			}
		}
	}
}