package;

class IntroScene_Engine extends UpdatableScene {

    var engine_logo : h2d.Bitmap;

    public function new() {
        super();

        //trace("state is "+ Audio.music_state);
        //Audio.playContinue( Audio.MusicState.THEME_LAUNCH );

        var f = new h2d.Flow( this );
        f.verticalSpacing = 40;
        f.layout = h2d.Flow.FlowLayout.Vertical;
        f.horizontalAlign = h2d.Flow.FlowAlign.Middle;
        f.verticalAlign = h2d.Flow.FlowAlign.Middle;
        f.fillHeight = true; f.fillWidth = true;

        var bmp = new h2d.Bitmap( hxd.Res.heaps_logo.toTile(), f );
        bmp.scale( 0.25 );
        bmp.alpha = 0.5;
        engine_logo = bmp;
    }

    override function update() {
        super.update();
        if( hxd.Key.isPressed( hxd.Key.SPACE ) || hxd.Key.isPressed( hxd.Key.MOUSE_LEFT ) || hxd.Key.isPressed( hxd.Key.ESCAPE ) || hxd.Key.isPressed( hxd.Key.ENTER ) )
            Main.app.selectScene( new IntroScene_Names() );

        engine_logo.alpha = 0.5 - hxd.Math.random(0.5);
    }
}