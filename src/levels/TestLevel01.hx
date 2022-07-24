package levels;

import gameobjects.*;

import hxd.Res;
import hxd.res.DefaultFont;

class TestLevel01 extends Level {
    
    public function new() {
        super();

        var t = new h2d.Text( DefaultFont.get(), this );
        t.text = "TestLevel01\n\nUse arrow keys or WASD to move around";

        player = new Player( this );
        player.setPosition( this.width/2, this.height/2 );

        // some grid by tilegroup tiles
        idea_grid01();

        background_tilegroup.alpha = 0.2;
    }

    public function update() {
        player.update();
    }

    function idea_grid01() {

        // tileset
        var k = 32;
        var indent = false; // (every second line must be indented...)
        for( y in 0...90 ){
            for( x in 0...30 ){
                //var random_index_x = Math.floor( Math.random() * 4 );
                //var random_index_y = 1 + Math.floor( Math.random() * 4 );
                background_tilegroup.add( (x *k)+(indent?(k/2):0), y *(9/*17/2*/), tilegroup_tile[0][0] ); // 17 / 2 ... ?? (8.5)
            }
            indent = !indent;
        }
    }
}