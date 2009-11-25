package as3geometry.geom2D.immutable 
{
	import as3geometry.geom2D.Vertex;
	import as3geometry.geom2D.errors.MutabilityError;
	import as3geometry.geom2D.mutable.MutableVertex;

	import asunit.asserts.fail;

	public class ImmutablePolygonTest
	{
		private var polygon:ImmutablePolygon;
		
		[After]
		public function tearDown():void
		{
			polygon = null;
		}
		
		[Test]
		public function mutableErrorIsThrown():void
		{
			var a:MutableVertex = new MutableVertex(1,0);
			var b:ImmutableVertex = new ImmutableVertex(1,1);
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();
			vertices[0] = a;
			
			try
			{
				polygon = new ImmutablePolygon(vertices);
			}
			catch (error:MutabilityError)
			{
				return;
			}
			
			fail("ImmutablePolygon should throw a mutability error if a mutable vertex is used as a defining point");
		}
		
	}
}