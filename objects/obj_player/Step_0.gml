input_player();
grav();
atacar();
hp_player();
colisao();          // Trata o movimento e impede de entrar nas paredes
controla_animacao(); // Decide o sprite correto com base no que aconteceu acima
var inimigo = instance_place(x + velh, y, obj_enemy_parent);
if (x > room_width)
{
    room_goto_next();
}
if inimigo != noone
{
    if inimigo.state != "dead"
    {
        velh = 0;
    }
}


if hp <= 0
{
    hp = 0;

    game_restart();
}

if (keyboard_check_pressed(ord("Q"))) {
    addItem("dorgaGra", 1);
}

if (keyboard_check_pressed(ord("E"))) {
    usarItem(0);
}

if (cooldown > 0){
    cooldown--;
}
/*if (keyboard_check_pressed(ord("J")) and cooldown_atk <= 0) {

    atacar();

    cooldown_atk = 1; // ainda precisamos de um valor
}*/
