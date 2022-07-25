import h2d.Object;
import h2d.col.Bounds;

class GameObject extends h2d.Object {

    public var sprite (default,set) : h2d.Object;
    public var level  : Level;
    public var hitbox (get,default) : h2d.col.Bounds;
    //public var hitbox_onScreen (get,default) : h2d.col.Bounds;

    public function new( level_ : Level ) {
        level = level_;
        super(level);
    }

    public function update() {}

    function get_hitbox() {
        hitbox.x = this.x;
        hitbox.y = this.y;
        return hitbox;
    }

    function set_sprite( obj : h2d.Object ){
        if( sprite!=null )
            sprite.remove();
        sprite = obj;
        this.addChild( sprite ); // sprite.parent = this // doesn't seem to work
        return sprite;
    }

    //
    //          helper/convenience methods
    //

    public function useDummySprite_bottomCenter( color=0xFF00FF, width=32, height=32, alpha=1 ) {
        var tile = h2d.Tile.fromColor( color, width, height, alpha ); tile.setCenterRatio( 0.5, 1 );
        sprite = new h2d.Bitmap( tile );
    }
}