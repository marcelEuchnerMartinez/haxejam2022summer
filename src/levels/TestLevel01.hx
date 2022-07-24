package levels;

import hxd.res.DefaultFont;
import gameobjects.*;

class TestLevel01 extends Level {
    
    public function new() {
        super();

        var t = new h2d.Text( DefaultFont.get(), this );
        t.text = "TestLevel01\n\nUse arrow keys or WASD to move around";

        player = new Player( this );

        player.setPosition( this.width/2, this.height/2 );
    }

    public function update() {
        player.update();
    }
}