// Inherit the parent event
event_inherited();

velocidade = 5;
gravidade = .3;
hp = 5;
iframe = 0;
iframe_max = 100; 
escala = image_xscale;


forca_pulo = 8;

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