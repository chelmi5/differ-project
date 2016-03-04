package urgame;

import flambe.System;
import flambe.display.Sprite;
import flambe.display.Graphics;

import differ.ShapeDrawer;
import differ.shapes.Shape;

class DifferSprite extends Sprite
{
	private var shapes: Array<Shape>;
	//private var drawer: SDrawer;

	public function new ()
	{
		super();
		shapes = [];
	}

	public function addShape(shape : Shape) : DifferSprite
	{
		shapes.push(shape);
		return this;
	}

	public function removeShape(shape : Shape) : DifferSprite
	{
		if(!shapes.remove(shape))
		{
			trace("did not successfully remove shape");
		}
		
		return this;
	}

	public function clearShapes() : DifferSprite
	{
		shapes = [];
		return this;
	}

	override public function draw (g : Graphics)
	{
		g.rotate(20);
		g.fillRect(0xFF0000, System.stage.width/2, System.stage.height/2, 200, 10);

		g.rotate(10);
		g.fillRect(0xFF0000, System.stage.width/2, System.stage.height/2, 200, 10);

		/*
			if(SD == null)
			{
				SD = new ShapeDrawer(g);
			}

			for(shape in shapes)
			{
				SD.drawShape(shape);
			}
		*/

	}
}