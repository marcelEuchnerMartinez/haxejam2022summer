package gameobjects;

class Ammunition extends GameObject {
    public function new(lvl) {
        super(lvl );

        level.add( this.spriteBase, level.LAYER_ENTITIES );

        useDummySprite_bottomCenter( 0x202020, 16, 12 );

        //hitbox = sprite.getBounds();

        level.items.push( this );
    }

    override function remove() {
        super.remove();
        level.items.remove( this );
    }

    public override function update() {
        super.update();
        if( level.player.hitbox.intersects( this.hitbox ) ){
            level.player.gun01_ammunition += 18;
            this.placeAtRandomPosition();
        }
    }
}