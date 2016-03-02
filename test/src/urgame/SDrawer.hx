package urgame;

import flambe.System;
import flambe.display.FillSprite;
import flambe.display.Graphics;
import flambe.display.Sprite;
import differ.math.Vector;
import differ.ShapeDrawer;

import urgame.Line;

class SDrawer extends ShapeDrawer
{
	public var g : Graphics;

	public function newG(g: Graphics)
	{
		this.g = g;
	}

	override public function drawLine( p0:Vector, p1:Vector, ?startPoint:Bool = true )
	 {
	 	/* Next up: drawing actual lines rather than points. How to angle..? */

	 	/*
	 	var point01 = new FillSprite(0x03A3B3, 1, 1);
	 	point01.x._ = p0.x;
	 	point01.y._ = p0.y;
        System.root.addChild(new Entity().add(point01));

        var point02 = new FillSprite(0x03A3B3, 1, 1);
	 	point02.x._ = p1.x;
	 	point02.y._ = p1.y;
        System.root.addChild(new Entity().add(point02));
		*/

        var testLine = new Line(p0, p1, 1);
        System.root.addChild(testLine.addToEntity());


	 }
}