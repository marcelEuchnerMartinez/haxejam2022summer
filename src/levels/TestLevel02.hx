package levels;

import gameobjects.*;

import Isometric;

import hxd.Res;

class TestLevel02 extends Level {
    
    public function new() {
        super();

        Audio.playContinue( Audio.MusicState.THEME_BEGINNERAREA );

        var t = new h2d.Text( UI.font() );
        this.add( t, LAYER_HUD );
        t.text = '$this';
        //t.text = "Controls\nmove   - ARROW KEYS / W-A-S-D\ndash   - SPACE\nduck   - CTRL / SHIFT\nshoot  - LEFT MOUSE\nreload - R";
        t.scale( 2 );
        t.setPosition( 0, this.height - t.getBounds().height );

        var txt = hxd.Res.level00.entry.getText();
        LevelLoader.loadLevel( txt, 0, 0, this );
        useLevelSizeFromTextFileMap(txt);

        this.next_level = TestLevel02;
        this.next_level_scoreNeeded = 3;

        //background_tilegroup.alpha = 0.2;

        hud_currentLevel_h2dText.text = '$this';

        for( i in 0...1 ){
            var en = new DummyEnemy(this);
            //en.movingDirection = hxd.Math.random( Math.PI *2 );
            var p1 = this.player;
            en.movingDirection = hxd.Math.atan2( p1.y - y, p1.x - x );
            en.placeAtRandomPosition_noWater();
        }

        for( i in 0...5 ){
            var o = new Ammunition(this);
            o.placeAtRandomPosition_noWater();
        }

        /*for( i in 0...4 ){
            var bmp = new h2d.Bitmap( hxd.Res.WallConcreteFront.toTile() );
            this.add( bmp, LAYER_ENTITIES );
            bmp.x = 0 + (i*(170/2));//100 + (i*98);
            bmp.y = 0;//100;
            var p = Isometric.world_to_IsometricScreen( bmp.x, bmp.y );
            bmp.setPosition( p.x, p.y );
            bmp.y -= hxd.Res.WallConcreteFront.getSize().height;
        }*/

        //idea_dummywalls();
    }

    override public function update() {
        super.update();
    }


}