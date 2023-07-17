local function searchYamlKey(nodes, searchKey)
  for _, node in ipairs(nodes) do
    if node.key == searchKey then
      return node
    end
  end

  return ''
end

local function parseYamlContent(yamlContent)
  local yamlData = {}

  local currentParents = {}
  local formerIndentLevel = 0
  local lineIndex = 0

  for _, line in ipairs(yamlContent) do
    lineIndex = lineIndex + 1

    local trimmedLine = line:gsub("^%s*", "")
    local indentLevel = math.floor(#line - #trimmedLine) / 2
    local key = trimmedLine:gsub(":.*$", "")
    print(vim.inspect(current_parents))
    print(key)

    if indentLevel < formerIndentLevel then
      local newCurrentParents = {}
      local parentsToKeep = indentLevel

      for i = 1, parentsToKeep do
        table.insert(newCurrentParents, currentParents[i])
      end

      currentParents = newCurrentParents
    end

    if trimmedLine:match("^.*:$") then -- Dictionary key
      table.insert(currentParents, key)
    else -- Scalar value
      local currentPath = table.concat(currentParents, ".")
      table.insert(yamlData, { key = currentPath .. "." .. key, line = lineIndex })
    end

    formerIndentLevel = indentLevel
  end

  return yamlData
end

function findYamlKeyLocationLua(searchKey)
  local yamlFiles = vim.fn.glob('**/*.yml', true, true)

  for _, yamlFile in ipairs(yamlFiles) do
    local lines = vim.fn.readfile(yamlFile)
    local yamlData = parseYamlContent(lines)

    print(vim.inspect(yamlData))
    local result = searchYamlKey(yamlData, searchKey)
    if result ~= '' then
      vim.cmd('edit +' .. result.line .. ' ' .. yamlFile)
      return
    end
  end
end
