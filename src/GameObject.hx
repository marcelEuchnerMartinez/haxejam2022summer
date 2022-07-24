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

    // doesn't really work properly
    function set_sprite( obj : h2d.Object ){
        //sprite = obj;
        //sprite.parent = this;
        //return sprite;
        if( sprite!=null )
            sprite.remove();
        sprite = obj;
        this.addChild( sprite );
        return sprite;
    }
}