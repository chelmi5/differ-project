//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package shmup;

import flambe.Entity;
import flambe.System;
import flambe.animation.Ease;
import flambe.animation.Sine;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.util.Promise;
import flambe.script.Repeat;
import flambe.script.Script;
import flambe.script.Sequence;
import flambe.script.CallFunction;
import flambe.script.AnimateTo;
import flambe.script.Delay;

class HomeScene
{
    /** Creates the main menu scene. */
    public static function create (ctx :GameContext) :Entity
    {
        var scene = new Entity();

        var background = new FillSprite(0x03A3B3, System.stage.width, System.stage.height);
        scene.addChild(new Entity().add(background));

        //Loading images for title screen... var names are pretty self-exaplanatory
        var title = new ImageSprite(ctx.pack.getTexture("jelly/title"));
        title.x._ = System.stage.width/18;
        title.y._ = System.stage.height/15;
        scene.addChild(new Entity().add(title));

        var info = new ImageSprite(ctx.pack.getTexture("jelly/info"));
        info.x._ = System.stage.width/3.5;
        info.y._ = System.stage.height/2.7;

        var titlejelly = new ImageSprite(ctx.pack.getTexture("jelly/titlejelly"));
        titlejelly.x._ = System.stage.width/11;
        titlejelly.y._ = System.stage.height/2.4;

        scene.addChild(new Entity().add(titlejelly));

        titlejelly.y.behavior = new Sine(System.stage.height/2.7, System.stage.height/2.1);   

        var playbutton = new ImageSprite(ctx.pack.getTexture("jelly/playbutton"));
        playbutton.centerAnchor().setXY(System.stage.width/1.35, System.stage.height/1.3);
        playbutton.scaleX.animate(0.25, 1, 0.5, Ease.backOut);
        playbutton.scaleY.animate(0.25, 1, 0.5, Ease.backOut);

        //if pressed, plays noise and starts level
        playbutton.pointerDown.connect(function (_) {
            //ctx.pack.getSound("sounds/Coin").play();
            playbutton.scaleX.animate(0.5, 1, 0.5, Ease.backOut);
            playbutton.scaleY.animate(0.5, 1, 0.5, Ease.backOut);
            ctx.enterPlayingScene();
        });
        scene.addChild(new Entity().add(playbutton));

        return scene;
    }
}
