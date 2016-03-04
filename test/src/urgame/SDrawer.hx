package urgame;

import flambe.System;
import flambe.Entity;
import flambe.display.FillSprite;
import flambe.display.Graphics;
import flambe.display.Sprite;
import differ.math.Vector;
import differ.ShapeDrawer;

import urgame.DifferLineSprite;

class SDrawer extends ShapeDrawer
{
	public var g : Graphics;
	public var line : TestLineSprite;//DifferLineSprite;
	public var angle : Float;

	override public function drawLine( p0:Vector, p1:Vector, ?startPoint:Bool = true )
	 {
	 	//trace("drawline");
        //line = new DifferLineSprite(p0, p1, 1);
        angle = getAngle(p0, p1);

        if(line == null)
        {
        	//trace("line == null");
        	//line = new DifferLineSprite(p0, p1, 1);
        	line = new TestLineSprite(0xFFFFFF, getDistance(p0, p1), getAngle(p0, p1));
        	line.setStartingPoint(p0);
        	line.setEndingPoint(p1);
        }
        else
        {
        	//trace("line != null");
        	//line = newUpdate(p0, p1, 1);
        	line.newUpdate(p0, p1, 1);//new TestLineSprite(0xFFFFFF, getDistance(p0, p1), getAngle(p0, p1));
        	//line.setStartingPoint(p0);
        	//line.setEndingPoint(p1);
        }

        //System.root.addChild(line.addToEntity());
        //System.root.addChild(new Entity().add(line));
	 }


	 /* A^2 + B^2 = C^2 essentially. */
	public function getDistance(p0:Vector, p1:Vector):Float
	{
		var d:Float = Math.pow((p0.x - p1.x), 2) + Math.pow((p0.y - p1.y), 2);
		d = Math.pow(d, 0.5);
		return d;
	}

	/*
			(x0, y0)
			    P
				 \
				  \
			    .  P (x1, y1)
			  (x,y)

		This function gets points (x,y) from vStart and vEnd, then calculates the angle using the atan2 function	    
	*/
	public function getAngle(p0:Vector, p1:Vector):Float
	{
		var x:Float = p0.x - p1.x;
		var y:Float = p0.y - p1.y;
		var angle:Float = Math.atan2(y, x); //returns the arctangent of the quotient of its arguments in radians
		angle = angle*(180 / Math.PI); //Convert radians to degrees
		return angle;
	}
}