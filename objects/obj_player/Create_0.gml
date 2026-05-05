// Inherit the parent event
event_inherited();

velocidade = 5;
gravidade = .3;
hp_max = 100;
hp = 50;
iframe = 0;
iframe_max = 100; 
escala = image_xscale;
atk = 20;
cooldown_atk = 0;
atacando = false;

inventario = [];

itens_db = {
    dorgaGra: {tipo: "cura", valor: 20},
    dorgaPeq: {tipo: "cura", valor: 10}
}; 

//Essa função iremos remover, eu só coloquei pois queria testar
function addItem(id, qtd){
	for (var i = 0; i < array_length(inventario); i++){
		if (inventario [i].id == id) {
			inventario[i].quantidade += qtd;
            return;
		}
	}
			array_push(inventario, {
        id: id,
        quantidade: qtd
    });
}
	

forca_pulo = 14;

function input_player()
{
	var _esquerda, _direita, _pulo, _direcao;
	
	_direita = keyboard_check(ord("A"));
	_esquerda = keyboard_check(ord("D"));
	
	if(_esquerda)
{
    image_xscale = escala;
}

if(_direita)
{
    image_xscale = -escala;
}
	
	_pulo = keyboard_check(vk_space);
	
	velh = (_esquerda - _direita) * velocidade;
	
	var _em_chao = place_meeting(x, y + 1, obj_bloco);
	var _iframe = place_meeting(x, y + 1, obj_inimigo);
	
	if(_em_chao)
	{
		if(_pulo)
		{
			velv = -forca_pulo;
		}
	}
	else
	{
		velv += gravidade;
	}
}

function hp_player()
{
	
	
	var _col = instance_place(x + velh, y + velv, obj_inimigo);
	

	if (_col != noone && iframe == 0)
	{
	    hp -= 1;
		iframe = iframe_max;
		show_debug_message(hp)
	}if	(iframe > 0){
		iframe --;
	}if (hp == 0){
		game_restart()
	}
	 
	 
}

function usarItem (indice){
	 if (indice >= array_length(inventario)) return;
	 
	 var item_inv = inventario[indice];
	 var item_db = itens_db[$ item_inv.id];

	 if (item_inv.quantidade > 0) {

        switch(item_db.tipo) {

            case "cura":
                hp += item_db.valor;
				show_debug_message(hp)
                break;
        }

        item_inv.quantidade--;

        if (item_inv.quantidade <= 0) {
            array_delete(inventario, indice, 1);
        }
    }

    hp = clamp(hp, 0, hp_max);
}

function atacar() {

    if (keyboard_check_pressed(ord("J")) && !atacando) {

        atacando = true;

        sprite_index = spr_player_ataque;
        image_index = 0;

        var hitbox = instance_create_layer(x + (20 * image_xscale), y,"Instances", obj_hitbox);
       
        hitbox.alarm[0] = 5;
    }
	if (atacando && image_index >= image_number - 1) {
		atacando = false;
	}
	if (!atacando) {

		if (obj_hitbox) {
		    sprite_index = spr_player;
		 }else{
			 sprite_index = spr_player;
		 }
	}

}

function colisao(){
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
}

