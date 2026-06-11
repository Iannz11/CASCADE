/*if (state != "dead")
{
    var hit = instance_place(x, y, obj_attack);

    if (hit != noone && inv <= 0)
    {
        hp -= 20;

        inv = 30;

        state = "hurt";

        hurt_timer = 15;

        sprite_index = spr_player_hurt;

        image_index = 0;

        instance_destroy(hit);

        if (hp <= 0)
        {
            state = "dead";
        }
    }
}

if (hurt_timer > 0)
{
    hurt_timer--;

    if (hurt_timer <= 0)
    {
        state = "idle";
    }
}*/