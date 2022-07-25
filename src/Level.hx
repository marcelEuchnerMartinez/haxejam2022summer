
import gameobjects.*;

import UI;

class Level extends h2d.Scene {

    public final LAYER_BACKGROUND = 0;
    public final LAYER_ENTITIES = 1;
    public final LAYER_WALLS = 2;
    public final LAYER_HUD = 3;

    public var walls   : Array< { bounds:h2d.col.Bounds } > = [];
    
    public var background_tilegroup : h2d.TileGroup;
    public var tilegroup_tile : Array<Array<h2d.Tile>>;

    public var devInfo : h2d.Text;

    // contained GameObjects
    public var player : Player;
    //public var enemies : Array< Enemy > = [];

    public var cam_player : h2d.Camera;
    public var cam_HUD : h2d.Camera;
    public var cam_dev : h2d.Camera;
    public var devToolsPanel : h2d.Flow;

    public function new() {
        super();

        var tileset = hxd.Res.tileset.toTile();

        background_tilegroup = new h2d.TileGroup( tileset );
        this.add( background_tilegroup, LAYER_BACKGROUND );

        var k = 32;
        tilegroup_tile = tileset.grid( k );    

        // camera setup

        // 1. default camera for world
        var cam = this.camera;
		cam.layerVisible = (L) -> (L != LAYER_HUD);
        cam.setScale( 2, 2 );
        cam.setAnchor( 0.5, 0.5 );
        //cam.follow = player; // done by Player class
        cam_player = cam;

        // 2. HUD camera
        cam_HUD = new h2d.Camera(this);
		cam_HUD.layerVisible = (L) -> (L == LAYER_HUD); // only show UI layer in this camera
        this.addCamera(cam_HUD);
        this.interactiveCamera = cam_HUD; // tells scene to use this camera for button interaction (h2d.Interactive)

        #if debug
        // 3. dev camera
        cam_dev = new h2d.Camera(this);
        cam_dev.layerVisible = (L) -> (L != LAYER_HUD);
        cam_dev.visible = false;

        // dev helper stuff
        devInfo = UI.text();
        add( devInfo, LAYER_HUD );
        var dtp = new h2d.Flow(); // devToolsPanel
        this.add( dtp, LAYER_HUD );
        dtp.layout = h2d.Flow.FlowLayout.Vertical;
        var b = UI.button_160x16( dtp );
        b.labelText("player camera");
        b.onClick = (e)->{
            //this.camera.visible = true;
            cam_player.visible = true;
            cam_dev.visible = false;
        };
        var b = UI.button_160x16( dtp );
        b.labelText("dev camera");
        b.onClick = (e)->{
            //this.camera.visible = false;
            cam_player.visible = false;
            cam_dev.visible = true;
        };
        dtp.setPosition( this.width - dtp.outerWidth, this.height - dtp.outerHeight );
        devToolsPanel = dtp;
        #end
    }

    public function update() {

        #if debug
        // dev info
        var info = "";
        var mp = new h2d.col.Point( this.mouseX, this.mouseY );
        cam_player.sceneToCamera( mp ); //or screenToCamera ?
        var mx = Math.floor( mp.x *10 )/10;
        var my = Math.floor( mp.y *10 )/10;
        var wpos = Isometric.isometricScreen_to_world( mx, my );
        //var wx  = Math.floor( wpos.x *10 )/10;
        //var wy  = Math.floor( wpos.y *10 )/10;
        var wcx  = Math.floor( wpos.x *10 /16 )/10;
        var wcy  = Math.floor( wpos.y *10 /16 )/10;
        info  =   'Iso.scr.M.: $mx, $my';
        info += '\nworld cell: $wcx, $wcy';
        devInfo.text = info;
        devInfo.setPosition( this.mouseX, this.mouseY );

        // camera
        var cam = (cam_player.visible?cam_player:cam_dev);
        // zoom in/out by mouse wheel
        if( hxd.Key.isPressed( hxd.Key.MOUSE_WHEEL_UP) ) // zoom in
            cam.scale( 1.1, 1.1 ); // just add 10%
        if( hxd.Key.isPressed( hxd.Key.MOUSE_WHEEL_DOWN) ) // zoom out
            cam.scale( 1-(1/11), 1-(1/11) ); // cannot pick 0.9 as we want to remove the 1/11 from before (and which is not 10%)
        // dev cam
        if(cam_dev.visible){
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
        #end
    }
}