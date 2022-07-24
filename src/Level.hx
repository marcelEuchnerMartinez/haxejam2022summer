
import gameobjects.*;

class Level extends h2d.Scene {

    public var walls   : Array< { bounds:h2d.col.Bounds } > = [];

    // contained GameObjects
    public var player : Player;
    //public var enemies : Array< Enemy > = [];

    public function new() {
        super();
    }
}