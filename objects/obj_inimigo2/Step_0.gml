if hp <= 0
{
    instance_destroy();
}

if !instance_exists(obj_player)
{
    exit;
}


// MORTE
if hp <= 0
{
    instance_destroy();
}


// COOLDOWN
if attack_cooldown > 0
{
    attack_cooldown--;
}


switch(state)
{
    case "idle":

        sprite_index = spr_enemy2_run;

        if distance_to_object(obj_player) < 300
        {
            state = "chase";
        }

    break;



    case "chase":

        sprite_index = spr_enemy2_run;

        var alvo_x = obj_player.x;
var alvo_y = obj_player.y - 40;

var dist = point_distance(x, y, alvo_x, alvo_y);

var dir = point_direction(x, y, alvo_x, alvo_y);


// Movimento
if dist > 30
{
    x += lengthdir_x(speed_fly, dir);
    y += lengthdir_y(speed_fly, dir);
}


        // VIRAR SPRITE
        if obj_player.x > x
{
    image_xscale = -abs(image_xscale);
}
else
{
    image_xscale = abs(image_xscale);
}


        // ATAQUE
        if distance_to_object(obj_player) < 40
        {
            if attack_cooldown <= 0
            {
                obj_player.hp -= 10;

                attack_cooldown = 60;
            }
        }


        // PERDER AGRO
        if distance_to_object(obj_player) > 400
        {
            state = "idle";
        }

    break;
}

y += sin(current_time / 200) * 0.3;