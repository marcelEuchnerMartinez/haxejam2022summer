package gameobjects;

class DummyEnemy extends GameObject {

    var ability_dash_lastDash : Float = -1;
    var ability_dash_cooldown : Float = 0;

    public var movingDirection : Float = 0;

    var ability_running_stamina : Float = 100;
    var ability_running_active = false;

    public function new( lvl ) {
        super( lvl );

        useDummySprite_bottomCenter( 0x00C8FF,16,32 );
        
        //hitbox = sprite.getBounds();

        level.add( this.spriteBase, level.LAYER_ENTITIES );

        level.enemies.push( this );
    }

    override function remove() {
        super.remove();
        level.enemies.remove( this );
    }

    override function update() {
        var speed = 1;

        // dash ability

        if( ability_dash_cooldown > 0 )
            ability_dash_cooldown -= 0.01; // make sure value 0.1 can be obtained !!!! otherwise can never dash player
        else
            ability_dash_cooldown = 0;

        ability_dash_lastDash += 0.01;

        // movement

        var p1 = level.player;

        var _canSeePlayer = ( playerInDistance(500) || (hxd.Key.isPressed(hxd.Key.MOUSE_LEFT)&&playerInDistance(1500)) );  // && canSeeThrough( p1.asPoint() ));

        if( level.player.isDucking )
            _canSeePlayer = playerInDistance(66);


        if( _canSeePlayer && playerInDistance(50) && ability_dash_cooldown==0 ){
            speed = speed * 20;
            ability_dash_cooldown = 1;
            ability_dash_lastDash = 0;
        }

        if( _canSeePlayer )
            cast( sprite, h2d.Bitmap).color = h3d.Vector.fromColor(0xFFFFC400);

        // head towards player
        if( p1!=null )
            if( _canSeePlayer )
                movingDirection = hxd.Math.atan2( p1.y - y, p1.x - x );

        // running ability
        // run when can see player
        if( _canSeePlayer && ability_running_stamina>1 ){
            ability_running_active = true;
            cast( sprite, h2d.Bitmap).color = h3d.Vector.fromColor(0xFFFFC400);
        }
        else {
            cast( sprite, h2d.Bitmap).color = h3d.Vector.fromColor(0xFF00C8FF);
        }
        // speed up when running/enough stamina
        if( ability_running_active ){
            if( ability_running_stamina>0 ){
                speed = speed * 2;
                ability_running_stamina -= 0.1;
            }
            else {
                ability_running_active = false;
            }
        }
        else {
            if( ability_running_stamina < 100 )
                ability_running_stamina += 0.1;
        }

        // move
        x += Math.cos( movingDirection ) * speed;
        y += Math.sin( movingDirection ) * speed;

        // collison with other enemies
        var k = 4;
        for( en in level.enemies )
            if( en!=this && en.distanceSq( this )<144 ){
                var angle = Math.atan2( en.y - this.y, en.x - this.x );
                var kbx = Math.cos( angle ) *k;
                var kby = Math.sin( angle ) *k;
                en.x += kbx;
                en.y += kby;
                x -= kbx;
                y -= kby;
            }

        // collision with player
        if( this.playerInDistance(32,0,-16) && ability_dash_lastDash==0 ){ // enemy has *just* dashed (!! make sure value can be obtained)
            var dmg = 5;
            level.player.lifepoints -= dmg;
            var t = UI.text(); level.add( t, level.LAYER_INFO );
            t.text = '-$dmg'; t.textColor = 0xFF0000; t.scale( 2 );
            t.setPosition( level.player.spriteBase.x, level.player.spriteBase.y );
            //var tm = haxe.Timer.delay( ()->{t.remove();}, 3*1000 );
            var u = new SmallUpdatableObject(level);
            u.onUpdate = ()->{
                t.alpha-=0.001;
                t.y-=1;
                if( t.alpha<0.1 ){
                    u.remove();
                    t.remove();
                }
            };
        }

        // can't leave "board"
        if( level.cageInsideScene( this ) ){
            movingDirection = movingDirection+Math.PI+hxd.Math.random(Math.PI*0.2);
        }
        /*var k=1000;
        if( x<0 || x>k || y<0 || y>k )
            movingDirection = movingDirection+Math.PI+hxd.Math.random(Math.PI*0.2);
        if(movingDirection>Math.PI*2)
            movingDirection -= Math.PI*2;
        if(movingDirection<0)
            movingDirection += Math.PI*2;*/
    }

    function playerInDistance( distance:Float, offset_x:Float=0, offset_y:Float=0 ) {
        if( hxd.Math.distanceSq( (level.player.x + offset_x) - this.x, (level.player.y + offset_y) - this.y) < distance*distance )
            return true
        else
            return false;
    }
}