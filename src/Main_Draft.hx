package;

import levels.*;

class Main_Draft extends hxd.App {
    static function main() {
        new Main_Draft();
        hxd.Res.initLocal();
        #if sys
        Sys.println("\n    Haxe Jam 2022 - summer\n\n    Game by Taxmann, Hakkerwell, Amusei123\n");
        #end
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