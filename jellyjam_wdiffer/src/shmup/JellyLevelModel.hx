package shmup;

import flambe.Component;
import flambe.Entity;
import flambe.SpeedAdjuster;
import flambe.System;

import flambe.animation.Ease;
import flambe.animation.Jitter;

import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.display.PatternSprite;
import flambe.display.Sprite;

import flambe.math.FMath;

import flambe.script.AnimateTo;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Repeat;
import flambe.script.Script;
import flambe.script.Sequence;

import flambe.util.Value;

import differ.shapes.Circle;
import differ.Collision;

import shmup.ai.MoveStraight;
import shmup.ai.ChargeAtPlayer;

import shmup.differobjects.DifferSprite;

class JellyLevelModel extends Component
{
	public static inline var PLAYER_SPEED = 700;
    public static inline var ENEMY_SPEED = 500;
    //public static inline var COIN_SPEED = 700; randomized

	public var player (default, null) :Entity;

	public var score (default, null) :Value<Int>;

	private var _ctx :GameContext;

    private var _worldLayer :Entity;
    private var _coralLayer :Entity;
    private var _characterLayer :Entity;
    private var _coinLayer :Entity;
    private var _enemyLayer :Entity;

    private var _enemies :Array<Entity>;
    private var _friendlies :Array<Entity>;

    private var playerDSprite :DifferSprite;
    private var enemyDSprite :DifferSprite;
    private var coinDSprite :DifferSprite;

	public function new (ctx :GameContext)
	{
		_ctx = ctx;
		_enemies = [];
        _friendlies = [];
		score = new Value<Int>(0);

        playerDSprite = new DifferSprite();
        enemyDSprite = new DifferSprite();
        coinDSprite = new DifferSprite();
	}

	override public function onAdded ()
	{
        //_ctx.pack.getSound("sounds/LoopingMusic").loop();

		_worldLayer = new Entity();
		owner.addChild(_worldLayer);

		//add scrolling water background
		var background = new FillSprite(0x03A3B3, System.stage.width + 32, System.stage.height);
        _worldLayer.addChild(new Entity().add(background));

		//add everything to world layer
		_worldLayer.addChild(_coralLayer = new Entity());
        _worldLayer.addChild(_characterLayer = new Entity());
        _worldLayer.addChild(_coinLayer = new Entity());
        _worldLayer.addChild(_enemyLayer = new Entity());

        //Generate scrolling coral background
        scrollingCoral();

        //Generate coins
        generateCoins();

        //Generate enemies
        generateEnemies();

        // Create the player
        var jelly = new GameObject(_ctx, "playerjelly", 50, 3, 0);
        var jellyCircle = new Circle(System.stage.width/2, 0.8*System.stage.height, 50);//(0, 0, 50);//(System.stage.width/2, 0.8*System.stage.height, 50);
        playerDSprite.addShape(jellyCircle, 0x0000FF);
        
        jelly.destroyed.connect(function () {

            // Adjust the speed of the world for a dramatic slow motion effect
            var worldSpeed = new SpeedAdjuster(0.5);
            _worldLayer.add(worldSpeed);

            // Then show the game over prompt after a moment
            var gameoverscript = new Script();
            gameoverscript.run(new Sequence([
                new AnimateTo(worldSpeed.scale, 0, 1.5),
                new CallFunction(function () {
                    //_ctx.pack.getSound("sounds/LoopingMusic").dispose();
                    _ctx.showPrompt(_ctx.messages.get("game_over", [score._]), [
                        "Replay", function () {
                            _ctx.enterPlayingScene(false);
                        },
                        "Home", function () {
                            _ctx.director.popScene();
                            _ctx.enterHomeScene();
                        },
                    ]);
                }),
            ]));
            owner.add(gameoverscript);
        });

        player = new Entity().add(jelly);
        _characterLayer.addChild(player);
        //_friendlies = [player];

        // Start the player near the bottom of the screen
        player.get(Sprite).setXY(System.stage.width/2, 0.8*System.stage.height);

        System.root.addChild(new Entity().add(playerDSprite));

	}

    public function generateEnemies ()
    {
        var enemyScript = new Script();
        _enemyLayer.add(enemyScript);

        enemyScript.run(new Repeat(new Sequence([
            new Delay(1.0),
            new CallFunction(function () {
                var enemy = new Entity().add(new GameObject(_ctx, "badguy", 30, 2, 0));
                var enemyCircle;

                var rand = Math.random();

                //Random combinations of enemy movements, speeds, etc
                if (rand < 0.3) {

                    var left = Math.random() < 0.5;
                    var speed = Math.random()*100 + 150;
                    enemy
                        .add(new MoveStraight(_ctx, left ? -speed : speed, 0))
                        .add(new GameObject(_ctx, "badguy", 30, 1, 0));
                    var sprite = enemy.get(Sprite);

                    var randY = Math.random();

                    sprite.setXY(left ? System.stage.width : 0, randY*200+100);
                    enemyCircle = new Circle(left ? System.stage.width : 0, randY*200+100, 30);

                } else if (rand < 0.6) {
                    var x = Math.random();

                    enemy
                        .add(new ChargeAtPlayer(_ctx, 50, 150))
                        .add(new GameObject(_ctx, "badguy", 40, 2, 0));
                    var sprite = enemy.get(Sprite);
                    sprite.setXY(x*System.stage.width, -30);
                    enemyCircle = new Circle(x*System.stage.width, -30, 30);

                } else {
                    var x = Math.random();

                    enemy
                        .add(new MoveStraight(_ctx, Math.random()*100-50, 200))
                        .add(new GameObject(_ctx, "badguy", 50, 3, 0));
                    var sprite = enemy.get(Sprite);
                    sprite.setXY(x*System.stage.width, -30);
                    enemyCircle = new Circle(x *System.stage.width, -30, 30);
                }

                //enemy.differShape = enemyCircle;
                enemyDSprite.addShape(enemyCircle, 0x00FF00);

                var sprite = enemy.get(Sprite);
                enemy.get(GameObject).destroyed.connect(function () {
                    //explode(sprite.x._, sprite.y._);
                });

                _enemyLayer.addChild(enemy);
                _enemies.push(enemy);

            }),
        ])));

        System.root.addChild(new Entity().add(enemyDSprite));
    }

    public function scrollingCoral ()
    {
        var coralScript = new Script();
        _worldLayer.add(coralScript);

        //add scrolling coral bg
        coralScript.run(new Repeat(new Sequence([
            new Delay(1),
            new CallFunction(function () {
                var coral = new ImageSprite(_ctx.pack.getTexture("jelly/coraltwo"))
                    .centerAnchor().setAlpha(0.9);
                    
                coral.setXY(System.stage.width + coral.getNaturalWidth()/2, Math.random() * System.stage.height);
                coralScript.run(new Sequence([
                    new AnimateTo(coral.x, -coral.getNaturalWidth()/2, 10+8*Math.random()),
                    new CallFunction(coral.dispose),
                ]));
                _coralLayer.addChild(new Entity().add(coral));
            }),
        ])));
    }

    public function generateCoins ()
    {
        var coinScript = new Script();
        _coinLayer.add(coinScript);

        var coinCircle;

        // Repeatedly spawn more coins
        coinScript.run(new Repeat(new Sequence([
            new Delay(0.8),
            new CallFunction(function () {
                var coin = new Entity().add(new GameObject(_ctx, "coin", 50, 1, 10));

                var points = 0;
                var rand = Math.random(); //save to set point worth. if (rand < 0.3) etc

                    var left = Math.random() < 0.5; //whether coin will appear on left or right of screen
                    var y = Math.random();
                    var top = Math.random() < 0.5;
                    var speed = Math.random()*100 + 150;
                    coin
                        .add(new MoveStraight(_ctx, left ? -speed : speed, 0))
                        .add(new GameObject(_ctx, "coin", 30, 1, 10));
                    var sprite = coin.get(Sprite);
                    sprite.setXY(left ? System.stage.width : 0, y*System.stage.height);
                    points = 10;

                    coinCircle = new Circle(left ? System.stage.width : 0, y*System.stage.height, 16);
                    //coinCircle.add(new MoveStraight(_ctx, left ? -speed : speed, 0));
                

                var sprite = coin.get(Sprite);
                coin.get(GameObject).destroyed.connect(function () {
                    score._ += points;
                });

                _characterLayer.addChild(coin);
                _friendlies.push(coin);

                coinDSprite.addShape(coinCircle, 0xFFFF00);

                //System.root.addChild(new Entity().add(coin.differShape));
            }),
        ])));

        System.root.addChild(new Entity().add(coinDSprite));

        
    }

	override public function onUpdate (dt :Float)
    {
        var pointerX = System.pointer.x;
        var pointerY = System.pointer.y;

        

        // Move towards the pointer position at a fixed speed
        var sprite = player.get(Sprite);
        if (sprite != null) {
            var dx = pointerX - sprite.x._;
            var dy = pointerY - sprite.y._;
            var distance = Math.sqrt(dx*dx + dy*dy);

            var travel = PLAYER_SPEED * dt;
            if (travel < distance) {
                sprite.x._ += travel * dx/distance;
                sprite.y._ += travel * dy/distance;
            } else {
                sprite.x._ = pointerX;
                sprite.y._ = pointerY;
            }

            playerDSprite.shapes[0].x = sprite.x._;
            playerDSprite.shapes[0].y = sprite.y._;
        }

        testDifferCollision();

        //Remove offscreen coins
        var ii = 0;
        while (ii < _friendlies.length) {
            var coin = _friendlies[ii];
            var sprite = coin.get(Sprite);
            var radius = coin.get(GameObject).radius;

            coinDSprite.shapes[ii].x = sprite.x._;
            coinDSprite.shapes[ii].y = sprite.y._;

            //the +/- 10 is a buffer so that they don't get disposed while being generated
            if (sprite.x._ < -radius-10 || sprite.x._ > System.stage.width+radius+10 ||
                sprite.y._ < -radius-10 || sprite.y._ > System.stage.height+radius+10) {

                _friendlies.splice(ii, 1);
                coin.dispose();

                coinDSprite.removeShape(coinDSprite.shapes[ii]);

            } else {
                ++ii;
            }


        }

        // Remove offscreen enemies
        var ii = 0;
        while (ii < _enemies.length) {
            var enemy = _enemies[ii];
            var sprite = enemy.get(Sprite);
            var radius = enemy.get(GameObject).radius;

            enemyDSprite.shapes[ii].x = sprite.x._;
            enemyDSprite.shapes[ii].y = sprite.y._;

            if (sprite.x._ < -radius-10 || sprite.x._ > System.stage.width+radius+10 ||
                sprite.y._ < -radius-10 || sprite.y._ > System.stage.height+radius+10) {

                _enemies.splice(ii, 1);
                enemy.dispose();

                enemyDSprite.removeShape(enemyDSprite.shapes[ii]);
            } else {
                ++ii;
            }
        }
    }

    public function testDifferCollision():Void
    {
        var coinCollisions = Collision.shapeWithShapes(playerDSprite.shapes[0], coinDSprite.shapes);

        if(coinCollisions != null)
        {
            var i = 0;
            while(i < coinCollisions.length)
            {
                trace("Differ: collision detected between player and coin ");
                trace("overlap: " + coinCollisions[i].overlap);

                i++;
            }
        }

        var enemyCollisions = Collision.shapeWithShapes(playerDSprite.shapes[0], enemyDSprite.shapes);
        if(enemyCollisions != null)
        {
            var i = 0;
            while(i < enemyCollisions.length)
            {

                trace("Differ: collision detected between player and enemy ");
                trace("overlap: " + enemyCollisions[i].overlap);

                i++;
            }
        }
    }

    public function coinCollision():Void
    {
        var i = 0;
        
        while (i < _friendlies.length)
        {
            var a = _friendlies[i];
            var aS = a.get(Sprite);
            var b = player;
            var bS = player.get(Sprite);

            var maxDist = a.get(GameObject).radius + b.get(GameObject).radius;

            // classic distance formula
            var distSqr = (aS.x._ - bS.x._)*(aS.x._ - bS.x._) + (aS.y._ - bS.y._)*(aS.y._ - bS.y._);
            if( distSqr<=maxDist*maxDist )
            {
                aS.scaleX.animate(0.25, 1, 0.5, Ease.backOut);
                aS.scaleY.animate(0.25, 1, 0.5, Ease.backOut);

                trace("coin - player collision");
                score._ += Std.int(a.get(GameObject).points);
                _ctx.pack.getSound("sounds/Coin").play();

                _friendlies.splice(i, 1);
                a.dispose();
            }

            i++;
        }
        
    }

    public function enemyCollision() :Void
    {
        var i = 0;
        
        while (i < _enemies.length)
        {
            var a = _enemies[i];
            var aS = a.get(Sprite);
            var b = player;
            var bS = player.get(Sprite);

            var maxDist = a.get(GameObject).radius + b.get(GameObject).radius;

            // classic distance formula
            var distSqr = (aS.x._ - bS.x._)*(aS.x._ - bS.x._) + (aS.y._ - bS.y._)*(aS.y._ - bS.y._);
            if( distSqr<=maxDist*maxDist )
            {
                aS.scaleX.animate(0.25, 1, 0.5, Ease.backOut);
                aS.scaleY.animate(0.25, 1, 0.5, Ease.backOut);
                trace("enemy - player collision");

                _enemies.splice(i, 1);
                a.dispose();

                bS.scaleX.animate(0.25, 1, 0.5, Ease.backOut);
                bS.scaleY.animate(0.25, 1, 0.5, Ease.backOut);

                if(player.get(GameObject).damage(1))
                {
                    player.get(GameObject).destroyed.emit();
                    break;
                }
            }

            i++;
        }
    }
}