-- Lua filter to handle small and smaller slide classes
-- For beamer: wraps content in appropriate font size commands
-- For revealjs: CSS handles the styling via classes

function Header(el)
  -- Handle headers with .small or .smaller class for beamer
  if el.level == 2 then
    if FORMAT:match("beamer") or FORMAT:match("latex") then
      if el.classes:includes("smaller") then
        -- Add frame option for smaller font
        el.attributes["shrink"] = ""
        el.attributes["fragile"] = ""
        -- Remove our custom class as beamer doesn't understand it
        local new_classes = {}
        for _, c in ipairs(el.classes) do
          if c ~= "smaller" then
            table.insert(new_classes, c)
          end
        end
        el.classes = new_classes
        -- Add a special attribute to signal the Div filter
        el.attributes["den-fontsize"] = "smaller"
      elseif el.classes:includes("small") then
        el.attributes["shrink"] = ""
        -- Remove our custom class
        local new_classes = {}
        for _, c in ipairs(el.classes) do
          if c ~= "small" then
            table.insert(new_classes, c)
          end
        end
        el.classes = new_classes
        el.attributes["den-fontsize"] = "small"
      end
    end
    -- For revealjs, keep the classes as-is (CSS will handle them)
  end
  return el
end

function Div(el)
  -- For beamer, check if this is a slide div that needs font size adjustment
  if FORMAT:match("beamer") or FORMAT:match("latex") then
    -- Check if any child header has our font size marker
    local fontsize = nil
    for _, block in ipairs(el.content) do
      if block.t == "Header" and block.attributes then
        fontsize = block.attributes["den-fontsize"]
        if fontsize then
          break
        end
      end
    end
    
    if fontsize then
      -- Wrap the content after the header in font size commands
      local new_content = {}
      local found_header = false
      
      for i, block in ipairs(el.content) do
        if block.t == "Header" and block.level == 2 then
          found_header = true
          -- Remove the marker attribute
          block.attributes["den-fontsize"] = nil
          table.insert(new_content, block)
          
          -- Insert font size command after the header
          if fontsize == "smaller" then
            table.insert(new_content, pandoc.RawBlock("latex", "\\footnotesize"))
          elseif fontsize == "small" then
            table.insert(new_content, pandoc.RawBlock("latex", "\\small"))
          end
        else
          table.insert(new_content, block)
        end
      end
      
      el.content = new_content
    end
  end
  return el
end
