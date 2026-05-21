// Inherit the parent event
event_inherited();
// música fdp da porr@!!!!!!!!!!!
//audio_play_sound(Battle_theme, 1, true);
velocidade = 5;
gravidade = .3;
hp_max = 100;
hp = 50;
iframe = 0;
iframe_max = 100; 
escala = image_xscale;
atk = 100;
cooldown_atk = 20;
cooldown = 0;
atacando = false;
pulos = 0;
max_pulo = 1;
forca_pulo = 10;


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
	



function input_player()
{
	var _esquerda, _direita, _pulo, _direcao;
	
	_esquerda = keyboard_check(ord("A"));
	_direita = keyboard_check(ord("D"));
	_pulo = keyboard_check(vk_space);
	var _em_chao = place_meeting(x, y + 2, obj_bloco);
	
	_direcao = _esquerda - _direita;
	
if(_direcao != 0){
	image_xscale = -_direcao;
}

velh = (_direita - _esquerda) * velocidade; 

if (!atacando) {
    if (_em_chao) {
        if (velh != 0) {
            sprite_index = spr_player; // Correndo
        } else {
            sprite_index = spr_player_idle; // Parado
        }
    } else {
        sprite_index = spr_pulo;
    }
} else {
    
    if (velh != 0 and _em_chao) {
        sprite_index = spr_player_ataqueR; 
		show_debug_message("1")
    } else if (velh != 0 and velv != 0 and !_em_chao){
		sprite_index = spr_player_ataqueP;
		show_debug_message("2")
	}
	else {
        sprite_index = spr_player_ataque; 
    }
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

function grav(){
	
	var _pulo = keyboard_check(vk_space);
	
	
	var _em_chao = place_meeting(x, y + 2, obj_bloco);
	
	
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

function atacar()
{
    if (keyboard_check_pressed(ord("J"))
    and !atacando
    and cooldown <= 0)
    {
        atacando = true;
        cooldown = cooldown_atk;

        sprite_index = spr_player_ataque;
        image_index = 0;
        image_speed = 1;

        var offset = 60 * image_xscale;

        var hitbox = instance_create_layer(
            x + offset,
            y - 20,
            "Instances",
            obj_hitbox
        );

        hitbox.alarm[0] = 5;
    }

    if (atacando && image_index >= image_number - 1)
    {
        atacando = false;
    }
}

function colisao()
{
    var colidiu = place_meeting(x + velh, y, obj_bloco)
               or place_meeting(x, y + velv, obj_bloco);

    // colisão não controla animação, faz ter bug de disputa entre animações
}