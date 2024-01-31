extends Area2D

@export var talksource: DialogueResource
@export var talkstart: String = "start"

func action():
	DialogueManager.show_dialogue_balloon(talksource, talkstart)
