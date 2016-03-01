package urgame;

import flambe.Entity;
import flambe.System;
import flambe.display.FillSprite;
import flambe.display.Graphics;
import differ.math.Vector;
import differ.ShapeDrawer;

class SDrawer extends ShapeDrawer
{
	public var g : Graphics;

	public function newG(g: Graphics)
	{
		this.g = g;
	}

	//need to override drawline
	override public function drawLine( p0:Vector, p1:Vector, ?startPoint:Bool = true )
	 {
	 	trace("drawline");

	 	var point01 = new FillSprite(0x03A3B3, 1, 1);
	 	point01.x._ = p0.x;
	 	point01.y._ = p0.y;
        System.root.addChild(new Entity().add(point01));

        var point02 = new FillSprite(0x03A3B3, 1, 1);
	 	point02.x._ = p1.x;
	 	point02.y._ = p1.y;
        System.root.addChild(new Entity().add(point02));

	 	//g.fillRect(0x03A3B3, p0.x, p0.y, 1, 1);

	 	//var line:Sprite = new FillSprite(0x03A3B3, 10, 3);
	 	/*
	 	g.save()
		g.rotate(radians);
		g.translate(x, y);
		g.fillRect(color, 0, 0, width._, height._);
		g.restore()
		*/
	 }
}