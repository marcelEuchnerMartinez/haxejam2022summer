package;

class Audio {

    public var isMuted = false;
    
    var theme_launch        = hxd.Res.music.Eerie_One_Cut__80s;
    var theme_ingame        = hxd.Res.music.Prototype_Theme_16bit;
    var theme_beginnerarea  = hxd.Res.music.Gameplay_Music_Loop;

    var theme_launch1       = hxd.Res.music.Eerie_One_Cut__80s;
    var theme_launch2       = hxd.Res.music.Eerie_One_Cut__bells;

    var music_state : MusicState;

    public function new() {}

    public function playContinue( music:MusicState ) {
        if( music_state!=music ){
            musicStopAll();
            switchMusicState(music);
        }
    }

    function switchMusicState( music:MusicState ) {
        music_state=music;
        if(!isMuted){
            switch(music_state){
                case THEME_INGAME:
                    theme_ingame.play(true);
                case THEME_LAUNCH:
                    theme_launch.play(true);
                case THEME_BEGINNERAREA:
                    theme_beginnerarea.play(true);
                default:
            }
        }
        trace('$music_state');
    }

    public function musicStopAll() {
        theme_ingame.stop();
        theme_beginnerarea.stop();
        theme_launch.stop();
        theme_launch1.stop();
        theme_launch2.stop();
    }
}

enum MusicState {
    THEME_INGAME;
    THEME_LAUNCH;
    THEME_BEGINNERAREA;
}