package gameobjects;

class Player extends GameObject {

    public var gun01_ammunition (default,set) = 8;
    public var gun01_ammunition_loaded (default,set) = 8;
    public var gun01_ammunition_loadedMax = 8;

    public var isUntouchable = false;

    public var score (default,set) : Int = 0;

    public var isDucking : Bool = false;

    public var lifepoints     = 30;
    public var lifepoints_max = 30;

    var ability_dash_cooldown : Float = 0;

    public var adaptMovementToIsometricScreen = true;

    public var bullets : Array<h2d.Graphics> = [];

    public function new( lvl ) {
        super( lvl );

        dummysprite_default();
        
        //hitbox = sprite.getBounds();

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

        #if debug
        if( hxd.Key.isPressed(hxd.Key.NUMBER_1) )
            trace(hitbox);
        #end

        // normal movement
        if( !level.cam_dev.visible ){

            //var nx = x;
            //var ny = y;
            //var p = new h2d.col.Point( nx, ny );
            var p = new h2d.col.Point( x, y );

            var executeMove = false;

            //var _iso_angle = Math.PI*0.5/3;

            if( hxd.Key.isDown(hxd.Key.RIGHT) || hxd.Key.isDown(hxd.Key.D) )
                if(adaptMovementToIsometricScreen){
                    p.x += speed;
                    p.y += speed;
                    executeMove = true;
                }
                    //this.x += Math.cos( (Math.PI*0.0) + _iso_angle ) *speed;
                    //move_isoPos( speed, 0 );
                else
                    p.x += speed;

            if( hxd.Key.isDown(hxd.Key.LEFT ) || hxd.Key.isDown(hxd.Key.A) )
                if(adaptMovementToIsometricScreen){
                    p.x -= speed;
                    p.y -= speed;
                    executeMove = true;
                }
                    //this.x -= Math.cos( (Math.PI*1.0) + _iso_angle ) *speed;
                    //move_isoPos( -speed, 0 );
                else
                    p.x -= speed;

            if( hxd.Key.isDown(hxd.Key.DOWN ) || hxd.Key.isDown(hxd.Key.S) )
                if(adaptMovementToIsometricScreen){
                    p.x -= speed;
                    p.y += speed;
                    executeMove = true;
                }
                    //this.y += Math.sin( (Math.PI*1.5) + _iso_angle ) *speed;
                    //move_isoPos( 0, speed );
                else
                    p.y += speed;

            if( hxd.Key.isDown(hxd.Key.UP   ) || hxd.Key.isDown(hxd.Key.W) )
                if(adaptMovementToIsometricScreen){
                    p.x += speed;
                    p.y -= speed;
                    executeMove = true;
                }
                    //this.y -= Math.sin( (Math.PI*0.5) + _iso_angle ) *speed;
                    //move_isoPos( 0, -speed );
                else
                    p.y -= speed;

            // try movement
            if(executeMove){
                for( b in level.map_water ){
                    if( b.contains(p) ){
                        executeMove = false;
                        trace('player $p stopped by $b');
                    }
                }
            }

            if(executeMove){
                x = p.x;
                y = p.y;
                //trace("player moves");
            }
        }

        // cage player
        level.cageInsideScene( this );

        // player can shoot
        if( hxd.Key.isPressed(hxd.Key.MOUSE_LEFT) && isDucking==false && gun01_ammunition_loaded>0 ){
            var g = new h2d.Graphics();
            level.add( g, level.LAYER_ENTITIES );
            g.setPosition( spriteBase.x, spriteBase.y-24 );
            g.lineStyle(1,0xFFFFFF);
            g.beginFill( 0x0 );
            g.drawCircle( 0, 0, 2 );
            hxd.Res.sounds.shot_1.play(false,0.2);
            bullets.push( g );
            //g.rotation = Math.atan2( level.mouseY - g.y, level.mouseX - g.x );
            var mouse = new h2d.col.Point( level.mouseX, level.mouseY );
            level.cam_player.sceneToCamera( mouse );
            g.rotation = Math.atan2( mouse.y - spriteBase.y, mouse.x - spriteBase.x );

            gun01_ammunition_loaded-=1;
            //update_playerScoreText();
        }

        // reload
        if( hxd.Key.isPressed( hxd.Key.R ) ){
            var _cartridges_to_charge = gun01_ammunition_loadedMax - gun01_ammunition_loaded;
            for( i in 0..._cartridges_to_charge ){
                if( gun01_ammunition>0 ){
                    gun01_ammunition_loaded++;
                    gun01_ammunition--;
                    hxd.Res.sounds.select_low.play();
                }
            }
        }

        // move bullets
        //var bullet_as_point = new h2d.col.Point(0,0);
        for( b in bullets ){
            var s = 10;
            b.move( s, s );
            //var iso = Isometric.isometricScreen_to_world( b.x, b.y );
            //bullet_as_point.x = iso.x;
            //bullet_as_point.y = iso.y;
            for( en in level.enemies ){
                //if( en.hitbox.contains( bullet_as_point ) ){
                if( hxd.Math.distanceSq( en.spriteBase.x-b.x, en.spriteBase.y-16-b.y )<256 ){ // -16 will be center of the enemy's body
                    //en.remove();
                    //en.placeAtRandomPosition();
                    en.placeAtRandomPosition_noWater();
                    b.remove();
                    score ++;
                    //update_playerScoreText();
                    //bullets.remove( b ); // ?
                }
            }
        }

        // ducking
        if( hxd.Key.isPressed( hxd.Key.CTRL ) || hxd.Key.isPressed( hxd.Key.SHIFT ) ){
            //if(!isDucking)
            dummysprite_ducking();
            isDucking = true;
        }
        if( hxd.Key.isReleased( hxd.Key.CTRL ) || hxd.Key.isReleased( hxd.Key.SHIFT ) ){
            //if(isDucking)
            dummysprite_default();
            isDucking = false;
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
                    this.placeAtRandomPosition_noWater();
                    lifepoints = lifepoints_max;
                    t.remove();
                },
                3*1000
            );
        }
    }

    function update_playerScoreText() {
        level.player_score.text = 'score: $score\nmag. : $gun01_ammunition_loaded /$gun01_ammunition\n${level.next_level_scoreNeeded-score} to go!';

        if( this.gun01_ammunition_loaded==0 )
            level.player_score.text += "\nRELOAD\nWITH R!!";
        level.player_score.textColor = 0xFFFFFF;

        if( this.gun01_ammunition==0 ){
            level.player_score.text += "\nSEARCH FOR\nAMMO!!";
            level.player_score.textColor = 0xFF0000;
        }

        if( score >= level.next_level_scoreNeeded )
            level.next_level_button.visible = true;

        if( score == level.next_level_scoreNeeded ) {
            var t = UI.text(); t.scale(3); t.textColor = 0x00FF00;
            t.text = 'YOU DID IT!!!\nYOU\'RE A REAL SPY!';
                if( level.next_level_thisIsLastlevel ){
                    t.textColor = 0x3700FF;
                    t.text ='YOU BEAT THE GAME!!!\nYOU\'RE A SUPER SUMMER SPY!\nHAVE A GREAT SUMMER!!!! >:D';
                }
            level.add( t, level.LAYER_HUD );
            t.setPosition( (level.width/2) - (t.textWidth/2), level.height/2 );
            haxe.Timer.delay(
                ()->{
                    t.remove();
                },
                ( level.next_level_thisIsLastlevel? 10*1000 : 5*1000 )
            );
        }
    }

    function set_score( v ) {
        score = v;
        update_playerScoreText();
        return score;
    }

    function set_gun01_ammunition( v ) {
        gun01_ammunition = v;
        update_playerScoreText();
        return gun01_ammunition;
    }

    function set_gun01_ammunition_loaded( v ) {
        gun01_ammunition_loaded = v;
        update_playerScoreText();
        return gun01_ammunition_loaded;
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