return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  -- Markdown preview
  {
    "lukas-reineke/headlines.nvim",
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = { headline_highlights = {} }
        for i = 1, 6 do
          table.insert(opts[ft].headline_highlights, "Headline" .. i)
        end
      end
      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
  {
    "previm/previm",
    config = function()
      -- define global for open markdown preview, let g:previm_open_cmd = 'open -a Safari'
      vim.g.previm_open_cmd = "open -a Arc"
    end,
    ft = { "markdown" },
    keys = {
      -- add <leader>m to open markdown preview
      {
        "<leader>mp",
        "<cmd>PrevimOpen<cr>",
        desc = "Markdown preview",
      },
    },
  },
}
