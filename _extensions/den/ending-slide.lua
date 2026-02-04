-- Lua filter to handle .ending-slide class for both revealjs and beamer

function Header(el)
  -- Check if this header has the "ending-slide" class
  if el.classes:includes("ending-slide") then
    local format = quarto.doc.is_format("revealjs") and "revealjs" 
                or quarto.doc.is_format("beamer") and "beamer" 
                or nil
    
    if format == "revealjs" then
      -- For revealjs: add data-background-image attribute
      el.attributes["data-background-image"] = "end.png"
      el.attributes["data-background-size"] = "cover"
      return el
      
    elseif format == "beamer" then
      -- For beamer: replace with raw LaTeX that creates the ending slide
      return pandoc.RawBlock("latex", [[
\begin{frame}[plain]
  \begin{tikzpicture}[remember picture, overlay]
    \node[anchor=center] at (current page.center) {
      \includegraphics[width=\paperwidth, height=\paperheight]{end.png}
    };
  \end{tikzpicture}
\end{frame}
]])
    end
  end
  
  return el
end
