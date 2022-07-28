package gameobjects;

class GoalPickup extends GameObject {

    public function new( lvl ) {
        super( lvl );

        useDummySprite_bottomCenter( 0x0E3D4A,16,12 );
        
        hitbox = sprite.getBounds();

        level.add( this.spriteBase, level.LAYER_ENTITIES );

        level.goals_pickup.push( this );
    }

    override function remove() {
        super.remove();
        level.goals_pickup.remove( this );
    }
}