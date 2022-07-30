package;

import levels.*;

class Main extends hxd.App {

    public static var app : Main;

    static function main() {

        app = new Main();

        #if sys
        Sys.println("\n    Haxe Jam 2022 - summer\n\n    Game by Taxmann, Hakkerwell, Amusei123\n");
        #end

        #if usepak
        hxd.Res.initPak();
        #else
        hxd.Res.initLocal();
        #end

        //hxd.Res.initEmbed();

        Audio.init();
    }

    var myscene : UpdatableScene;
    
    //@:privateAccess haxe.MainLoop.add(() -> {});
    override function init() {
        @:privateAccess haxe.MainLoop.add(() -> {});

        Audio.playContinue( Audio.MusicState.THEME_LAUNCH );

        
        #if music_off
        Audio.isMuted = true;
        if(Audio.isMuted)trace("MUSIC IS MUTED (!)");
        #end
    
        #if dev
        //selectLevel();
        selectLevel( new Level_01() );
        #else
        selectScene( new IntroScene_Engine() );
        haxe.Timer.delay( ()->{ if(Std.isOfType(s2d,IntroScene_Engine)) selectScene( new IntroScene_Names() ); }, 3*1000 );
        haxe.Timer.delay( ()->{ if(Std.isOfType(s2d,IntroScene_Names )) selectScene( new MainMenu() ); }, 7*1000 );
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

    /*#if usepak
    override function loadAssets(done) {
        new hxd.fmt.pak.Loader(s2d, done);
    }
    #end*/
    
}