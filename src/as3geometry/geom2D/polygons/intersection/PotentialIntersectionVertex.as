package as3geometry.geom2D.polygons.intersection 
{
	import as3geometry.AS3GeometryContext;
	import as3geometry.abstract.Mutable;
	import as3geometry.geom2D.Line;
	import as3geometry.geom2D.line.IntersectionOfTwoLinesVertex;

	import org.osflash.signals.Signal;

	/**
	 * A vertex that lies on the intersection of two vertices
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	internal class PotentialIntersectionVertex extends ExpandedPolygonVertex implements Mutable
	{
		private var _intersection:IntersectionOfTwoLinesVertex;
		
		private var _changed:Signal;
		
		private var _realityChanged:Signal;
		
		private var _aIndex:uint;
		
		private var _bIndex:uint;

		public function PotentialIntersectionVertex(context:AS3GeometryContext, a:Line, b:Line, aIndex:uint, bIndex:uint)
		{
			super(context);
			
			_intersection = new IntersectionOfTwoLinesVertex(a, b);
			context.invalidationManager.addDependency(_intersection, this);
			
			_changed = new Signal(Mutable);
			_aIndex = aIndex;
			
			_realityChanged = new Signal(PotentialIntersectionVertex);
			resolve();
		}
		
		private function resolve():void
		{
			var x:Number = _intersection.x;
			var y:Number = _intersection.y;
			
			var newIsIntersection:Boolean = !isNaN(x) && !isNaN(y);
			var realValueHasChanged:Boolean = isReal != newIsIntersection;
			
			isReal = newIsIntersection;
			
			if (isReal)
			{
				positionOnPolygonAAsCycle = _aIndex + _intersection.aMultiplier;
				positionOnPolygonBAsCycle = _bIndex + _intersection.bMultiplier;
			}
			else
			{
				positionOnPolygonAAsCycle = Number.NaN;
				positionOnPolygonBAsCycle = Number.NaN;
			}
			
			if (realValueHasChanged)
				_realityChanged.dispatch(this);
		}

		public function toString() : String
		{
			var str:String = "Intersection: (@X@,@Y@)";
			str = str.replace("@X@", x);
			
			return str;
		}
		
		public function get changed():Signal
		{
			return _changed;
		}
		
		public function get realityChanged():Signal
		{
			return _realityChanged;
		}

		override public function get x():Number
		{
			return _intersection.x;
		}

		override public function get y():Number
		{
			return _intersection.y;
		}
		
		public function get a():Line
		{
			return _intersection.a;
		}
		
		public function get b():Line
		{
			return _intersection.b;
		}
	}
}