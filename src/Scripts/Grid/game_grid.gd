class_name GameGrid
extends Node2D


var leaks = 0
var blocks = {}


func find_block_at_position(pos):
	for block in blocks.keys():
		if blocks[block] == pos:
			return block
	
	return null


func find_blocks_at_direction(pos, direction):
	var output = []
	var ray = pos
	var current = find_block_at_position(ray)

	while current != null:
		output.append(current)
		ray += direction
		current = find_block_at_position(ray)
		
		if current != null and !current is MoveableBlock:
			return null

	return output


func request_move(pos, direction):
	var blocks_at_direction = find_blocks_at_direction(pos, direction)
	
	if blocks_at_direction == null:
		return
	
	for block in blocks_at_direction:
		blocks[block] += direction
