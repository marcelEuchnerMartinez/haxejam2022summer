
import gameobjects.*;

import UI;

class Level extends UpdatableScene {

    // contained GameObjects
    public var player : Player;
    public var enemies : Array< DummyEnemy > = [];
    public var goals_pickup : Array< GameObject > = [];

    // 
    public final LAYER_BACKGROUND = 0;
    public final LAYER_ENTITIES = 1;
    public final LAYER_WALLS = 2;
    public final LAYER_INFO = 3;
    public final LAYER_HUD = 4;

    public var level_width  (default,never) : Int = 1000;
    public var level_height (default,never) : Int = 1000;

    public var walls   : Array< { asLine:h2d.col.Line } > = [];
    
    public var background_tilegroup : h2d.TileGroup;
    public var tilegroup_tile : Array<Array<h2d.Tile>>;

    public var devInfo : h2d.Text;

    public var cam_player : h2d.Camera;
    public var cam_HUD : h2d.Camera;
    public var cam_dev : h2d.Camera;
    public var devToolsPanel : h2d.Flow;
    public var hud_currentLevel_h2dText : h2d.Text;

    public var menuPanel : h2d.Flow;

    public var player_score : h2d.Text;

    public var smallUpdatables : Array<SmallUpdatableObject> = [];//Array<{obj:h2d.Object,f:()->{}}> = [];

    // specials
    var music = false;

    var player_health_bar : h2d.Graphics;

    //public var allSpritesToYSort : Array< h2d.Object >;

    public function new() {
        super();

        //var tileset = hxd.Res.tileset.toTile();
        var tileset = hxd.Res.Floor4_64.toTile();

        background_tilegroup = new h2d.TileGroup( tileset );
        this.add( background_tilegroup, LAYER_BACKGROUND );

        var k = 64;//32;
        tilegroup_tile = tileset.grid( k );

        var f = new h2d.Flow();
        this.add( f, LAYER_HUD );
        f.layout = h2d.Flow.FlowLayout.Vertical;
        menuPanel = f;
        var b = UI.button_160x40(f); b.labelText("Main menu");
        b.onClick = (e)->{ Main_Draft.app.selectScene( new MainMenu() );};
        f.setPosition( this.width - f.outerWidth, 0 );

        var t = UI.text();
        this.add( t, LAYER_HUD ); t.setPosition( width-150, 50 ); t.scale( 2 );
        player_score = t;

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
        hud_currentLevel_h2dText = new h2d.Text( UI.font(), dtp ); hud_currentLevel_h2dText.text = "<LEVELNAME>";
        var b = UI.button_160x16( dtp );
        b.labelText("play/pause theme");
        b.onClick = (e)->{
            //var snd = new hxd.res.Sound( hxd.Res.Prototype_Theme.entry );
            music = !music;
            //SoundGroup.mono
            if( !music ){
                //hxd.snd.Manager.get().masterSoundGroup.mono = true;
                audio.musicStopAll();
            }
                //snd.play(true);
            else {
                //audio.musicStopAll();
                //audio.theme_ingame.play( true );
                audio.playContinue( Audio.MusicState.THEME_INGAME );
            }
                //snd.stop();
        };
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



        music = false;

        #end

        //currentLevel_h2dText = new h2d.Text( UI.font(), this );

        player_health_bar = new h2d.Graphics();
        this.add( player_health_bar, LAYER_HUD );
    }

    override function update() {

        // game objects to update
        player.update();
        for( en in enemies )
            en.update();

        ysort_isometric( LAYER_ENTITIES );

        #if debug
        // dev info
        /*var info = "";
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
        devInfo.setPosition( this.mouseX, this.mouseY );*/

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

        // player health
        // health bar
        player_health_bar.clear();
        if( player!=null ){
            player_health_bar.lineStyle( 1, 0x0F21E4 );
            player_health_bar.beginFill( 0x0 );
            player_health_bar.drawRect( -300, 0, 600, 32 );
            player_health_bar.beginFill( 0xFF0000 );
            var health_in_percent = player.lifepoints / player.lifepoints_max;
            player_health_bar.drawRect( -300, 0, 600 * health_in_percent, 32 );
            player_health_bar.endFill();
            player_health_bar.setPosition( this.width/2, this.height-34 );
        }

        for( e in smallUpdatables )
            e.onUpdate();
    }

    public function cageInsideScene( o:GameObject ){
        var w = level_width;
        var h = level_height;
        if( o.x < 0 )
            o.x = 0;//this.width;
        if( o.y < 0 )
            o.y = 0;//this.height;
        if( o.x > w )//this.width )
            o.x = w;
        if( o.y > h )//this.height )
            o.y = h;
    }

    public function wrapInsideScene( o:GameObject ){
        var w = level_width;
        var h = level_height;
        if( o.x < 0 )
            o.x = w;//this.width;
        if( o.y < 0 )
            o.y = h;//this.height;
        if( o.x > w )//this.width )
            o.x = 0;
        if( o.y > h )//this.height )
            o.y = 0;
    }

    function turnWallIntoMathematicalFunction( p0_inner:h2d.col.Point, p1_inner:h2d.col.Point ) {
        Isometric.world_to_IsometricScreen_point( p0_inner );
        Isometric.world_to_IsometricScreen_point( p1_inner );
    }

    function ysort_isometric( layer : Int ) {
        //var all = enemies.copy().push(player);
		if( layer >= layerCount ) return;
		var start = layer == 0 ? 0 : layersIndexes[layer - 1];
		var max = layersIndexes[layer];
		if( start == max )
			return;
		var pos = start;
		var ymax = children[pos++].y + children[pos++].x;
		while( pos < max ) {
			var c = children[pos];
			if( c.y + c.x < ymax ) {
				var p = pos - 1;
				while( p >= start ) {
					var c2 = children[p];
					if( c.y + c.x >= c2.y + c2.x ) break;
					children[p + 1] = c2;
					p--;
				}
				children[p + 1] = c;
				if ( c.allocated )
					c.onHierarchyMoved(false);
			} else
				ymax = c.y + c.x;
			pos++;
		}
	}

    function ysort_isometric_001( layer : Int ) {
		if( layer >= layerCount ) return;
		var start = layer == 0 ? 0 : layersIndexes[layer - 1];
		var max = layersIndexes[layer];
		if( start == max )
			return;
		var pos = start;
		var ymax = children[pos++].y + children[pos++].x;
		while( pos < max ) {
			var c = children[pos];
			if( c.y + c.x < ymax ) {
				var p = pos - 1;
				while( p >= start ) {
					var c2 = children[p];
					if( c.y + c.x >= c2.y + c2.x ) break;
					children[p + 1] = c2;
					p--;
				}
				children[p + 1] = c;
				if ( c.allocated )
					c.onHierarchyMoved(false);
			} else
				ymax = c.y + c.x;
			pos++;
		}
	}
}