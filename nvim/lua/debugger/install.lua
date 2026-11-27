return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "igorlfs/nvim-dap-view",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dap_view = require("dap-view")

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7",
      }

      local mi_debugger = vim.fn.exepath("gdb")
      if mi_debugger == "" then
        mi_debugger = vim.fn.has("win32") == 1 and "gdb" or "/usr/bin/gdb"
      end

      local function pick_executable(callback)
        local rootdir = vim.call("asyncrun#get_root", "%")
        local build_dir = rootdir ~= "" and (rootdir .. "/build") or (vim.fn.getcwd() .. "/build")

        if vim.fn.isdirectory(build_dir) == 0 then
          vim.ui.input({ prompt = "Path to executable: ", default = "", completion = "file" }, function(input)
            if input and input ~= "" then
              callback(input)
            end
          end)
          return
        end

        local executables = {}
        local scan = {}
        if vim.fn.executable("fd") == 1 then
          scan = vim.fn.systemlist({ "fd", "-tx", ".", build_dir })
        end
        for _, file in ipairs(scan) do
          if file ~= "" then
            table.insert(executables, file)
          end
        end

        if #executables == 0 then
          vim.ui.input({
            prompt = "Path to executable: ",
            default = build_dir .. "/",
            completion = "file",
          }, function(input)
            if input and input ~= "" then
              callback(input)
            end
          end)
          return
        end

        -- 由 snacks picker 接管
        vim.ui.select(executables, { prompt = "Select Executable" }, function(choice)
          if choice then
            callback(choice)
          end
        end)
      end

      dap.configurations.cpp = {
        {
          name = "Launch executable",
          type = "cppdbg",
          request = "launch",
          program = function()
            local co = coroutine.running()
            pick_executable(function(path)
              coroutine.resume(co, path)
            end)
            return coroutine.yield()
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          MIMode = "gdb",
          miDebuggerPath = mi_debugger,
          setupCommands = {
            {
              description = "Enable pretty-printing for gdb",
              text = "-enable-pretty-printing",
              ignoreFailures = true,
            },
          },
        },
        {
          name = "Launch with args",
          type = "cppdbg",
          request = "launch",
          program = function()
            local co = coroutine.running()
            pick_executable(function(path)
              coroutine.resume(co, path)
            end)
            return coroutine.yield()
          end,
          args = function()
            return vim.split(vim.fn.input("Arguments: "), " ")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
          MIMode = "gdb",
          miDebuggerPath = mi_debugger,
          setupCommands = {
            {
              description = "Enable pretty-printing for gdb",
              text = "-enable-pretty-printing",
              ignoreFailures = true,
            },
          },
        },
        {
          name = "Attach to gdbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "gdb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = mi_debugger,
          cwd = "${workspaceFolder}",
          program = function()
            local co = coroutine.running()
            pick_executable(function(path)
              coroutine.resume(co, path)
            end)
            return coroutine.yield()
          end,
          setupCommands = {
            {
              description = "Enable pretty-printing for gdb",
              text = "-enable-pretty-printing",
              ignoreFailures = true,
            },
          },
        },
      }
      dap.configurations.c = dap.configurations.cpp

      require("mason-nvim-dap").setup({
        ensure_installed = { "cpptools" },
        automatic_installation = true,
      })

      dap_view.setup({
        windows = {
          terminal = { hide = { "stack_trace" } },
        },
      })

      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dap-view"] = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated["dap-view"] = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited["dap-view"] = function()
        dap_view.close()
      end
      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
      vim.keymap.set("n", "<F10>", dap.step_over)
      vim.keymap.set("n", "<F11>", dap.step_into)
      vim.keymap.set("n", "<F12>", dap.step_out)
    end,
  },
}
