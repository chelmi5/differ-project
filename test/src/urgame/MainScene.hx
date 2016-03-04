package urgame;

import flambe.Entity;
import flambe.display.FillSprite;

import differ.shapes.Circle;
import differ.shapes.Ray;
import differ.shapes.Polygon;
import differ.shapes.Shape;
import differ.Collision;
import differ.ShapeDrawer;

import urgame.SDrawer;
import urgame.LevelModel;

class MainScene
{
	public static var shapes: Array<Shape>;
	public static var player: Shape;
	public static var drawer: SDrawer;

	public static function create() :Entity
	{
		var scene = new Entity();

		var level = new LevelModel();
		scene.add(level);

        return scene;
	}

	//not in use, only tests collisions once since it's not in a game loop
	public static function testCollisions(player:Shape, shapes:Array<Shape>)
	{
		for (shape in shapes)
		{
			var collideInfo = Collision.shapeWithShape(player, shape);

			if(collideInfo != null)
			{
				trace("collision detected between player and shape");
				//use collideInfo.separationX, collideInfo.separationY
				//    collideInfo.normalAxisX, collideInfo.normalAxisY
				//    collideInfo.overlap

			}
		}
		
	}
	
}