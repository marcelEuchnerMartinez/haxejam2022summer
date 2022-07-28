package gameobjects;

class Player extends GameObject {

    public var isUntouchable = false;

    public var score : Int = 0;

    public var isDucking : Bool = false;

    public var lifepoints     = 30;
    public var lifepoints_max = 30;

    var ability_dash_cooldown : Float = 0;

    public var adaptMovementToIsometricScreen = true;

    public var bullets : Array<h2d.Graphics> = [];

    public function new( lvl ) {
        super( lvl );

        dummysprite_default();
        
        hitbox = sprite.getBounds();

        level.add( this.spriteBase, level.LAYER_ENTITIES );

        level.cam_player.follow = this.spriteBase;

        level.player = this;
    }

    override function update() {
        var speed : Float = 2;

        if( isDucking )
            speed = 0.5;

        // dash ability

        if( ability_dash_cooldown > 0 )
            ability_dash_cooldown -= 0.01;
        else
            ability_dash_cooldown = 0;

        if( hxd.Key.isDown(hxd.Key.SPACE ) && ability_dash_cooldown==0 ){
            speed = speed * 10;
            ability_dash_cooldown = 1;
        }

        // normal movement
        if( !level.cam_dev.visible ){

            //var _iso_angle = Math.PI*0.5/3;

            if( hxd.Key.isDown(hxd.Key.RIGHT) || hxd.Key.isDown(hxd.Key.D) )
                if(adaptMovementToIsometricScreen){
                    this.x += speed;
                    this.y += speed;
                }
                    //this.x += Math.cos( (Math.PI*0.0) + _iso_angle ) *speed;
                    //move_isoPos( speed, 0 );
                else
                    this.x += speed;

            if( hxd.Key.isDown(hxd.Key.LEFT ) || hxd.Key.isDown(hxd.Key.A) )
                if(adaptMovementToIsometricScreen){
                    this.x -= speed;
                    this.y -= speed;
                }
                    //this.x -= Math.cos( (Math.PI*1.0) + _iso_angle ) *speed;
                    //move_isoPos( -speed, 0 );
                else
                    this.x -= speed;

            if( hxd.Key.isDown(hxd.Key.DOWN ) || hxd.Key.isDown(hxd.Key.S) )
                if(adaptMovementToIsometricScreen){
                    this.x -= speed;
                    this.y += speed;
                }
                    //this.y += Math.sin( (Math.PI*1.5) + _iso_angle ) *speed;
                    //move_isoPos( 0, speed );
                else
                    this.y += speed;

            if( hxd.Key.isDown(hxd.Key.UP   ) || hxd.Key.isDown(hxd.Key.W) )
                if(adaptMovementToIsometricScreen){
                    this.x += speed;
                    this.y -= speed;
                }
                    //this.y -= Math.sin( (Math.PI*0.5) + _iso_angle ) *speed;
                    //move_isoPos( 0, -speed );
                else
                    this.y -= speed;
        }

        // cage player
        level.cageInsideScene( this );

        // player can shoot
        if( hxd.Key.isPressed(hxd.Key.MOUSE_LEFT) && isDucking==false ){
            var g = new h2d.Graphics();
            level.add( g, level.LAYER_ENTITIES );
            g.setPosition( spriteBase.x, spriteBase.y-24 );
            g.beginFill( 0x0 );
            g.drawCircle( 0, 0, 4 );
            hxd.Res.shot_1.play(false,0.2);
            bullets.push( g );
            //g.rotation = Math.atan2( level.mouseY - g.y, level.mouseX - g.x );
            var mouse = new h2d.col.Point( level.mouseX, level.mouseY );
            level.cam_player.sceneToCamera( mouse );
            g.rotation = Math.atan2( mouse.y - spriteBase.y, mouse.x - spriteBase.x );
        }

        // move bullets
        for( b in bullets ){
            var s = 10;
            b.move( s, s );
            for( en in level.enemies ){
                if( hxd.Math.distanceSq( en.spriteBase.x-b.x, en.spriteBase.y-16-b.y )<256 ){ // -16 will be center of the enemy's body
                    //en.remove();
                    en.placeAtRandomPosition();
                    b.remove();
                    score ++;
                    level.player_score.text = 'score: $score';
                    //bullets.remove( b ); // ?
                }
            }
        }

        // ducking
        if( hxd.Key.isPressed( hxd.Key.CTRL ) || hxd.Key.isDown( hxd.Key.SHIFT ) ){
            isDucking = true;
            dummysprite_ducking();
        }
        if( hxd.Key.isReleased( hxd.Key.CTRL ) || hxd.Key.isReleased( hxd.Key.SHIFT ) ){
            isDucking = false;
            dummysprite_default();
        }

        // game over
        if( lifepoints<=0 && !isUntouchable ){
            lifepoints = 0;
            isUntouchable = true;
            var t = UI.text(); t.scale(3); t.text = 'GAME OVER\nscore: $score';
            level.add( t, level.LAYER_HUD );
            t.setPosition( (level.width/2) - (t.textWidth/2), level.height/2 );
            score = 0;
            haxe.Timer.delay(
                ()->{
                    score = 0;
                    isUntouchable = false;
                    this.placeAtRandomPosition();
                    lifepoints = lifepoints_max;
                    t.remove();
                },
                3*1000
            );
        }
    }

    function dummysprite_default() {
        useDummySprite_bottomCenter( 0xFF0000,16,32 );
    }

    function dummysprite_ducking() {
        useDummySprite_bottomCenter( 0x770303,16,20 );
    }

    /*function move_isoPos( dx:Float, dy:Float ) {
        var p = Isometric.world_to_IsometricScreen( x+dx, y+dy );
        x = p.x;
        y = p.y;
        trace( x, y );
    }*/
}