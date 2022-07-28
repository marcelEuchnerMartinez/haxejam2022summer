package;

import h2d.Object;

class MainMenu extends UpdatableScene {

    var button_play : h2d.Interactive;
    var button_play_isShivering : Bool = false;
    var button_play_startX : Float = 0;
    var button_play_startY : Float = 0;

    var mainmenu_title_flow : h2d.Flow;

    public function new() {
        super();

        /*var audio = Main_Draft.audio;
        audio.musicStopAll();
        audio.theme_launch.play(true);*/
        
        var f = new h2d.Flow( this ); f.verticalSpacing = 8; f.layout = h2d.Flow.FlowLayout.Vertical;
        f.horizontalAlign = h2d.Flow.FlowAlign.Middle;
        f.verticalAlign = h2d.Flow.FlowAlign.Middle;
        //f.setPosition( 100, 100 );
        f.fillHeight = true; f.fillWidth = true;

        // main title
        mainmenu_title_flow = new h2d.Flow( f );
        var mainmenu_title = new h2d.Text( hxd.res.DefaultFont.get(), mainmenu_title_flow );
        mainmenu_title.text = "Main menu"; mainmenu_title.scale(3); mainmenu_title_flow.padding = 32;

        // buttons
        button_play = new h2d.Interactive( 400, 100, f ); button_play.backgroundColor = 0xFF6BD29E;
        var button_credits = new h2d.Interactive( 400,  50, f ); button_credits.backgroundColor = 0xFF0F1469;
        var button_quit = new h2d.Interactive( 400,  50, f ); button_quit.backgroundColor = 0xFF690F0F;

        //button_quit.y += 60;
        button_play.onClick = (e)->{
            Main_Draft.app.selectLevel();
            hxd.Res.select_low.play();
        };
        button_play.onOver = (e)->{
            button_play_isShivering = true;
        };
        button_play.onOut = (e)->{
            button_play_isShivering = false;
        };

        button_credits.onClick = (e)->{
            Main_Draft.app.selectScene( new IntroScene_Engine() );
            hxd.Res.select_low.play();
        };

        button_quit.onClick = (e)->{ hxd.System.exit(); };

        var t = UI.text( button_play ); t.text = "Play"; t.setPosition(8,8);
        var t = UI.text( button_quit ); t.text = "Quit"; t.setPosition(8,8);
        var t = UI.text( button_credits ); t.text = "Credits"; t.setPosition(8,8);

        f.needReflow=true;
        f.reflow();
        button_play_startX = button_play.absX;
        button_play_startY = button_play.absY;
    }

    override public function update() {
        if( button_play_isShivering ){
            var k = 2;
            mainmenu_title_flow.x += -k + hxd.Math.random(k*2);
            mainmenu_title_flow.y += -k + hxd.Math.random(k*2);
            //button_play.x = button_play_startX -k + hxd.Math.random(k*2);
            //button_play.y = button_play_startY -k + hxd.Math.random(k*2);
        }
    }
}