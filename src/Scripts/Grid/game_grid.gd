class_name GameGrid
extends Node2D


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

	return output


func request_move(pos, direction):
	var blocksAtDirection = find_blocks_at_direction(pos, direction)
	
	for block in blocksAtDirection:
		blocks[block] += direction
