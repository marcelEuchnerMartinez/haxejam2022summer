import h2d.Object;
import h2d.col.Bounds;

class GameObject {

    public var spriteBase (get,null) : h2d.Object;
    public var sprite (default,set) : h2d.Object;
    public var level  : Level;
    //public var hitbox_onScreen (get,default) : h2d.col.Bounds;

    public var x (default,set) : Float = 0;
    public var y (default,set) : Float = 0;
    public var hitbox (get,default) : h2d.col.Bounds;

    public function new( level_ : Level, layer:Int=-1 ) {
        level = level_;
        spriteBase = new h2d.Object();
        if( layer==-1 )
            layer=level.LAYER_ENTITIES;
        level.add( this.spriteBase, layer );
    }

    public function update() {}

    public function remove() {
        spriteBase.remove();
    }

    // methods required by fields

    function set_x( _x ){
        x = _x;
        spriteBase.x = Isometric.world_to_IsometricScreen( x, y ).x;
        return x;
    }

    function set_y( _y ){
        y = _y;
        spriteBase.y = Isometric.world_to_IsometricScreen( x, y ).y;
        return y;
    }

    function get_spriteBase() {
        var p = Isometric.world_to_IsometricScreen( x, y );
        spriteBase.setPosition( p.x, p.y );
        return spriteBase;
    }

    function get_hitbox() {
        hitbox.x = this.x;
        hitbox.y = this.y;
        return hitbox;
    }

    function set_sprite( obj : h2d.Object ){
        if( sprite!=null )
            sprite.remove();
        sprite = obj;
        spriteBase.addChild( sprite ); // sprite.parent = this // doesn't seem to work
        return sprite;
    }

    //          idk

    public function asPoint( ?o:GameObject ) {
        if( o==null )
            o=this;
        return new h2d.col.Point( o.x, o.y );
    }

    public function canSeeThrough( p0:h2d.col.Point, ?p1:h2d.col.Point ) {
        //var p = new h2d.col.Point(0,0);
        //var p = new h2d.col.Point(0,0);
        if( p1==null )
            p1 = this.asPoint();
        var l = new h2d.col.Line( p0, p1 );
        for( w in level.walls )
            if( l.intersectWith( w.asLine, p0 ) )
                return false;
        return true;
    }

    public function distanceSq( o:GameObject, ?o2:GameObject ){
        if( o2==null )
            o2 = this;
        return hxd.Math.distanceSq( o.x - o2.x, o.y - o2.y);
    }

    //
    //          helper/convenience methods
    //

    public function placeAtRandomPosition( board_size:Int=1000 ) {
        x = hxd.Math.random(board_size);
        y = hxd.Math.random(board_size);
    }

    public function toString_coordinates() {
        return '${Math.round(this.x*10)/10}|${Math.round(this.y*10)/10}';
    }

    public function useDummySprite_bottomCenter( color=0xFF00FF, width=32, height=32, alpha=1 ) {
        var tile = h2d.Tile.fromColor( color, width, height, alpha ); tile.setCenterRatio( 0.5, 1 );
        sprite = new h2d.Bitmap( tile );
    }
}