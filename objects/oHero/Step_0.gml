  
//равботает во всех состояниях
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check(vk_space);
key_attack = keyboard_check(vk_shift);
key_run_start = keyboard_check(vk_control);
key_run_stop = keyboard_check_released(vk_control);
if keyboard_check(ord("R")) room_restart();

var move = key_right-key_left;
hsp = move*walksp;



//горизонтальная коллизия
if (place_meeting(x+hsp,y,oWall)) {
	while(!place_meeting(x+sign(hsp),y,oWall))
	{
	x=x+sign(hsp);	
	}
	hsp=0;
}


if (fall=1) {
	
	image_speed=0;
	sprite_index = sJump;
	
	if vsp > 0 image_index = 4;
	if vsp < 0 image_index = 2;
	
	walksp = 4;
	x=x+hsp;
	
	vsp = vsp + grv;
//вертикальная коллизия
if (place_meeting(x,y+vsp,oWall)) {
	while(!place_meeting(x,y+sign(vsp),oWall))
	{ 
	y=y+sign(vsp);	
	}
	vsp=0;
}

y=y+vsp;

}


if (hsp>0) {
		
		image_xscale = 1;
	}
	if (hsp<0) {
		
		image_xscale = -1;		
	}

//тут состояния
if walk == 1{  //хотьба
	walksp = 4;
	x=x+hsp;
	sprite_index = sWalk;
	image_speed=1;

}

if idle = 1 { //idle
	sprite_index = sIdle;
	image_speed = 1;
}

if jump == 1 { //jump

	if (keyboard_check(vk_space) && canJump) {
		vsp = -7;
		y-=2;
		canJump=0;
	}
	//x=x+hsp;
}

//run
if (run == 1) {
	walksp = 8;
	x=x+hsp;
	sprite_index = sWalk;
	image_speed = 2;
}
//attack
if (attack == 1) {
	sprite_index = sAttack;
	if (image_index>=5) {
	attack = 0;
	idle = 1;
	}
}

//тут переходы
if hsp<>0 && (idle ==1 || run ==1) {
walk = 1;
idle = 0;
run=0;
attack=0;
jump=0;
fall=0;
}

if (hsp == 0 && walk == 1) {
walk = 0;
idle = 1;
run=0;
attack=0;
jump=0;
fall=0;
}

if (key_jump && (walk ==1 || idle ==1 || run ==1)) {
walk = 0;
idle = 0;
run=0;
attack=0;
jump=1;
fall=0;
}

/*if (jump == 1 && vsp>0.1 && place_meeting(x,y+1,oWall) ) {
walk = 0;
idle = 1;
run=0;
attack=0;
jump=0;	
	
}*/

if (walk ==1 && key_run_start) {
walk = 0;
idle = 0;
run=1;
attack=0;
jump=0;	
fall=0;
}

if (run ==1 && key_run_stop) {
walk = 1;
idle = 0;
run=0;
attack=0;
jump=0;	
fall=0;
}
if (idle == 1 && key_attack) {
walk = 0;
idle = 0;
run=0;
attack=1;
jump=0;	
fall=0;
}

if ((walk || run || jump)&&!place_meeting(x,y+1,oWall)) {
walk = 0;
idle = 0;
run=0;
attack=0;
jump=0;	
fall=1;
} 

if (fall && place_meeting(x,y+1,oWall)) {
walk = 0;
idle = 1;
run=0;
attack=0;
jump=0;	
fall=0;

canJump=1;
}
 
//distance_to_point




