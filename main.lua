-- Funktion zum Erstellen einer leeren Gittermatrix
function createEmptyGrid(rows, columns)
  local grid = {}
  for i = 1, rows do
    grid[i] = {}
    for j = 1, columns do
      grid[i][j] = 0
    end
  end
  return grid
end

-- Funktion zum Initialisieren des Gittermusters
function initializeGrid(grid, pattern)
  local patternRows = #pattern
  local patternColumns = #pattern[1]
  local offsetRows = math.floor((#grid - patternRows) / 2)
  local offsetColumns = math.floor((#grid[1] - patternColumns) / 2)

  for i = 1, patternRows do
    for j = 1, patternColumns do
      grid[i + offsetRows][j + offsetColumns] = pattern[i][j]
    end
  end
end

-- Funktion zum Drucken des Gitters
function printGrid(grid)
  for i = 1, #grid do
    for j = 1, #grid[1] do
      io.write(grid[i][j] == 1 and "#" or " ")
    end
    io.write("\n")
  end
end

-- Funktion zum Berechnen des nächsten Schritts des Game of Life
function getNextGeneration(grid)
  local newGrid = createEmptyGrid(#grid, #grid[1])

  for i = 1, #grid do
    for j = 1, #grid[1] do
      local aliveNeighbors = 0

      -- Zähle lebende Nachbarn
      for x = -1, 1 do
        for y = -1, 1 do
          if not (x == 0 and y == 0) and grid[i + x] and grid[i + x][j + y] == 1 then
            aliveNeighbors = aliveNeighbors + 1
          end
        end
      end

      -- Wende die Regeln des Game of Life an
      if grid[i][j] == 1 then
        if aliveNeighbors < 2 or aliveNeighbors > 3 then
          newGrid[i][j] = 0
        else
          newGrid[i][j] = 1
        end
      elseif grid[i][j] == 0 and aliveNeighbors == 3 then
        newGrid[i][j] = 1
      end
    end
  end

  return newGrid
end

-- Hauptprogramm
function main()
  -- Größe des Gitters
  local rows = 20
  local columns = 40

  -- Beispiel-Muster
  local pattern = {
    {0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0}
  }

  -- Erstelle und initialisiere das Gitter
  local grid = createEmptyGrid(rows, columns)
  initializeGrid(grid, pattern)

  -- Führe 100 Generationen aus und gib das Gitter aus
  for generation = 1, 100 do
    print("Generation " .. generation .. ":\n")
    printGrid(grid)
    grid = getNextGeneration(grid)

    -- Warte 1 Sekunde zwischen den Generationen (optional)
    os.execute("sleep 1")

    -- Lösche den Konsolenbildschirm (optional, funktioniert möglicherweise nicht auf allen Systemen)
    os.execute("clear")
  end
end

-- Füge die fehlenden Funktionen hier ein

-- Rufe das Hauptprogramm auf
main()
