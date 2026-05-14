input_player();
hp_player();
colisao();

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

if (cooldown_atk > 0) {
    cooldown_atk--;
}

if (keyboard_check_pressed(ord("J")) && cooldown_atk <= 0) {

    atacar();

    cooldown_atk = 1; // ainda precisamos de um valor
}