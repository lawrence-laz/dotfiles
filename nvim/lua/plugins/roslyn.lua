-- Run :CSInstallRoslyn
-- Ensure '~/.local/share/nvim/roslyn' is in PATH
--
--
--
-- temp bugfix: https://github.com/jmederosalvarado/roslyn.nvim/issues/18#issuecomment-1864605065
-- https://github.com/jmederosalvarado/roslyn.nvim/release
-- rm from dir
-- tar zxf /path/to/roslyn.tar.gz -C ~/.local/share/nvim/roslyn
--
--
return {
    "jmederosalvarado/roslyn.nvim",
    config = function()
        require("roslyn").setup({
            -- dotnet_cmd = "dotnet",     -- this is the default
            -- roslyn_version = "4.8.0-3.23475.7", -- this is the default
            on_attach = function(client, bufnr)
                if client.supports_method(require('vim.lsp.protocol').Methods.textDocument_diagnostic) then
                    vim.api.nvim_create_autocmd('BufEnter', {
                        buffer = bufnr,
                        callback = function()
                            require('vim.lsp.util')._refresh(
                                require('vim.lsp.protocol').Methods
                                .textDocument_diagnostic,
                                { only_visible = true, client_id = client.id })
                        end,
                    })
                end
            end,
            -- capabilities = require("cmp_nvim_lsp")
            --     .default_capabilities(vim.lsp.protocol
            --         .make_client_capabilities())

            -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),

            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require 'cmp_nvim_lsp'.default_capabilities(),
                {
                    textDocument = {
                        completion = {
                            completionItem = {
                                snippetSupport = true
                            }
                        }
                    }
                }
            )

            -- capabilities =
            --     vim.tbl_deep_extend("force",
            --         vim.lsp.protocol.make_client_capabilities(),
            --         require("cmp_nvim_lsp").default_capabilities(),
            --         {
            --             textDocument = {
            --                 completion = {
            --                     completionItem = {
            --                         snippetSupport = true
            --                     }
            --                 }
            --             }
            --         }
            --     )
            -- capabilities = vim.tbl_deep_extend(
            --     "force",
            --     vim.lsp.protocol.make_client_capabilities(),
            --     require('cmp_nvim_lsp').default_capabilities()
            -- )

        })
    end
}
