package urgame;

import flambe.Entity;
import flambe.Component;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.Sprite;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.display.Graphics;

import differ.shapes.Circle;
import differ.shapes.Polygon;
import differ.shapes.Shape;
import differ.Collision;
import differ.ShapeDrawer;

import urgame.SDrawer;

class Main
{
    public static var shapes: Array<Shape>;

    private static function main ()
    {
        // Wind up all platform-specific stuff
        System.init();

        // Load up the compiled pack in the assets directory named "bootstrap"
        var manifest = Manifest.fromAssets("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack)
    {
        // Add a solid color background
        var background = new FillSprite(0x202020, System.stage.width, System.stage.height);
        System.root.addChild(new Entity().add(background));

        /*
        // Add a plane that moves along the screen
        var plane = new ImageSprite(pack.getTexture("plane"));
        plane.x._ = 30;
        plane.y.animateTo(200, 6);
        System.root.addChild(new Entity().add(plane));
        */

        var circle = new Circle( 300, 200, 50 );
        var box = Polygon.rectangle( 0, 0, 50, 150 );

        box.rotation = 45;

        var collideInfo = Collision.shapeWithShape( circle, box );

        var testDrawer = new SDrawer();

        if(collideInfo != null) {
            //use collideInfo.separationX
            //    collideInfo.separationY
            //    collideInfo.normalAxisX
            //    collideInfo.normalAxisY
            //    collideInfo.overlap
            trace("something is working???");
        }



    }
}
