package;

class Isometric {

    static function main() {IsometricTest.main();}

    // 9 or 17/2 ?? px H on screen
    // 32 / 2 = 16 px W on screen
    //

    public static function isometricScreen_to_world ( x:Float, y:Float ) {

        //var iso_w : Float =   1;
        //var iso_h : Float = 0.5;
        //var convX = x - (y*iso_w);
        //var convY = - (y*iso_h) + (x*iso_h);
        var iso_w : Float =   1;
        var iso_h : Float = 0.5;
        //var convX = x - (y*iso_w);
        //var convY = (y*2) + (x*iso_h);
        //var convX = x - y;
        //var convY = (y * 2) +x;
        //var vx = x - Math.cos(  );
        //var vy =
        var convX = (x*0.5) - y;//(y*2)
        var convY = y + (x*0.5); // seems correct
        //var convX = ( x*iso_w) + (y*iso_w);
        //var convY = (-x*2) + (y*2);

        return { x: convX , y: convY };
    }

    public static function world_to_IsometricScreen ( x:Float, y:Float ) {
        return _world_to_IsometricScreen_003( x, y );
    }

    static function _world_to_IsometricScreen_003 ( x:Float, y:Float ) {

        var iso_w : Float =   1;
        var iso_h : Float = 0.5;
        var convX = ( x*iso_w) + (y*iso_w);
        var convY = (-x*iso_h) + (y*iso_h);//(y*iso_h) - (x*iso_h);

        return { x: convX , y: convY };
    }

    static function _world_to_IsometricScreen_002 ( x:Float, y:Float ) {

        var TILE_WIDTH  : Float = 32;
        var TILE_HEIGHT : Float = 32;
        var convX = (x)*(TILE_WIDTH/2 ) + (y)*-TILE_HEIGHT;
        var convY = (x)*(TILE_HEIGHT/2) + (y)*(TILE_HEIGHT/2);

        return { x: convX , y: convY };
    }

    static function _world_to_IsometricScreen_001 ( x:Float, y:Float ) {
        var a = Math.PI * 0.25;
        var k = 32;
        var iso_w = k;
        var iso_h = k/2;
        var convX = x + (y*iso_w);//(Math.cos(a) *k) + (Math.sin(a) *k);
        var convY = y - (x*iso_h) - (y*iso_h);//(Math.cos(a) *k) + (Math.sin(a) *k);

        return { x: convX , y: convY };
    }
}

class IsometricTest {
    public static function main() {
        trace("Checking isometric conversion...");
        

        compare(  0,  0,  0,  0 );
        compare(  4,  0,  4, -2 );
        compare(  8,  0,  8, -4 );
        compare( 12,  0, 12, -6 );

        compare(  0,  4,  4,  2 );
        compare(  4,  4,  8,  0 );
        compare(  8,  4, 12, -2 );
        compare( 12,  4, 16, -4 );

        compare(  0,  8,  8,  4 );
        compare(  4,  8, 12,  2 );
        compare(  8,  8, 16,  0 );
        compare( 12,  8, 20, -2 );

        compare(  0, 12, 12,  6 );
        compare(  4, 12, 16,  4 );
        compare(  8, 12, 20,  2 );
        compare( 12, 12, 24,  0 );

        compare(  0,  0,  0,  0, false );
        compare(  4,  0,  4, -2, false );
        compare(  8,  0,  8, -4, false );
        compare( 12,  0, 12, -6, false );

        compare(  0,  4,  4,  2, false );
        compare(  4,  4,  8,  0, false );
        compare(  8,  4, 12, -2, false );
        compare( 12,  4, 16, -4, false );

        compare(  0,  8,  8,  4, false );
        compare(  4,  8, 12,  2, false );
        compare(  8,  8, 16,  0, false );
        compare( 12,  8, 20, -2, false );

        compare(  0, 12, 12,  6, false );
        compare(  4, 12, 16,  4, false );
        compare(  8, 12, 20,  2, false );
        compare( 12, 12, 24,  0, false );
    }

    static function compare( pw_x:Float, pw_y:Float, ps_x:Float, ps_y:Float, worldToIsometricScreen:Bool=true ){
        var pw = new TestCoordinates( pw_x, pw_y );
        var ps = new TestCoordinates( ps_x, ps_y );

        // conversion
        if( worldToIsometricScreen ){
            var p = Isometric.world_to_IsometricScreen( pw.x, pw.y );
            pw.x = p.x;
            pw.y = p.y;
        }
        else {
            var p = Isometric.isometricScreen_to_world( ps.x, ps.y );
            ps.x = p.x;
            ps.y = p.y;
        }

        var m = "";
        var success = false;
        if( pw.x == ps.x && pw.y == ps.y )
            success = true;
        if( worldToIsometricScreen )
            m += 'check ${(success?"successful":"FAILED(!)")} for world_to_IsometricScreen';
        else
            m += 'check ${(success?"successful":"FAILED(!)")} for isometricScreen_to_world';
        if(!success)
            m += ": pw: " + pw.toString() + " <-> ps: " + ps.toString();
        trace(m);
    }

}

class TestCoordinates {
    public var x : Float;
    public var y : Float;
    public function new( _x:Float, _y:Float ) {
        x = _x;
        y = _y;
    }
    public function toString() {
        return '( $x, $y)';
    }
}