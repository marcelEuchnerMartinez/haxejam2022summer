package;

import levels.*;

class Main_Draft extends hxd.App {

    public static var app : Main_Draft;

    public static var audio : Audio;

    static function main() {

        app = new Main_Draft();

        #if sys
        hxd.Res.initLocal();
        Sys.println("\n    Haxe Jam 2022 - summer\n\n    Game by Taxmann, Hakkerwell, Amusei123\n");
        #else
        //hxd.Res.initPak();
        hxd.Res.initEmbed();
        #end

    }

    var myscene : UpdatableScene;
    
    override function init() {

        audio = new Audio();
    
        #if debug
        selectScene( new IntroScene_Engine() );
        haxe.Timer.delay( ()->{ selectScene( new IntroScene_Names() ); }, 3*1000 );
        haxe.Timer.delay( ()->{ selectScene( new MainMenu() ); }, 7*1000 );
        #else
        
        #end
    
    }
    
    override function update(dt:Float) {
    
        if( myscene!=null )
            myscene.update();
    
    }

    public function selectLevel( ?lvl:Level ) {
        myscene = lvl;
        if( lvl==null )
            myscene = new TestLevel01();
        setScene( myscene );
    }

    public function selectScene( scene:UpdatableScene ) {
        myscene = scene;
        setScene( myscene );
    }
    
}