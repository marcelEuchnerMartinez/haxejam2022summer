package levels;

import gameobjects.*;

import Isometric;

import hxd.Res;

class TestLevel01 extends Level {
    
    public function new() {
        super();

        var t = new h2d.Text( UI.font() );
        this.add( t, LAYER_HUD );
        t.text = "TestLevel01\n\nUse arrow keys or WASD to move around\nPress SPACE to dash forward";
        t.setPosition( 0, this.height - t.getBounds().height );

        player = new Player( this );
        player.setPosition( this.width/2, this.height/2 );

        // some grid by tilegroup tiles
        idea_grid02();

        background_tilegroup.alpha = 0.2;
    }

    override public function update() {
        super.update();
        player.update();
    }

    function idea_grid02() {

        // tileset
        var k = 32/2;
        var indent = false; // (every second line must be indented...)
        for( y in 0...30 ){
            for( x in 0...30 ){

                // iso converting test
                var pos = Isometric.world_to_IsometricScreen( x *k, y *k );

                if( x==0 && y==0 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 0, 0 )";
                    t.setPosition( pos.x, pos.y + k ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==2 && y==1 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 2, 1 )";
                    t.setPosition( pos.x, pos.y + k ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==1 && y==2 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 1, 2 )";
                    t.setPosition( pos.x, pos.y + k ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==4 && y==5 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 4, 5 )";
                    t.setPosition( pos.x, pos.y + k ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }

                if( x==5 && y==4 ){
                    var t = new h2d.Text( UI.font(), this );
                    t.text = "° ( 5, 4 )";
                    t.setPosition( pos.x, pos.y + k ); // add k to y, because tile is at the bottom
                    this.add( t, LAYER_ENTITIES );
                }
                
                var tile = tilegroup_tile[1][0];
                background_tilegroup.add( pos.x, pos.y, tile ); // 17 / 2 ... ?? (8.5)

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

                background_tilegroup.add( (x *k)+(indent?(k/2):0), y *(9/*17/2*/), tilegroup_tile[1][0] ); // 17 / 2 ... ?? (8.5)

                //var random_index_x = Math.floor( Math.random() * 2 );
                //var random_index_y = 0; //Math.floor( Math.random() * 2 );
                //background_tilegroup.add( (x *k)+(indent?(k/2):0), y *(9/*17/2*/), tilegroup_tile[random_index_x][random_index_y] ); // 17 / 2 ... ?? (8.5)
                
            }
            indent = !indent;
        }
    }
}