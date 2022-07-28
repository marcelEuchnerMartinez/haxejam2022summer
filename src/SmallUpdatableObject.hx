package;

class SmallUpdatableObject {
    public var onUpdate : ()->Void;
    var level : Level;
    public function new(lvl:Level) {level=lvl; level.smallUpdatables.push(this);}
    public function remove(){
        level.smallUpdatables.remove(this);
    }
}