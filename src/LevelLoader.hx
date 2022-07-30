
import gameobjects.*;

class LevelLoader {

    public static function loadLevel( level_string:String, startX:Float=0, startY:Float=0, level : Level ) {
        var fieldSize = (170/2);
        var x = 1; // 0
        var y = 0;
        // local function (to calculate the real position in the scene)
        var positionInScene = ( x:Int, y:Int ) -> {
            var sx = (x *fieldSize) + startX;
            var sy = (y *fieldSize) + startY;
            var p = Isometric.world_to_IsometricScreen( sx, sy );
            return {
                x: p.x,
                y: p.y
            };
        };
        for( i in 0...level_string.length ){
            var char = level_string.charAt( i );
            //var posInSc = positionInScene( x, y );
            switch( char ){
                case "\n":
                    y++;
                    x=0;
                case "P":
                    // default floor
                    var posInSc = positionInScene( x, y );
                    var tile = level.tileset_asiaFloor01[0][0];
                    level.background_tilegroup_asiaFloor01.add( posInSc.x, posInSc.y-(fieldSize*1.5), tile );
                    // player
                    //var posInSc = positionInScene( x, y );
                    var p = new Player(level);
                    p.x = (x *fieldSize) + (fieldSize/2);
                    p.y = (y *fieldSize) + (fieldSize/2);
                case "Z":
                    // default floor
                    var posInSc = positionInScene( x, y );
                    var tile = level.tileset_asiaFloor01[0][0];
                    level.background_tilegroup_asiaFloor01.add( posInSc.x, posInSc.y-(fieldSize*1.5), tile );
                case "_":
                    //      default floor
                    var posInSc = positionInScene( x, y );
                    var tile = level.tileset_asiaFloor01[0][0];
                    level.background_tilegroup_asiaFloor01.add( posInSc.x, posInSc.y-(fieldSize*1.5), tile );
                    //      default wall
                    var posInSc = positionInScene( x, y );
                    var tile = level.tileset_wall01;
                    level.background_tilegroup_wall01.add( posInSc.x, posInSc.y-(fieldSize*0)-(tile.height), tile );
                case ".":
                    // sand
                    var posInSc = positionInScene( x, y );
                    var tile = level.tileset_sand01[0][0];
                    level.background_tilegroup_sand01.add( posInSc.x, posInSc.y-(fieldSize*1.5), tile );
                case "~":
                    // water
                    var posInSc = positionInScene( x, y );
                    var tile = level.tileset_water01[0][0];
                    level.background_tilegroup_water01.add( posInSc.x, posInSc.y-(fieldSize*1.5), tile );

                    var b = new h2d.col.Bounds();
                    b.set( x *fieldSize, y *fieldSize, fieldSize, fieldSize );
                    var push = true;

                    for( w in level.map_water ){
                        if( w.y==b.y && w.x==b.x-fieldSize ){
                            w.set( w.x, w.y, w.width+fieldSize, w.height );
                            trace('one bounds spared, size remains ${level.map_water.length}. Instead have $w');
                            push = false;
                        }
                    }
                    if( push ){
                        level.map_water.push( b );
                        trace(level.map_water.length);
                        trace(b);
                    }
                    
                default:
            }
            x++;
        }
    }
}