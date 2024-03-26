local map = vim.keymap.set

require("fzf-lua").setup({'telescope'})
map("n", "<leader>ff", "<cmd> FzfLua files <cr>", { desc = "Find files" })


-- return {
--    "ibhagwan/fzf-lua",
--    -- optional for icon support
--    dependencies = {"nvim-tree/nvim-web-devicons"},
--    config = function()
--        -- calling `setup` is optional for customization
--    end,
 --   keys = {{
   --     "<leader>ff",
     --   function()
       --     require('fzf-lua').files({
         --       cwd_prompt = false,
           --     prompt = "> ",
             --   fzf_opts = {
               --   ["--exact"] = true,
              --  },
               -- winopts = {
                --  preview = {
                  --  layout = "vertical",
                   -- vertical = 'up:65%',
                 -- },
               -- },
           -- })
        --end,
        --desc = "Find files"
    --}, {
      --  "<leader>fw",
        --function()
          --  require('fzf-lua').live_grep({
            
            --    cwd_prompt = false,
              --  prompt = "> ",
                --fzf_opts = {
                 -- ["--exact"] = true,
                --},
                --winopts = {
                  --preview = {
                   -- layout = "vertical",
                   -- vertical = 'up:65%',
                  --},
                --},
            --})
        ---end
    --}, {
      --  "<leader>fb",
        --"<cmd> FzfLua buffers <cr>",
        --desc = "Find buffer"
    --}, {
    --    "<leader>fc",
     --   "<cmd> FzfLua commands <cr>",
      --  desc = "Pick command"
    --}}
--}
