if (hp <= 0)
{
    instance_destroy();
}


// Cooldown de ataque
if attack_cooldown > 0
{
    attack_cooldown--;
}

if !instance_exists(obj_player)
{
    exit;
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

        // Movimento
        if !place_meeting(x + mov, y, obj_player)
        {
            x += mov;
        }

        // Virar sprite
        if obj_player.x > x
        {
            image_xscale = abs(image_xscale);
        }
        else
        {
            image_xscale = -abs(image_xscale);
        }

        // Ataque
        if distance_to_object(obj_player) < 20
        {
            if attack_cooldown <= 0
            {
                obj_player.hp -= 10;

                attack_cooldown = 60;
            }
        }

        // Voltar ao idle
        if distance_to_object(obj_player) > 250
        {
            state = "idle";
        }

    break;
}