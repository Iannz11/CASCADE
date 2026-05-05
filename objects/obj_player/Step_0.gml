input_player();
hp_player();
colisao();
atacar();

if (keyboard_check_pressed(ord("Q"))) {
    addItem("dorgaGra", 1);
}

if (keyboard_check_pressed(ord("E"))) {
    usarItem(0);
}

if (cooldown_atk > 0) {
    cooldown_atk--;
}

if (keyboard_check_pressed(ord("Z")) && cooldown_atk <= 0) {

    atacar();

    cooldown_atk = 1; // ainda precisamos de um valor
}