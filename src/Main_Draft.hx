package;

import levels.*;

class Main_Draft extends hxd.App {
    static function main() {
        new Main_Draft();
        //Res.initLocal();

        trace("hello");
    }

    var mylevel : TestLevel01;
    
    override function init() {
    
        mylevel = new TestLevel01();
    
        setScene( mylevel );
    
    }
    
    override function update(dt:Float) {
    
        mylevel.update();
    
    }
    
}