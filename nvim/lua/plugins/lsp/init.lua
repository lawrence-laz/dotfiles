-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

function LspRename()
    local curr_name = vim.fn.expand("<cword>")
    local value = vim.fn.input("Rename: ", curr_name)
    local lsp_params = vim.lsp.util.make_position_params()

    if not value or #value == 0 or curr_name == value then return end

    -- request lsp rename
    lsp_params.newName = value
    vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx, _)
        if not res then return end

        -- apply renames
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

        -- print renames
        local changed_files_count = 0
        local changed_instances_count = 0

        if (res.documentChanges) then
            for _, changed_file in pairs(res.documentChanges) do
                changed_files_count = changed_files_count + 1
                changed_instances_count = changed_instances_count + #changed_file.edits
            end
        elseif (res.changes) then
            for _, changed_file in pairs(res.changes) do
                changed_instances_count = changed_instances_count + #changed_file
                changed_files_count = changed_files_count + 1
            end
        end

        -- compose the right print message
        print(string.format("Renamed %s instance%s in %s file%s. %s",
            changed_instances_count,
            changed_instances_count == 1 and '' or 's',
            changed_files_count,
            changed_files_count == 1 and '' or 's',
            changed_files_count > 1 and "To save them run ':wa'" or ''
        ))
    end)
end

return {
    {
        "b0o/schemastore.nvim", -- JSON schemas
        lazy = false,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dev = false,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "b0o/schemastore.nvim",
            "Issafalcon/lsp-overloads.nvim",
        },
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
            },

            -- Global capabilities used in all servers.
            capabilities = {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true
                        }
                    }
                }
            },

            -- Automatically format on save.
            autoformat = false,

            -- A list of servers to set up.
            -- Defined by a table which is passed to lspconfig.server_name.setup(...) function.
            ---@type lspconfig.options
            servers = {
                bashls = {},
                -- gopls = {},
                svelte = {},
                zk = {
                    -- Zettelkasten for markdown.
                    -- https://github.com/mickael-menu/zk
                },
                jsonls = {
                    -- =================================================
                    -- To debug:
                    -- kill -USR1 `pgrep -f json-language-server`
                    -- chrome://inspect
                    -- =================================================
                    settings = {
                        json = {
                            validate = { enable = true },
                            keepLines = { enable = true },
                        },
                    },
                },
                cssls = {},
                lua_ls = {
                    on_init = function(client)
                        local path = client.workspace_folders[1].name
                        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                            client.config.settings = vim.tbl_deep_extend('force',
                                client.config.settings.Lua, {
                                    diagnostics = {
                                        -- Get the language server to recognize the `vim` global
                                        globals = {
                                            -- 'vim'
                                        },
                                    },
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                        version = 'LuaJIT'
                                    },
                                    -- Make the server aware of Neovim runtime files
                                    workspace = {
                                        --library = { vim.env.VIMRUNTIME }
                                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                        library = vim.api.nvim_get_runtime_file(
                                            "", true)
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                })

                            client.notify("workspace/didChangeConfiguration",
                                { settings = client.config.settings })
                        end
                        return true
                    end
                },
                html = {},
                zls = {
                    -- cmd = function(a, b, c)
                    -- 	P(a)
                    -- 	P(b)
                    -- 	P(c)
                    -- end,
                    -- cmd = { 'zls', '--config-path', 'zls.json' },
                    settings = {
                        -- Doesn't seem to work?
                        -- nvim "`zls --show-config-path`"
                        -- Make sure workspaces are set up correctly, for this to work
                        -- on the zls side.
                        enable_build_on_save = true,
                        enable_argument_placeholders = false,
                    },
                },
                tailwindcss = {
                    settings = {},
                },
                vtsls = {
                    settings = {},
                },
                rust_analyzer = {
                    settings = {
                    },
                }
            },

            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                jsonls = function(_, opts)
                    opts.settings.json.schemas = require('schemastore').json.schemas()
                    require 'lspconfig'.jsonls.setup(opts)
                end,
                bashls = function(_, opts)
                    require 'lspconfig'.bashls.setup(opts)
                end,
                lua_ls = function(_, opts)
                    require 'lspconfig'.lua_ls.setup(opts)
                end,
                html = function(_, opts)
                    --Enable (broadcasting) snippet capability for completion
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport = true

                    require 'lspconfig'.html.setup {
                        capabilities = capabilities,
                    }
                end,
                svelte = function(_, opts)
                    require 'lspconfig'.svelte.setup(opts)
                end,
                zls = function(_, opts)
                    -- Update zls:
                    -- this contains 0.13 only, no dev builds as of 24-08-19
                    --[[
cd ~/bin && mv -f zls zls.bak && curl -O https://zigtools-releases.nyc3.digitaloceanspaces.com/zls/master/aarch64-macos/zls && chmod-exec zls
                    --]]
                    -- Zig: https://ziglang.org/download/
                    --[[ Linux
cd ~/zig && mv -f sdk sdk.bak && mkdir sdk && curl https://ziglang.org/download/index.json | jq '.master."aarch64-linux".tarball' | xargs -I{} curl -o "./zig-sdk.tar.xz" "{}" && tar -xvf zig-sdk.tar.xz -C ./sdk && cd sdk && mvout $(find . -name zig-*)
                    --]]
                    --[[ MacOS
cd ~ && mv -f zig-sdk zig-sdk.bak && mkdir zig-sdk && curl https://ziglang.org/download/index.json | jq '.master."aarch64-macos".tarball' | xargs -I{} curl -o "./zig-sdk.tar.xz" "{}" && tar -xvf zig-sdk.tar.xz -C ./zig-sdk && cd zig-sdk && mvout $(find . -name zig-*)
                    --]]
                    -- Build form source:lsp
                    opts.capabilities.textDocument.publishDiagnostics = {
                        dataSupport = true,
                        relatedInformation = true,
                        tagSupport = {
                            valueSet = { 1, 2 }
                        }
                    }

                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0

                    opts.root_dir =
                        require 'lspconfig.util'.root_pattern("build.zig", "zls.json", ".git");
                    require 'lspconfig'.zls.setup(opts)
                    -- "zig.zls.enableBuildOnSave": false
                end,

                -- gopls = function(_, ops)
                --     require 'lspconfig'.gopls.setup {}
                -- end,
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        config = function(_, opts)
            require("neodev").setup({
                override = function(root_dir, library)
                    library.enabled = true
                    library.plugins = true
                end,
                lspconfig = true,
                pathStrict = true,
            })
            require 'utils'.on_lsp_attach(function(client, buffer)
                if client.server_capabilities.signatureHelpProvider then
                    require('lsp-overloads').setup(client, {
                        ui = {
                            border = "none",
                            floating_window_above_cur_line = true,
                        }
                    })
                end

                if client.config
                    and client.config.capabilities
                    and client.config.capabilities.documentFormattingProvider == false
                then
                    return
                end

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
                        buffer = buffer,
                        callback = function()
                            vim.lsp.buf.format { async = false }
                        end,
                    })
                end
            end)

            -- Signs
            -- https://www.nerdfonts.com/cheat-sheet
            local signs = {
                Error = '',
                Warn = '',
                Info = '',
                Hint = '',
            }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                signs = true,
                update_in_insert = false,
                underline = false,
                severity_sort = true,
                virtual_text = {
                    source = true,
                },
            })
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local servers = opts.servers
            local function setup(server)
                local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
                local server_opts = vim.tbl_deep_extend("force",
                    {
                        capabilities = vim.lsp.protocol.make_client_capabilities(),
                    },
                    {
                        capabilities = vim.deepcopy(capabilities),
                    },
                    {
                        capabilities = cmp_capabilities
                    },
                    servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available thourgh mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server")
                    .lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    -- if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                    setup(server)
                    -- else
                    --     ensure_installed[#ensure_installed + 1] = server
                    -- end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed })
                mlsp.setup_handlers({ setup })
            end
        end,
    },

    -- cmdline tools and lsp servers
    {
        -- Mason installs in: ~/.local/share/nvim/mason
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                -- "flake8",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
