package levels;

import gameobjects.*;

import Isometric;

import hxd.Res;

class Level_Mall01 extends Level {
    
    public function new() {
        super();

        audio.playContinue( Audio.MusicState.THEME_INGAME );

        var t = new h2d.Text( UI.font() );
        this.add( t, LAYER_HUD );
        t.text = "Controls\nmove  - ARROW KEYS / W-A-S-D\ndash  - SPACE\nduck  - CTRL / SHIFT\nshoot - LEFT MOUSE";
        t.scale( 2 );
        t.setPosition( 0, this.height - t.getBounds().height );

        new Player( this );
        //player.setPosition( this.width/2, this.height/2 );

        // some grid by tilegroup tiles
        idea_grid02();

        //background_tilegroup.alpha = 0.2;

        hud_currentLevel_h2dText.text = '$this';

        for( i in 0...4 ){
            var en = new DummyEnemy(this);
            //en.movingDirection = hxd.Math.random( Math.PI *2 );
            var p1 = this.player;
            en.movingDirection = hxd.Math.atan2( p1.y - y, p1.x - x );
            en.placeAtRandomPosition();
        }

        for( i in 0...1 ){
            var o = new Ammunition(this);
            o.placeAtRandomPosition();
        }

        //idea_dummywalls();
    }

    override public function update() {
        super.update();
    }

    function idea_dummywalls() {
        for( i in 0...10 ){
            var w = new GameObject( this );
            w.x = hxd.Math.random(500);
            w.y = hxd.Math.random(500);

            var g = new h2d.Graphics();
            w.sprite = g;

            var p0_iso = new h2d.col.Point( w.x, w.y );
            var a = Math.random();
            var p1_iso = new h2d.col.Point( (a<0.5?p0_iso.x:p0_iso.x+hxd.Math.random(500)),(a>=0.5?p0_iso.y:p0_iso.y-hxd.Math.random(500)));
            var asLine = new h2d.col.Line( p0_iso, p1_iso );
            this.walls.push( {asLine:asLine} );
            
            g.beginFill( 0x505050 ); var c = 0.4;
            var p1_screen = Isometric.world_to_IsometricScreen( p1_iso.x-w.x, p1_iso.y-w.y );
            g.addVertex( 0, 0   , c, c, c, 1 );
            g.addVertex( 0, 0-48, c, c, c, 1 );
            g.addVertex( p1_screen.x, p1_screen.y-48, c, c, c, 1 );
            g.addVertex( p1_screen.x, p1_screen.y   , c, c, c, 1 );
            g.addVertex( 0, 0   , c, c, c, 1 );
            /*var p0_screen = Isometric.world_to_IsometricScreen_point(p0_iso);
            var p1_screen = Isometric.world_to_IsometricScreen_point(p1_iso);
            g.addVertex( p0_screen.x, p0_screen.y   , c, c, c, 1 );
            g.addVertex( p0_screen.x, p0_screen.y-48, c, c, c, 1 );
            g.addVertex( p1_screen.x, p1_screen.y-48, c, c, c, 1 );
            g.addVertex( p1_screen.x, p1_screen.y   , c, c, c, 1 );
            g.addVertex( p0_screen.x, p0_screen.y   , c, c, c, 1 ); // ??*/
            g.endFill();
            g.lineStyle( 1, 0xFFFFFF );
            g.drawCircle(0,0,2);

            var t = UI.text( w.spriteBase );
            t.text = w.toString_coordinates();
            
            //trace( p0_iso, p1_iso, p0_screen, p1_screen );
        }
    }

    function idea_grid02() {

        // tileset
        var k = 64/2;//32/2;
        
        level_width  = Math.floor(30 * k);
        level_height = Math.floor(30 * k);

        var indent = false; // (every second line must be indented...)
        for( y in 0...30 ){
            for( x in 0...30 ){

                // iso converting test
                var pos = Isometric.world_to_IsometricScreen( x *k, y *k );

                #if debug

                if( x==0 && y==0 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 0, 0 )";
                    t.setPosition( pos.x, pos.y ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==2 && y==1 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 2, 1 )";
                    t.setPosition( pos.x, pos.y ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==1 && y==2 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 1, 2 )";
                    t.setPosition( pos.x, pos.y ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==4 && y==5 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 4, 5 )";
                    t.setPosition( pos.x, pos.y ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==5 && y==4 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 5, 4 )";
                    t.setPosition( pos.x, pos.y ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                #end
                
                var tile = tileset_mallFloor01[0][0];
                background_tilegroup_mallFloor01.add( pos.x, pos.y-(k*1.5), tile ); // -(k + (k/2)) because the upper half of the tile is actually empty and also use the vertical center of the remaining tile
                //var tile = tilegroup_tile[1][0];
                //background_tilegroup.add( pos.x, pos.y, tile ); // 17 / 2 ... ?? (8.5)

                //trace(pos);
            }
        }
    }

    function idea_grid01() {

        // tileset
        var k = 32;
        var indent = false; // (every second line must be indented...)
        for( y in 0...90 ){
            for( x in 0...30 ){

                background_tilegroup_tilegrid.add( (x *k)+(indent?(k/2):0), y *(9/*17/2*/), tileset_tilegrid[1][0] ); // 17 / 2 ... ?? (8.5)

                //var random_index_x = Math.floor( Math.random() * 2 );
                //var random_index_y = 0; //Math.floor( Math.random() * 2 );
                //background_tilegroup.add( (x *k)+(indent?(k/2):0), y *(9/*17/2*/), tilegroup_tile[random_index_x][random_index_y] ); // 17 / 2 ... ?? (8.5)
                
            }
            indent = !indent;
        }
    }
}