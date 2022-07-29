package;

class Test_Tilesets extends hxd.App {

    static function main() {
        new Test_Tilesets();
        hxd.Res.initLocal();
    }

    public function new() {
        super();

        // tileset
        var k = 170/2;//32/2;
        for( y in 0...30 ){
            for( x in 0...30 ){

                // iso converting test
                var pos = Isometric.world_to_IsometricScreen( x *k, y *k );

                testCoordinates( x, y, 0, 0, pos.x, pos.y );
                testCoordinates( x, y, 1, 2, pos.x, pos.y );
                testCoordinates( x, y, 2, 1, pos.x, pos.y );
                testCoordinates( x, y, 4, 5, pos.x, pos.y );
                testCoordinates( x, y, 5, 4, pos.x, pos.y );
                
                //var img_res = Level.tileset_asiaFloor01;
                //var tileset = img_res.grid(170);
                var tileset = Level.tileset_asiaFloor01;
                var tile = tileset[0][0];
                var group = new h2d.TileGroup( tile, s2d );
                group.add( pos.x, pos.y-(k*1.5), tile ); // -(k + (k/2)) because the upper half of the tile is actually empty and also use the vertical center of the remaining tile
                //background_tilegroup.add( pos.x, pos.y, tile ); // 17 / 2 ... ?? (8.5)

                //trace(pos);
            }
        }
    }

    function testCoordinates( current_x:Float, current_y:Float, place_at_x:Float, place_at_y:Float, isoX:Float, isoY:Float ) {
        if( current_x==place_at_x && current_y==place_at_y ){
            var t = new h2d.Text( UI.font(), s2d );
            t.text = '° ( $place_at_x, $place_at_y )';
            t.setPosition( isoX, isoY ); // add k to y, because tile is at the bottom
            //this.add( t, LAYER_ENTITIES );
        }
    }
}