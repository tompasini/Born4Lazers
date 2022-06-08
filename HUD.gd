extends CanvasLayer

func _ready():
	$DmgPowerUpQty.text = str(GlobalVariables.dmgPowerUps)


func _on_LZer_dmg_power_up_collected():
	_ready()
