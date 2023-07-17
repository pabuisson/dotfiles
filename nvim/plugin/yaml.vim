function! SearchYamlKey(nodes, search_key)
  for node in a:nodes
    echo node
    if node.key ==# a:search_key
      return node
    endif
  endfor

  return ''
endfunction

function! ParseYamlContent(yaml_content)
  let yaml_data = []

  let current_parents = []
  let former_indent_level = 0
  let line_index = 0

  for line in a:yaml_content
    let line_index = line_index + 1

    let trimmed_line = substitute(line, '^ *', '', '')
    " TODO: don't hardcode the indentation width anymore
    let indent_level = (len(line) - len(trimmed_line)) / 2
    let key = substitute(trimmed_line, ':.*$', '', '')

    " If we're reducing the indentation, keep only the parents we need to
    " keep, based on the indentation level
    if indent_level < former_indent_level
      let new_current_parents = []
      let parents_to_keep = indent_level

      let i = 0
      while len(new_current_parents) < parents_to_keep
        let parent = current_parents[i]
        call add(new_current_parents, parent)
        let i += 1
      endwhile

      let current_parents = new_current_parents
    endif

    if trimmed_line =~# '^\S\+:\S*$'  " Dictionary key
      call add(current_parents, key)
    else  " Scalar value
      let current_node = ''
      for node in current_parents
        if len(current_node) == 0
          let current_node = node
        else
          let current_node = current_node . '.' . node
        endif
      endfor

      call add(yaml_data, { 'key': current_node . '.' . key, 'line': line_index })
    endif

    let former_indent_level = indent_level
  endfor

  return yaml_data
endfunction

function! FindYamlKeyLocation(search_key)
  let yaml_files = glob('**/*.yml', 1, 1)

  for yaml_file in yaml_files
    let lines = readfile(yaml_file)
    let yaml_data = ParseYamlContent(lines)

    let result = SearchYamlKey(yaml_data, a:search_key)
    if !empty(result)
      echo result
      execute 'edit +' . result.line . ' ' . yaml_file
      return
    endif
  endfor
endfunction
