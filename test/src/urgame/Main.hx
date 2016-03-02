package urgame;

import flambe.System;
import flambe.Entity;
import flambe.Component;
import flambe.scene.Director;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;

class Main
{
    
    public static var director: Director;

    private static function main ()
    {
        // Wind up all platform-specific stuff
        System.init();

        director = new Director();
        System.root.add(director);

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

        var mainScene = MainScene.create();
        director.unwindToScene(mainScene);
    }
}
