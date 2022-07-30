package;

class Test_Audio extends hxd.App {
    static function main() {
        new Test_Audio();
        hxd.Res.initLocal();
        Audio.init();
    }

    public function new() {
        super();
    }

    override function init() {
        super.init();
        Audio.playContinue( Audio.MusicState.THEME_LAUNCH );
    }
}