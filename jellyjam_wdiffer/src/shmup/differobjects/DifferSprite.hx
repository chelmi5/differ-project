package shmup.differobjects;

import flambe.System;
import flambe.display.Sprite;
import flambe.display.Graphics;

import differ.ShapeDrawer;
import differ.shapes.Shape;

import shmup.differobjects.ShapeDrawerFlambe;

class DifferSprite extends Sprite
{
	public var shapes : Array<Shape>;
	private var shapeColors : Array<Int>;
	private var drawer : ShapeDrawerFlambe;

	public function new()
	{
		super();
		shapes = [];
		shapeColors = [];
	}

	public function addShape(shape : Shape, color : Int) : DifferSprite
	{
		shapes.push(shape);
		shapeColors.push(color);
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

		var i = 0;

		for(shape in shapes)
		{
			drawer.setCurrentColor(shapeColors[i]);
			drawer.drawShape(shape);
			i++;
		}

	}
}