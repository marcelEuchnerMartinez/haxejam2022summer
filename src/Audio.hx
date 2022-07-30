package;

import hxd.res.Sound;

class Audio {

    public static var isMuted (default,set) = false;
    
    static var theme_launch        : Sound;// hxd.Res.music.Eerie_One_Cut__80s;
    static var theme_ingame        : Sound;//= hxd.Res.music.Prototype_Theme_16bit;
    static var theme_beginnerarea  : Sound;//= hxd.Res.music.Gameplay_Music_Loop;

    static var theme_launch1       : Sound;//= hxd.Res.music.Eerie_One_Cut__80s;
    static var theme_launch2       : Sound;//= hxd.Res.music.Eerie_One_Cut__bells;

    public static var music_state : MusicState;

    //public function new() {}

    public static function init() {
        theme_launch        = hxd.Res.music.Eerie_One_Cut__80s;
        theme_ingame        = hxd.Res.music.Prototype_Theme_16bit;
        theme_beginnerarea  = hxd.Res.music.Gameplay_Music_Loop;
        theme_launch1       = hxd.Res.music.Eerie_One_Cut__80s;
        theme_launch2       = hxd.Res.music.Eerie_One_Cut__bells;
    }

    static function set_isMuted( bool ) {
        isMuted = bool;
        if( Audio.isMuted )
            musicStopAll();
        else
            restartLastMusicState();
        return isMuted;
    }

    public static function switchMuted() {
        trace('AUDIO MUTED: $isMuted');
        Audio.isMuted = !Audio.isMuted;
        if( Audio.isMuted )
            musicStopAll();
        else
            restartLastMusicState();
    }

    public static function restartLastMusicState() {
        switchMusicState( music_state );
    }

    public static function playContinue( music:MusicState ) {
        if( music_state!=music ){
            musicStopAll();
            switchMusicState(music);
        }
    }

    static function switchMusicState( music:MusicState ) {
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

    public static function musicStopAll() {
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