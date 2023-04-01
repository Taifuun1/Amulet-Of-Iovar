extends Node


func _ready():
	initializeSteam()

func _process(_delta):
	Steam.run_callbacks()

func initializeSteam():
	# warning-ignore:return_value_discarded
	Steam.steamInit(false)
#	print("Steam init: " + str(STEAM_INIT))
	
	# warning-ignore:return_value_discarded
	Steam.requestCurrentStats()
	
	# warning-ignore:return_value_discarded
#	Steam.connect("current_stats_received", self, "_steam_Stats_Ready", [], CONNECT_ONESHOT)
#
#func _steam_Stats_Ready(game, result, user):
#	print("This game's ID: "+str(game))
#	print("Call result: "+str(result))
#	print("This user's Steam ID: "+str(user))
