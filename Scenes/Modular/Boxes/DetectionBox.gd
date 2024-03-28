extends Area2D
class_name EnemyDetectionBox

var DetectionArray = []
var Chase: bool = false
var targetPosition

func _process(delta):
	Arrayprocess()

func Arrayprocess():
	for i in DetectionArray:
		targetPosition = i.position

func DetectionBoxEntered(body):
	if body.is_in_group("Tamaki"):
		DetectionArray.append(body)
		Chase = true


func DetectionBoxExited(body):
		DetectionArray.erase(body)
		Chase = false

