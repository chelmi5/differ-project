package shmup.differobjects;

import flambe.System;

import differ.ShapeDrawer;
import differ.math.Vector;

import flambe.display.Graphics;
import flambe.math.FMath;

class ShapeDrawerFlambe extends ShapeDrawer
{
	public var g : Graphics;
	public var c : Int;

	public function new(g : Graphics)
	{
		super();
		this.g = g;
		c = 0xFF0000;
	}

	public function setCurrentColor(color : Int)
	{
		c = color;
	}

	override public function drawLine(p0:Vector, p1:Vector, ?startPoint:Bool) : Void
	{
		g.save();

		var angle = getAngle(p0, p1);

		g.translate(p0.x, p0.y);
		g.rotate(getAngle(p0,p1));
		g.fillRect(c, 0, 0, 1, getDistance(p0, p1));
		g.restore();
	}

	 /* A^2 + B^2 = C^2 essentially. Returns the distance/length between two vectors */
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
		angle = FMath.toDegrees(angle) + 90; //To degrees + adjustment
		return angle;
	}
}