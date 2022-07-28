package;

import hxd.Res;

class UI {

    //public static final font : h2d.Font = null;

    public static final COLOR_button_out  = 0xFF669999;
    public static final COLOR_button_over = 0xFFb3cccc;
    public static final COLOR_button_push = 0xFF334d4d;

    public static function button_400x50( ?parent ) {
        return button( 400, 50, parent );
    }

    public static function button_160x40( ?parent ) {
        return button( 160, 40, parent );
    }

    public static function button_160x16( ?parent ) {
        return button( 160, 16, parent );
    }

    public static function button( width, height, ?parent, ?sound:hxd.res.Sound ){
        var b = new Button( width, height, parent );
        b.backgroundColor = COLOR_button_out;
        b.onOver = (e)->{ b.backgroundColor = COLOR_button_over; };
        b.onOut  = (e)->{ b.backgroundColor = COLOR_button_out;  };
        b.onPush = (e)->{ b.backgroundColor = COLOR_button_push; if(sound==null)sound=hxd.Res.select_low; sound.play(); };
        return b;
    }

    public static function text( ?parent ){
        return new h2d.Text( font(), parent );
    }

    public static function font(){
        return hxd.res.DefaultFont.get();
    }

    /*public static function init() {
        font = font(); //hxd.res.DefaultFont.get();
    }*/
}

class Button extends h2d.Interactive {
    public var label : h2d.Text;
    public function new( width, height, ?parent ){
        super( width, height, parent );
        label = new h2d.Text( hxd.res.DefaultFont.get(), this );
    }
    public function labelText ( string:String ){
        label.text = string;
    }
}