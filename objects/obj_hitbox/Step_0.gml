with (obj_inimigo)
{
    if point_distance(x, y, other.x, other.y) < 80
    {
        hp -= other.dano;

        instance_destroy(other.id);
    }
}