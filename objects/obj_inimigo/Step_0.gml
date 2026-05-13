if (hp <= 0) {
    instance_destroy();
}


if distance_to_object(obj_player) < 200
{
    var dir = point_direction(x, y, obj_player.x, obj_player.y);

    x += lengthdir_x(2, dir);
}