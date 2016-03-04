package urgame;

import flambe.Component;
import flambe.Entity;
import flambe.System;
import flambe.display.FillSprite;

import differ.shapes.Circle;
import differ.shapes.Ray;
import differ.shapes.Polygon;
import differ.shapes.Shape;
import differ.Collision;
import differ.ShapeDrawer;
import differ.math.Vector;

import urgame.SDrawer;

class LevelModel extends Component
{
	public static var shapes: Array<Shape>;
	public static var player: Shape;
	public static var drawer: SDrawer;

	public function new ()
	{
		shapes = [];
		drawer = new SDrawer();
		// _ctx = ctx;
		// _enemies = [];
  //       _friendlies = [];
		// score = new Value<Int>(0);
	}

	override public function onAdded ()
	{
		player = new Circle( 225, 200, 10 );

		var circle = new Circle( 300, 200, 50 );
        var box = Polygon.rectangle( 200, 200, 50, 150 );
        var poly = Polygon.triangle(100, 100, 30 );

        shapes.push(circle);
        shapes.push(box);
        shapes.push(poly);
        //shapes.push(player);

        for (shape in shapes)
        {
        	drawer.drawShape(shape);
        }

        drawer.drawShape(player);

       //testCollisions(playerShape, shapes);
	}

	override public function onUpdate (dt :Float)
    {
        var pointerX = System.pointer.x;
        var pointerY = System.pointer.y;

        for (shape in shapes)
        {
        	drawer.drawShape(shape);
        }

        // //player.x = pointerX;
        // //player.y = pointerY;
        
        player.position = new Vector(pointerX, pointerY);
        drawer.drawShape(player);

        testCollisions(player, shapes);
    }

    public static function testCollisions(player:Shape, shapes:Array<Shape>)
	{
		for (shape in shapes)
		{
			var collideInfo = Collision.shapeWithShape(player, shape);

			if(collideInfo != null)
			{
				//trace("collision detected between player and shape");
				//use collideInfo.separationX, collideInfo.separationY
				//    collideInfo.normalAxisX, collideInfo.normalAxisY
				//    collideInfo.overlap

			}
		}
		
	}
}