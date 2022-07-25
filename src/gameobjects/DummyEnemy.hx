package gameobjects;

class DummyEnemy extends GameObject {

    var ability_dash_cooldown : Float = 0;

    public var movingDirection : Float = 0;

    var ability_running_stamina : Float = 100;
    var ability_running_active = false;

    public function new( lvl ) {
        super( lvl );

        useDummySprite_bottomCenter( 0x00C8FF,16,32 );
        
        hitbox = sprite.getBounds();

        level.add( this.spriteBase, level.LAYER_ENTITIES );

        level.enemies.push( this );
    }

    override function update() {
        var speed = 1;

        // dash ability

        if( ability_dash_cooldown > 0 )
            ability_dash_cooldown -= 0.01;
        else
            ability_dash_cooldown = 0;

        if( playerInDistance(50) && ability_dash_cooldown==0 ){
            speed = speed * 20;
            ability_dash_cooldown = 1;
        }

        // movement

        var p1 = level.player;

        var _canSeePlayer = playerInDistance(200);

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
        var k = 20;
        for( en in level.enemies )
            if( en!=this && en.distanceSq( this )<20 ){
                x += -k + hxd.Math.random( k );
                y -= -k + hxd.Math.random( k );
            }

        // can't leave "board"
        var k=500;
        if( x<-k || x>k || y<-k || y>k )
            movingDirection = movingDirection+Math.PI+hxd.Math.random(Math.PI*0.2);
        if(movingDirection>Math.PI*2)
            movingDirection -= Math.PI*2;
        if(movingDirection<0)
            movingDirection += Math.PI*2;
    }

    function playerInDistance( distance:Float ) {
        if( hxd.Math.distanceSq(level.player.x - this.x, level.player.y - this.y) < distance*distance )
            return true
        else
            return false;
    }
}