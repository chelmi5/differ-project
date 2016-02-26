package urgame;

import flambe.display.Sprite;
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
	 	//var line = new Sprite();

	 	g.fillRect(0x03A3B3, p0x.x, p0y.y, 1, 1);
//	 	var s:Sprite = new FillSprite(0x03A3B3, 10, 3);
	 	/*
	 	g.save()
		g.rotate(radians);
		g.translate(x, y);
		g.fillRect(color, 0, 0, width._, height._);
		g.restore()
		*/
	 }
}