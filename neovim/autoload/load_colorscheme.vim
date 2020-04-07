" Custom function
" Load colorscheme if it exists, catch and ignore error if scheme doesn't exist
function load_colorscheme#Load()
  try
    colorscheme solarized
    set background=dark
  catch /^Vim\%((\a\+)\)\=:E185/
      " deal with it
  endtry
endfunction
