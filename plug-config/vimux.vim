function! VimuxCreateNewPane()
  " Creates new Tmux pane
  let splitExitCode = system("tmux split-window")
  " Set the proper index
  let g:VimuxRunnerIndex = s:VimuxTmuxIndex()
  call s:VimuxTmux("last-"._VimuxRunnerType())
endfunction

function! VimuxSetPane()
   "g:VimuxRunnerIndex
   !tmux display-panes
   let g:VimuxRunnerIndex = nr2char(getchar())
endfunction

let g:VimuxCloseOnExit = 1
