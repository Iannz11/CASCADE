input_player();
hp_player();
var colidiu = place_meeting(x + velh, y, obj_bloco) or place_meeting(x, y + velv, obj_bloco);

if (colidiu) {
    image_index = 0;
    image_speed = 0;
} else {
    var movendo = (velh != 0) or (velv != 0);

    if (movendo) {
        image_speed = 1;

        
        if (floor(image_index) == 0) {
            image_index = 3;
        }
    } else {
        image_speed = 0;
        image_index = 0;
    }
}

if (keyboard_check_pressed(ord("Q"))) {
    addItem("dorgaGra", 1);
}

if (keyboard_check_pressed(ord("E"))) {
    usarItem(0);
}