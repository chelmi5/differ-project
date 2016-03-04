package urgame;

import differ.math.Vector;

import flambe.Entity;
import flambe.Component;
import flambe.display.Graphics;
import flambe.display.FillSprite;

class DifferLineSprite extends Component
{
	public var line : FillSprite;
	public var distance : Float;
	public var entity : Entity;

	private var vStart : Vector;
	private var vEnd : Vector;
	private var thickness : Float;

	public function new(p0:Vector, p1:Vector, thick:Float)
	{
		trace("created new");
		this.vStart = p0;
		this.vEnd = p1;
		this.thickness = thick;

		this.distance = getDistance();
		this.line = new FillSprite(0xFFFFFF, this.distance, thickness);
		this.line.setAnchor(0, this.line.height._/2);
	}

	/* A^2 + B^2 = C^2 essentially. */
	public function getDistance():Float
	{
		var d:Float = Math.pow((vEnd.x - vStart.x), 2) + Math.pow((vEnd.y - vStart.y), 2);
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
	public function getAngle():Float
	{
		var x:Float = vEnd.x - vStart.x;
		var y:Float = vEnd.y - vStart.y;
		var angle:Float = Math.atan2(y, x); //returns the arctangent of the quotient of its arguments in radians
		angle = angle*(180 / Math.PI); //Convert radians to degrees
		return angle;
	}

	public function setStartingPoint(newPos0:Vector)
	{
		this.vStart = newPos0;		
		updateLine();
	}

	public function setEndingPoint(newPos1:Vector)
	{
		this.vEnd = newPos1;		
		updateLine();
	}

	public function newUpdate(p0:Vector, p1:Vector, thick:Float)
	{
		trace("reused");
		this.vStart = p0;
		this.vEnd = p1;
		this.thickness = thick;

		this.distance = getDistance();
		this.line = new FillSprite(0xFFFFFF, this.distance, thickness);
		this.line.setAnchor(0, this.line.height._/2);

		this.updateLine();
	}
	
	private function updateLine()
	{
		this.line.x._ = this.vStart.x;
		this.line.y._ = this.vStart.y;
		this.distance = getDistance();
		this.line.rotation._ = getAngle();
		this.line.width._ = this.distance;
	}
	
	override public function onAdded():Void
    {
		this.owner.addChild(new Entity().add(this.line));
		
		this.updateLine();
	}
	
	public function addToEntity():Entity
	{
		this.entity = new Entity();
		this.entity.add(this);
		return this.entity;
	}
}