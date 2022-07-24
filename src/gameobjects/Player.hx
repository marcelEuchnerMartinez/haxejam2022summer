package gameobjects;

class Player extends GameObject {

    var ability_dash_cooldown : Float = 0;

    public function new( lvl ) {
        super( lvl );
        sprite = new h2d.Bitmap( h2d.Tile.fromColor(0xFF0000,16,32), this );
        hitbox = sprite.getBounds();

        level.add( this, level.LAYER_ENTITIES );
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

        if( hxd.Key.isDown(hxd.Key.RIGHT) || hxd.Key.isDown(hxd.Key.D) )
            this.x += speed;

        if( hxd.Key.isDown(hxd.Key.LEFT ) || hxd.Key.isDown(hxd.Key.A) )
            this.x -= speed;

        if( hxd.Key.isDown(hxd.Key.DOWN ) || hxd.Key.isDown(hxd.Key.S) )
            this.y += speed;

        if( hxd.Key.isDown(hxd.Key.UP   ) || hxd.Key.isDown(hxd.Key.W) )
            this.y -= speed;
    }
}