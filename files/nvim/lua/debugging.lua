return {
    {
        "mfussenegger/nvim-dap", -- core debug adapter protocol client
        keys = {
            { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<Leader>dc", function() require("dap").continue() end, desc = "Debug: continue/start" },
            { "<Leader>do", function() require("dap").step_over() end, desc = "Debug: step over" },
            { "<Leader>di", function() require("dap").step_into() end, desc = "Debug: step into" },
            { "<Leader>dO", function() require("dap").step_out() end, desc = "Debug: step out" },
            { "<Leader>dt", function() require("dap").terminate() end, desc = "Debug: terminate" },
            { "<Leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
        },
    },
    {
        "mfussenegger/nvim-dap-python", -- configures the debugpy adapter for nvim-dap
        ft = "python",
        config = function()
            local mason_registry = require("mason-registry")
            local debugpy_path = mason_registry.get_package("debugpy"):get_install_path()
            require("dap-python").setup(debugpy_path .. "/venv/bin/python")
        end,
    },
    {
        "rcarriga/nvim-dap-ui", -- breakpoints/scopes/stacks/repl panels
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim", -- bridges mason and nvim-dap; auto-installs debug adapters
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        opts = { ensure_installed = { "debugpy" }, automatic_installation = true },
    },
}
