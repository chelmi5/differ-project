package urgame;

import flambe.System;
import flambe.display.Sprite;
import flambe.display.Graphics;

import differ.ShapeDrawer;
import differ.shapes.Shape;

import urgame.ShapeDrawerFlambe;

class DifferSprite extends Sprite
{
	private var shapes : Array<Shape>;
	private var drawer : ShapeDrawerFlambe;

	public function new()
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

	override public function draw(g : Graphics)
	{
		if(drawer == null)
		{
			drawer = new ShapeDrawerFlambe(g);
		}

		for(shape in shapes)
		{
			drawer.drawShape(shape);
		}

	}
}