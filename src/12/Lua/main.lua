function printMatrix(matrix)
    for i = 1, #matrix do
        for j = 1, #matrix[i] do
            io.write(matrix[i][j])
        end
        print() -- new line
    end
end

function getNext(matrix, row, column, length)
    if column < length then
        return matrix[row][column + 1]
    else
        return nil
    end
end

function getLast(matrix, row, column)
    if column > 1 then
        return matrix[row][column - 1]
    else
        return nil
    end
end

function getUpper(matrix, row, column)
    if row > 1 then
        return matrix[row - 1][column]
    else
        return nil
    end
end

function getLower(matrix, row, column, height)
    if row < height then
        return matrix[row + 1][column]
    else
        return nil
    end
end

function getElevation(e)
    if e == "E" then
        return string.byte("z")
    end
    return string.byte(e)
end

local file = io.open("../input.txt", "r") -- read file

local matrix = {}
local row = 0
local length = 0
local height = 0
local posE = {}
local posS = {}
local aIndex = {}
local aCount = 0

for line in file:lines() do
    -- line by line
    row = row + 1
    length = #line
    height = row
    matrix[row] = {}
    for column = 1, #line do
        -- length of line
        local ch = line:sub(column, column) -- char at index
        matrix[row][column] = ch
        if ch == "E" then
            posE["row"] = row
            posE["col"] = column
        end
        if ch == "S" then
            posS["row"] = row
            posS["col"] = column
        end
        if ch == "a" then
            aCount = aCount + 1
            aIndex[aCount] = row * length + column - length
        end
    end
end

local edges = {}

-- form graph
for i = 1, #matrix do
    for j = 1, #matrix[i] do
        index = i * length + j - length
        edges[index] = {}
        local current = matrix[i][j]
        local last, next, up, down = getLast(matrix, i, j), getNext(matrix, i, j, length), getUpper(matrix, i, j), getLower(matrix, i, j, height)


        if last ~= nil then
            if getElevation(last) <= getElevation(current) + 1 or current == "S" then
                edges[index][index - 1] = 1
                --print(index, index - 1)
            end
        end
        if next ~= nil then
            if getElevation(next) <= getElevation(current) + 1 or current == "S" then
                edges[index][index + 1] = 1
                --print(index, index + 1)
            end
        end
        if up ~= nil then
            if getElevation(up) <= getElevation(current) + 1 or current == "S" then
                edges[index][index - length] = 1
                --print(index, index - length)
            end
        end
        if down ~= nil then
            if getElevation(down) <= getElevation(current) + 1 or current == "S" then
                edges[index][index + length] = 1
                --print(index, index + length)
            end
        end
    end
end


local starting_vertex = posS["row"] * length + posS["col"] - length
local destination_vertex = posE["row"] * length + posE["col"] -length

-- below code is from stackoverflow: https://stackoverflow.com/a/55919336
function p1(_starting_vertex)
    local function create_dijkstra(_starting_vertex)
        local shortest_paths = { [_starting_vertex] = { full_distance = 0 } }
        local vertex, distance, heap_size, heap = _starting_vertex, 0, 0, {}
        return
        function(adjacent_vertex, edge_length)
            if adjacent_vertex then
                -- receiving the information about adjacent vertex
                local new_distance = distance + edge_length
                local adjacent_vertex_info = shortest_paths[adjacent_vertex]
                local pos
                if adjacent_vertex_info then
                    if new_distance < adjacent_vertex_info.full_distance then
                        adjacent_vertex_info.full_distance = new_distance
                        adjacent_vertex_info.previous_vertex = vertex
                        pos = adjacent_vertex_info.index
                    else
                        return
                    end
                else
                    adjacent_vertex_info = { full_distance = new_distance, previous_vertex = vertex, index = 0 }
                    shortest_paths[adjacent_vertex] = adjacent_vertex_info
                    heap_size = heap_size + 1
                    pos = heap_size
                end
                while pos > 1 do
                    local parent_pos = (pos - pos % 2) / 2
                    local parent = heap[parent_pos]
                    local parent_info = shortest_paths[parent]
                    if new_distance < parent_info.full_distance then
                        heap[pos] = parent
                        parent_info.index = pos
                        pos = parent_pos
                    else
                        break
                    end
                end
                heap[pos] = adjacent_vertex
                adjacent_vertex_info.index = pos
            elseif heap_size > 0 then
                -- which vertex neighborhood to ask for?
                vertex = heap[1]
                local parent = heap[heap_size]
                heap[heap_size] = nil
                heap_size = heap_size - 1
                if heap_size > 0 then
                    local pos = 1
                    local last_node_pos = heap_size / 2
                    local parent_info = shortest_paths[parent]
                    local parent_distance = parent_info.full_distance
                    while pos <= last_node_pos do
                        local child_pos = pos + pos
                        local child = heap[child_pos]
                        local child_info = shortest_paths[child]
                        local child_distance = child_info.full_distance
                        if child_pos < heap_size then
                            local child_pos2 = child_pos + 1
                            local child2 = heap[child_pos2]
                            local child2_info = shortest_paths[child2]
                            local child2_distance = child2_info.full_distance
                            if child2_distance < child_distance then
                                child_pos = child_pos2
                                child = child2
                                child_info = child2_info
                                child_distance = child2_distance
                            end
                        end
                        if child_distance < parent_distance then
                            heap[pos] = child
                            child_info.index = pos
                            pos = child_pos
                        else
                            break
                        end
                    end
                    heap[pos] = parent
                    parent_info.index = pos
                end
                local vertex_info = shortest_paths[vertex]
                vertex_info.index = nil
                distance = vertex_info.full_distance
                return vertex
            end
        end,
        shortest_paths
    end

    local vertex, dijkstra, shortest_paths = _starting_vertex, create_dijkstra(_starting_vertex)

    while vertex and vertex ~= destination_vertex do
        -- send information about all adjacent vertexes of "vertex"
        for adjacent_vertex, edge_length in pairs(edges[vertex]) do
            dijkstra(adjacent_vertex, edge_length)
        end
        vertex = dijkstra()  -- now dijkstra is asking you about the neighborhood of another vertex
    end

    if vertex then
        local full_distance = shortest_paths[vertex].full_distance
        local path = vertex
        while vertex do
            vertex = shortest_paths[vertex].previous_vertex
            if vertex then
                path = vertex .. " " .. path
            end
        end
        --print(full_distance, path)
        return full_distance
    else
        --print "Path not found"
    end
end

print("part I:", p1(starting_vertex))

local minLength = 2147483647
for i = 1, #aIndex do
    local len = p1(aIndex[i])
    if len ~= nil then -- nil if path not found
        --print(aIndex[i], len)
        if len < minLength then
            minLength = len
        end
    end

end
print("part II:", minLength)


--printMatrix(matrix)
