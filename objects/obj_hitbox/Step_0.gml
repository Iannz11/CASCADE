with (obj_enemy_parent)
{
    if state != "dead"
    {
        var dist = point_distance(x, y, other.x, other.y);

        if dist < 80
        {
            hp -= 20;

            if hp > 0
            {
                state = "hurt";

                hurt_timer = 15;
            }

            instance_destroy(other.id);
        }
    }
}