{ pkgs }:
with pkgs.vimPlugins; [
    # editor
    luasnip
    lspkind-nvim
    cmp-nvim-lsp
    nvim-cmp
    cmp_luasnip
    nvim-lspconfig
    nvim-treesitter.withAllGrammars

    # pickers
    fzf-lua
    
    # icons
    nvim-web-devicons

    # ui
    neovim-ayu
    lualine-nvim
]
