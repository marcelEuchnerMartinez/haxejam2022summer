package;

class IntroScene_Names extends UpdatableScene {
    public function new() {
        super();
        //var t = UI.text( this );
        //t.text = "Intro scene";

        var f = new h2d.Flow( this );
        f.verticalSpacing = 40;
        f.layout = h2d.Flow.FlowLayout.Vertical;
        f.horizontalAlign = h2d.Flow.FlowAlign.Middle;
        f.verticalAlign = h2d.Flow.FlowAlign.Middle;
        f.fillHeight = true; f.fillWidth = true;

        //var t = UI.text( f );
        //t.setPosition( 200,  50 );
        //t.text = "Game by";
        //t.scale( 2 ); t.textColor = 0x093A3A;

        var ppl = ["art\n     Hakkerwell","music\n     Taxmann","code\n     Amusei123"]; hxd.Math.shuffle( ppl );
        //var yy = 100;
        var i = 0;
        for( p in ppl ){
            var t = UI.text( f );
            //t.setPosition( 200,  yy ); yy+=75;
            t.text = p;
            t.scale( 3 ); t.textColor = 0x0;// 0x3F0357;
            haxe.Timer.delay( ()->{ t.x+=50; t.textColor = 0x3F0357; }, (i+2)*500 );
            i++;
        }

        //var t = UI.text( f );
        //t.setPosition( 200, 600 );
        //t.text = "\n\n\nCreated with the Heaps game engine.\nSee more on\nhttps://heaps.io";
        //t.scale( 2 ); t.textColor = 0xE69A16;

        /*var t = new haxe.Timer( 3 * 1000 );
        t.run = () -> {
            Main_Draft.app.setScene( new MainMenu() );
            t.stop();
        };*/
    }

    override function update() {
        super.update();
        if( hxd.Key.isPressed( hxd.Key.SPACE ) || hxd.Key.isPressed( hxd.Key.MOUSE_LEFT ) || hxd.Key.isPressed( hxd.Key.ESCAPE ) || hxd.Key.isPressed( hxd.Key.ENTER ) )
            Main_Draft.app.selectScene( new MainMenu() );
    }
}