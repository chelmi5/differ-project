package urgame;

import flambe.Entity;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;

import differ.shapes.Circle;
import differ.shapes.Polygon;

import urgame.DifferSprite;

class Main
{
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
        //var background = new FillSprite(0x202020, System.stage.width, System.stage.height);
       // System.root.addChild(new Entity().add(background));

       	var circle = new Circle( 300, 200, 50 );
       	var box = Polygon.rectangle( 200, 200, 50, 150 );
       	var triangle = Polygon.triangle(100, 100, 30 );

        var testSprite = new DifferSprite();

        testSprite.addShape(circle);
        testSprite.addShape(box);
        testSprite.addShape(triangle);
        
        System.root.addChild(new Entity().add(testSprite));
    }
}
