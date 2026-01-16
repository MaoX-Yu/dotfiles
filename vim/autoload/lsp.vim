vim9script

export def SetupLspOptions()
    var lspOpts = {
        diagVirtualTextAlign: 'after',
        popupBorder: true,
        popupBorderCompletion: false,
        semanticHighlight: true,
        showDiagWithVirtualText: true,
        showInlayHints: true,
    }

    g:LspOptionsSet(lspOpts)
enddef

export def SetupLspServers()
    var lspServers = [{
        name: 'rust-analyzer',
        filetype: ['rust'],
        path: 'rust-analyzer',
        args: [],
        syncInit: true,
        initializationOptions: {
            inlayHints: {
                typeHints: {
                    enable: true,
                },
                parameterHints: {
                    enable: true,
                },
            },
        },
    }]

    g:LspAddServer(lspServers)
enddef

export def SetupLspKeymaps()
    nnoremap gd <Cmd>LspGotoDefinition<CR>
    nnoremap gD <Cmd>LspGotoDeclaration<CR>
    nnoremap gr <Cmd>LspPeekReferences<CR>
    nnoremap gI <Cmd>LspGotoImpl<CR>
    nnoremap gy <Cmd>LspGotoTypeDef<CR>
    nnoremap K <Cmd>LspHover<CR>
    nnoremap <Leader>a <Cmd>LspCodeAction<CR>
    nnoremap <Leader>r <Cmd>LspRename<CR>
    nnoremap [d <Cmd>LspDiag prevWrap<CR>
    nnoremap ]d <Cmd>LspDiag nextWrap<CR>
    nnoremap [D <Cmd>LspDiag first<CR>
    nnoremap ]D <Cmd>LspDiag last<CR>
    nnoremap <Leader>cd <Cmd>LspDiag current<CR>
enddef
