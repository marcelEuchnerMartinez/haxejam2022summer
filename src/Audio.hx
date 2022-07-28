package;

class Audio {
    
    var theme_ingame = hxd.Res.Prototype_Theme_16bit;
    var theme_launch = hxd.Res.Eerie_One_Cut__80s;
    var theme_launch1 = hxd.Res.Eerie_One_Cut__80s;
    #if sys
    var theme_launch2 = hxd.Res.Eerie_One_Cut__bells;
    #end

    var music_state : MusicState;

    public function new() {}

    public function playContinue( music:MusicState ) {
        if( music_state!=music ){
            musicStopAll();
            switchMusicState(music);
            music_state=music;
        }
    }

    function switchMusicState( music:MusicState ) {
        switch(music){
            case THEME_INGAME:
                theme_ingame.play(true);
            case THEME_LAUNCH:
                theme_launch.play(true);
            default:
        }
    }

    public function musicStopAll() {
        theme_ingame.stop();
        theme_launch.stop();
        theme_launch1.stop();
        #if sys
        theme_launch2.stop();
        #end
    }
}

enum MusicState {
    THEME_INGAME;
    THEME_LAUNCH;
}