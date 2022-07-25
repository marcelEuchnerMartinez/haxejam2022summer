package gameobjects;

class Player extends GameObject {

    var ability_dash_cooldown : Float = 0;

    public var adaptMovementToIsometricScreen = true;

    public function new( lvl ) {
        super( lvl );

        useDummySprite_bottomCenter( 0xFF0000,16,32 );
        
        hitbox = sprite.getBounds();

        level.add( this.spriteBase, level.LAYER_ENTITIES );

        level.cam_player.follow = this.spriteBase;

        level.player = this;
    }

    override function update() {
        var speed = 2;

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
    }

    /*function move_isoPos( dx:Float, dy:Float ) {
        var p = Isometric.world_to_IsometricScreen( x+dx, y+dy );
        x = p.x;
        y = p.y;
        trace( x, y );
    }*/
}