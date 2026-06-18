// Inherit the parent event
event_inherited();

// --- Atributos de Movimentação e Física ---
velocidade = 5;
gravidade = 0.3;
velh = 0;
velv = 0;
pulos = 0;
max_pulo = 1;
forca_pulo = 10;

// --- Atributos de Combate e Status ---
hp_max = 100;
hp = 50;
atk = 100;
cooldown_atk = 20;
cooldown = 0;
iframe = 0;
iframe_max = 100; 

// --- Estados ---
atacando = false;
hurt = false;
hurt_timer = 0;

// --- Inventário ---
inventario = [];
itens_db = {
    dorgaGra: {tipo: "cura", valor: 20},
    dorgaPeq: {tipo: "cura", valor: 10}
}; 

// --- FUNÇÕES DO PLAYER ---

function input_player() 
{
    // Se estiver machucado, não aceita inputs de movimento
    if (hurt) {
        velh = 0;
        return;
    }
    
    var _esquerda = keyboard_check(ord("A"));
    var _direita  = keyboard_check(ord("D"));
    
    // Define a direção do movimento
    var _direcao = _direita - _esquerda;
    velh = _direcao * velocidade; 
    
    // Inverte o sprite baseado na direção que está andando
    if (_direcao != 0) {
        image_xscale = _direcao; // Simplificado: se _direcao é 1, olha pra direita. Se -1, esquerda.
    }
}

function grav() 
{
    var _pulo = keyboard_check_pressed(vk_space); // Mudado para pressed para evitar pulo infinito segurando o botão
    var _em_chao = place_meeting(x, y + 2, obj_bloco);
    
    if (_em_chao) {
        pulos = 0; // Reseta os pulos ao tocar no chão
        if (_pulo && pulos < max_pulo) {
            velv = -forca_pulo;
            pulos++;
        }
    } else {
        velv += gravidade;
    }
}

function hp_player() 
{
    if (iframe > 0) iframe--;

    var _col = instance_place(x, y, obj_inimigo); 
    
    if (_col != noone && iframe == 0) {
        hp -= 1;
        hurt = true;
        hurt_timer = 15;      
        iframe = iframe_max;   
        
        // --- TRAVA DE SEGURANÇA CONTRA SUMIÇO ---
        atacando = false;       // Cancela o estado de ataque imediatamente
        sprite_index = spr_player_hurt; // Força a troca do sprite aqui
        image_index = 0;        // ESSENCIAL: Reseta o frame para o zero absoluto
        image_speed = 0.2;
        
        show_debug_message("HP: " + string(hp));
    }  
    
    if (hurt) {
        hurt_timer--;
        if (hurt_timer <= 0) {
            hurt = false;
        }
    }
    
    hp = clamp(hp, 0, hp_max);
}

function atacar() 
{
    if (cooldown > 0) cooldown--;

    if (keyboard_check_pressed(ord("J")) && !atacando && cooldown <= 0 && !hurt) {
        atacando = true;
        cooldown = cooldown_atk;
        
        sprite_index = spr_player_ataque; // Força o sprite de ataque inicial
        image_index = 0;                  // Começa do frame zero
        image_speed = 1;                  // Garante que a animação vai rodar
        
        // Criar a hitbox
        var offset = 60 * image_xscale;
        var hitbox = instance_create_layer(x + offset, y - 20, "Instances", obj_hitbox);
        hitbox.alarm[0] = 5;
    }

    // FINALIZA O ATAQUE: Quando chegar no último frame da animação atual
    if (atacando) {
        if (image_index >= image_number - 1) {
            atacando = false;
        }
    }
}

function colisao() 
{
    // Colisão Horizontal Perfeita
    if (place_meeting(x + velh, y, obj_bloco)) {
        while (!place_meeting(x + sign(velh), y, obj_bloco)) {
            x += sign(velh);
        }
        velh = 0;
    }
    x += velh;

    // Colisão Vertical Perfeita
    if (place_meeting(x, y + velv, obj_bloco)) {
        while (!place_meeting(x, y + sign(velv), obj_bloco)) {
            y += sign(velv);
        }
        velv = 0;
    }
    y += velv;
}

function usarItem(indice) 
{
    if (indice >= array_length(inventario)) return;
     
    var item_inv = inventario[indice];
    var item_db = itens_db[$ item_inv.id];

    if (item_inv.quantidade > 0) {
        switch(item_db.tipo) {
            case "cura":
                hp += item_db.valor;
                break;
        }

        item_inv.quantidade--;

        if (item_inv.quantidade <= 0) {
            array_delete(inventario, indice, 1);
        }
    }
    hp = clamp(hp, 0, hp_max);
}

// --- CENTRAL DE ANIMAÇÕES (Sua nova função) ---
function controla_animacao() 
{
    var _em_chao = place_meeting(x, y + 2, obj_bloco);
    
    // --- EFEITO DE PISCAR ---
    if (iframe > 0) {
        image_alpha = (iframe div 4) % 2 == 0 ? 0.2 : 1.0;
    } else {
        image_alpha = 1.0; 
    }
    
    // PRIORIDADE 1: Tomando Dano (Hurt)
    if (hurt) {
        if (sprite_index != spr_player_hurt) {
            sprite_index = spr_player_hurt;
            image_index = 0; // Segunda trava de segurança para o frame
        }
        image_speed = 0.2; 
        return; 
    }
    
    // PRIORIDADE 2: Atacando
    if (atacando) {
        if (velh != 0 && _em_chao) {
            if (sprite_index != spr_player_ataqueR) sprite_index = spr_player_ataqueR;
        } else if (!_em_chao) {
            if (sprite_index != spr_player_ataqueP) sprite_index = spr_player_ataqueP;
        } else {
            if (sprite_index != spr_player_ataque) sprite_index = spr_player_ataque;
        }
        image_speed = 1; 
        return; 
    }
    
    // PRIORIDADE 3: Movimentação Comum
    image_speed = 1; 
    
    if (_em_chao) {
        if (velh != 0) {
            sprite_index = spr_player;       
        } else {
            sprite_index = spr_player_idle;  
        }
    } else {
        sprite_index = spr_pulo;             
    }
}