package;

class UI {

    //public static final font : h2d.Font = null;

    public static function button_160x16( ?parent ) {
        return new Button( 160, 16, parent );
    }

    public static function text( ?parent ) {
        return new h2d.Text( font(), parent );
    }

    public static function font() {
        return hxd.res.DefaultFont.get();
    }

    /*public static function init() {
        font = font(); //hxd.res.DefaultFont.get();
    }*/
}

class Button extends h2d.Interactive {
    public var label : h2d.Text;
    public function new( width, height, ?parent ) {
        super( width, height, parent );
        label = new h2d.Text( hxd.res.DefaultFont.get(), this );
    }
    public function labelText ( string:String ){
        label.text = string;
    }
}