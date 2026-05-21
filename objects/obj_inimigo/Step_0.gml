if !instance_exists(obj_player)
{
    exit;
}


// MORTE
if hp <= 0 && state != "dead"
{
    state = "dead";

    image_index = 0;
}


// TIMER DE DANO
if hurt_timer > 0
{
    hurt_timer--;
}

if attack_cooldown > 0
{
    attack_cooldown--;
}

switch(state)
{
    case "idle":

        sprite_index = spr_enemy_idle;

        if distance_to_object(obj_player) < 200
        {
            state = "chase";
        }

    break;



    case "chase":

        sprite_index = spr_enemy_run;

        var dir = point_direction(x, y, obj_player.x, obj_player.y);

        var mov = lengthdir_x(2, dir);

        if !place_meeting(x + mov, y, obj_player)
        {
            x += mov;
        }

        // VIRAR SPRITE
        if obj_player.x > x
        {
            image_xscale = abs(image_xscale);
        }
        else
        {
            image_xscale = -abs(image_xscale);
        }

        // ENTRAR EM ATAQUE
        if distance_to_object(obj_player) < 40
&& attack_cooldown <= 0
{
    state = "attack";

    image_index = 0;
}

        // PLAYER LONGE
        if distance_to_object(obj_player) > 250
        {
            state = "idle";
        }

    break;



    case "attack":

    sprite_index = spr_enemy_attack;

    image_speed = 0.3;

    // DANO EM UM FRAME ESPECÍFICO
    if image_index >= 2 && !attack_hit
    {
        if distance_to_object(obj_player) < 50
        {
            obj_player.hp -= 10;

            attack_hit = true;
        }
    }

    // FIM DO ATAQUE
    if image_index >= image_number - 1
    {
        attack_hit = false;

        state = "chase";
    }

break;



    case "hurt":

        sprite_index = spr_enemy_hurt;

        image_speed = 0.2;

        if hurt_timer <= 0
        {
            state = "chase";
        }

    break;



    case "dead":

        sprite_index = spr_enemy_dead;

        image_speed = 0.15;

        if image_index >= image_number - 1
        {
            instance_destroy();
        }

    break;
}