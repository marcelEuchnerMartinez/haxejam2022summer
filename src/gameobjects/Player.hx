package gameobjects;

class Player extends GameObject {

    public function new( lvl ) {
        super( lvl );
        sprite = new h2d.Bitmap( h2d.Tile.fromColor(0xFF0000,16,32), this );
        hitbox = sprite.getBounds();

        level.add( this, level.LAYER_ENTITIES );
    }

    override function update() {
        var speed = 2;

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