package urgame;

import flambe.display.Sprite;
import flambe.display.FillSprite;
import flambe.display.Graphics;

import differ.shapes.Shape;
import differ.ShapeDrawer;

import urgame.SDrawer;

class DifferSprite extends FillSprite
{
	public var shapes: Array<Shape>;
	public var drawer: SDrawer;

	override public function draw(g :Graphics)
	{
		if(drawer == null)
		{
			drawer = new SDrawer();
			drawer.newG(g);
		}

		for(shape in shapes)
		{
			drawer.drawShape(shape);
		}
	}

}