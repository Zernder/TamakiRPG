extends Node

var QuestAccepted: int = 0
var SlimesKilled = 0
var SlimeQuestFinished = false

func Slimequest1():
	if QuestAccepted == 1:
		if SlimesKilled >= 10:
			SlimeQuestFinished = true
