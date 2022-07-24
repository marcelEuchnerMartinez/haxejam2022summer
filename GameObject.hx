import h2d.Object;
import h2d.col.Bounds;

class GameObject extends h2d.Object {

    public var sprite (default,set) : h2d.Object;
    public var level  : Level;
    public var hitbox (get,default) : h2d.col.Bounds;

    public function new( level_ : Level ) {
        level = level_;
        super( level );
    }

    public function update() {}

    function get_hitbox() {
        hitbox.x = this.x;
        hitbox.y = this.y;
        return hitbox;
    }

    function set_sprite( obj : h2d.Object ){
        sprite = obj;
        sprite.parent = this;
        return sprite;
    }
}