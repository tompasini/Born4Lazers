extends Label



func _ready():
	GlobalVariables.score = 0
	self.text = str(GlobalVariables.score)
	
func _process(delta):
	if(self.text != str(GlobalVariables.score)):
		self.text = str(GlobalVariables.score)
