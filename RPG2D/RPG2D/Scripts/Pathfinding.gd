extends TileMap

var astar
var obstacles = []

var tile_size = 64
var offset = 32

export var size_x = 21
export var size_y = 14


func _ready():
    astar = AStar2D.new()
    var obstacles_cords = get_used_cells_by_id(3)
    for cord in obstacles_cords:
        obstacles.append(Vector2(cord[0] * tile_size + offset,
                        cord[1] * tile_size + offset))

    for i in range(size_y):
        for j in range(size_x):
            astar.add_point(i*size_x + j,
            Vector2(j*tile_size + offset, i*tile_size + offset))    
    for i in range(size_y):
        for j in range(size_x):
            if !(astar.get_point_position(i*size_x + j) in obstacles):

                if astar.has_point(i*size_x + j - 1):
                    if !(astar.get_point_position(i*size_x + j - 1) in obstacles):
                        astar.connect_points(i*size_x + j, i*size_x + j - 1, false)
                
                if astar.has_point(i*size_x + j + 1):
                    if !(astar.get_point_position(i*size_x + j + 1) in obstacles):
                        astar.connect_points(i*size_x + j, i*size_x + j + 1, false)
                
                if astar.has_point((i-1)*size_x + j):
                    if !(astar.get_point_position((i-1)*size_x + j) in obstacles):
                        astar.connect_points((i-1)*size_x + j, i*size_x + j, false)
                
                if astar.has_point((i+1)*size_x + j):
                    if !(astar.get_point_position((i+1)*size_x + j) in obstacles):
                        astar.connect_points((i+1)*size_x + j, i*size_x + j, false)

func get_path_array(start, end):
    var start_id = astar.get_closest_point(start)
    var end_id = astar.get_closest_point(end)
    if astar.get_point_position(end_id) in obstacles:
        return null
    elif start_id != -1 and end_id != -1:
        var path = astar.get_point_path(start_id, end_id)
        return path if len(path) > 0 else null
