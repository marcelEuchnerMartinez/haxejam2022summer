package levels;

import gameobjects.*;

import Isometric;

import hxd.Res;

class Level_Asia01 extends Level {
    
    public function new() {
        super();

        Audio.playContinue( Audio.MusicState.THEME_BEGINNERAREA );

        var t = new h2d.Text( UI.font() );
        this.add( t, LAYER_HUD );
        //t.text = "ASIA 01";
        t.text = "Controls\nmove   - ARROW KEYS / W-A-S-D\ndash   - SPACE\nduck   - CTRL / SHIFT\nshoot  - LEFT MOUSE\nreload - R";
        t.scale( 2 );
        t.setPosition( 0, this.height - t.getBounds().height );

        this.next_level = Level_01;
        this.next_level_scoreNeeded = 10;

        new Player( this );
        //player.setPosition( this.width/2, this.height/2 );

        // some grid by tilegroup tiles
        idea_grid02();

        //background_tilegroup.alpha = 0.2;

        hud_currentLevel_h2dText.text = '$this';

        for( i in 0...5 ){
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

        for( i in 0...50 ){
            var bmp = new h2d.Bitmap( hxd.Res.WallConcreteFront.toTile() );
            this.add( bmp, LAYER_ENTITIES );
            bmp.x = 0 + (i*(170/2));//100 + (i*98);
            bmp.y = 0;//100;
            var p = Isometric.world_to_IsometricScreen( bmp.x, bmp.y );
            bmp.setPosition( p.x, p.y );
            bmp.y -= hxd.Res.WallConcreteFront.getSize().height;
        }

        //idea_dummywalls();
    }

    override public function update() {
        super.update();
    }

    function idea_grid02() {

        // tileset
        var k = 170/2;//32/2;
        
        level_width  = Math.floor(30 * k);
        level_height = Math.floor(30 * k);

        var indent = false; // (every second line must be indented...)
        for( y in 0...40 ){
            for( x in 0...40 ){

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
                
                var tile = tileset_asiaFloor01[0][0];
                background_tilegroup_asiaFloor01.add( pos.x, pos.y-(k*1.5), tile ); // -(k + (k/2)) because the upper half of the tile is actually empty and also use the vertical center of the remaining tile
                //var tile = tilegroup_tile[1][0];
                //background_tilegroup.add( pos.x, pos.y, tile ); // 17 / 2 ... ?? (8.5)

                //trace(pos);
            }
        }
    }
}