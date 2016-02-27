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
	 override public function drawLine( p0x:Vector, p0y:Vector, ?startPoint:Bool = true )
	 {

	 	//g.fillRect(0x03A3B3, p0x.x, p0y.y, 1, 1);


	 	var test = new FillSprite(0x03A3B3, 50, 50);
        System.root.addChild(new Entity().add(test));

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