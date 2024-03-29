extends Node

enum LOCATIONS  {
	START, GAME, SHOP
}

signal game_over
signal location_changed(location: LOCATIONS)
signal points_changed(points: int)
signal knifes_changed(knifes: int)
signal apples_changed(apples: int)
signal stage_changed(stage: Stage)
signal active_knifes_changed(knifes_index: int)
