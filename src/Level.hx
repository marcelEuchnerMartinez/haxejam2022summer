
import gameobjects.*;

import UI;

class Level extends h2d.Scene {

    public final LAYER_BACKGROUND = 0;
    public final LAYER_ENTITIES = 1;
    public final LAYER_WALLS = 2;
    public final LAYER_UI = 3;

    public var walls   : Array< { bounds:h2d.col.Bounds } > = [];
    
    public var background_tilegroup : h2d.TileGroup;
    public var tilegroup_tile : Array<Array<h2d.Tile>>;

    public var devInfo : h2d.Text;

    // contained GameObjects
    public var player : Player;
    //public var enemies : Array< Enemy > = [];

    public function new() {
        super();

        var tileset = hxd.Res.tileset.toTile();

        background_tilegroup = new h2d.TileGroup( tileset );
        this.add( background_tilegroup, LAYER_BACKGROUND );

        var k = 32;
        tilegroup_tile = tileset.grid( k );


        // dev helper stuff

        devInfo = UI.text();
        add( devInfo, LAYER_UI );

        /*var flow = new h2d.Flow(  );

        var b = UI.button_160x16();
        this.add( b, LAYER_UI );
        b.labelText("player camera");
        b.onClick = (e)->{
            this.camera.anchorX = 0.5;
            this.camera.anchorY = 0.5;
            this.camera.follow = player;
        };*/
    }

    public function update() {

        // dev info
        var info = "";
        var mx = Math.floor( this.mouseX *10 )/10;
        var my = Math.floor( this.mouseY *10 )/10;
        var wpos = Isometric.isometricScreen_to_world( mx, my );
        var wx  = Math.floor( wpos.x *10 )/10;
        var wy  = Math.floor( wpos.y *10 )/10;
        var wcx  = Math.floor( wpos.x *10 /16 )/10;
        var wcy  = Math.floor( wpos.y *10 /16 )/10;
        info  =   'M. screen : $mx, $my';
        info += '\nworld cell: $wcx, $wcy';
        devInfo.text = info;
        devInfo.setPosition( mx, my );

        // camera
        var cam = this.camera;

        // zoom in/out by mouse wheel
        if( hxd.Key.isPressed( hxd.Key.MOUSE_WHEEL_UP) ) // zoom in
            cam.scale( 1.1, 1.1 ); // just add 10%
        if( hxd.Key.isPressed( hxd.Key.MOUSE_WHEEL_DOWN) ) // zoom out
            cam.scale( 1-(1/11), 1-(1/11) ); // cannot pick 0.9 as we want to remove the 1/11 from before (and which is not 10%)

        // move camera
        var speed = 8;
        if( hxd.Key.isDown(hxd.Key.RIGHT) || hxd.Key.isDown(hxd.Key.D) )
            cam.x += speed;
        if( hxd.Key.isDown(hxd.Key.LEFT ) || hxd.Key.isDown(hxd.Key.A) )
            cam.x -= speed;
        if( hxd.Key.isDown(hxd.Key.DOWN ) || hxd.Key.isDown(hxd.Key.S) )
            cam.y += speed;
        if( hxd.Key.isDown(hxd.Key.UP   ) || hxd.Key.isDown(hxd.Key.W) )
            cam.y -= speed;
    }
}