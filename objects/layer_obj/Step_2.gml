var _colx, _coly;

_colx = instance_place(x + velh, y, obj_bloco);
_coly = instance_place(x, y + velv, obj_bloco);
var _colxn, _colyn;

_colxn = instance_place(x + velh, y, obj_layerN);
_colyn = instance_place(x, y + velv, obj_layerN);

if(_colxn){
	
	if(velh > 0)
	{
		x = _colxn.bbox_left +(x - bbox_right);
	}
	if(velh < 0)
	{
		x = _colxn.bbox_right +(x - bbox_left);
	}
	velh = 0;
}
if(_colyn){
	
	if(velv > 0)
	{
		y = _colyn.bbox_top +(y - bbox_bottom);
	}
	if(velv < 0)
	{
		y = _colyn.bbox_bottom +(y - bbox_top);
	}
	velv = 0;
}
if(_colx){
	if(velh > 0)
	{
		x = _colx.bbox_left +(x - bbox_right);
	}
	if(velh < 0)
	{
		x = _colx.bbox_right +(x - bbox_left);
	}
	velh = 0;
}
if(_coly){
	if(velv > 0)
	{
		y = _coly.bbox_top +(y - bbox_bottom);
	}
	if(velv < 0)
	{
		y = _coly.bbox_bottom +(y - bbox_top);
	}
	velv = 0;
}
x += velh;
y += velv;

