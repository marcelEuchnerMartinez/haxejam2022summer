
import gameobjects.*;

class Level extends h2d.Scene {

    public final LAYER_BACKGROUND = 0;
    public final LAYER_ENTITIES = 1;
    public final LAYER_WALLS = 2;

    public var walls   : Array< { bounds:h2d.col.Bounds } > = [];
    
    public var background_tilegroup : h2d.TileGroup;
    public var tilegroup_tile : Array<Array<h2d.Tile>>;

    // contained GameObjects
    public var player : Player;
    //public var enemies : Array< Enemy > = [];

    public function new() {
        super();

        var tileset = hxd.Res.tileset.toTile();

        background_tilegroup = new h2d.TileGroup( tileset );
        this.add( background_tilegroup, LAYER_BACKGROUND );

        var k = 32;
        tilegroup_tile = tileset.grid( k );
    }
}