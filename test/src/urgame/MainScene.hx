package urgame;

import flambe.Entity;

import differ.shapes.Circle;
import differ.shapes.Polygon;
import differ.shapes.Shape;
import differ.Collision;
import differ.ShapeDrawer;

import urgame.SDrawer;
import urgame.DifferSprite;

class MainScene
{
	public static var shapes: Array<Shape>;

	public static function create() :Entity
	{
		var scene = new Entity();

		var circle = new Circle( 300, 200, 50 );
        var box = Polygon.rectangle( 200, 200, 50, 150 );
        var poly = Polygon.triangle(100, 100, 30 );

        var collideInfo = Collision.shapeWithShape( circle, box );

        if(collideInfo != null) {
            trace("collision between circle and box");
        }
        else {
            trace("no collision between circle and box");
        }

        var collideInfo1 = Collision.shapeWithShape( poly, box );

        if(collideInfo1 != null) {
            //use collideInfo.separationX, collideInfo.separationY
            //    collideInfo.normalAxisX, collideInfo.normalAxisY
            //    collideInfo.overlap
            trace("collision between triangle and box");
        }
        else {
            trace("no collision between triangle and box");
        }

        shapes = [];
        shapes.push(circle);
        shapes.push(box);
        shapes.push(poly);

        var difSprite = new DifferSprite(0x03A3B3, 50, 150);
        difSprite.shapes = shapes;

        scene.addChild(new Entity().add(difSprite));

        return scene;
	}
	
}