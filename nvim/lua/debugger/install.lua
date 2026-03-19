return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "igorlfs/nvim-dap-view",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local dap = require("dap")
    local dap_view = require("dap-view")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- 设置 cppdbg adapter
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "OpenDebugAD7",
    }

    -- 使用 Telescope 选择可执行文件
    local function pick_executable(callback)
      local rootdir = vim.call("asyncrun#get_root", "%")
      local build_dir = rootdir ~= "" and (rootdir .. "/build") or (vim.fn.getcwd() .. "/build")

      -- 检查 build 目录是否存在
      if vim.fn.isdirectory(build_dir) == 0 then
        vim.ui.input({ prompt = "Path to executable: ", default = "", completion = "file" }, function(input)
          if input and input ~= "" then
            callback(input)
          end
        end)
        return
      end

      -- 收集可执行文件
      local executables = {}
      local scan = vim.fn.systemlist(string.format("fd -tx . '%s' 2>/dev/null", build_dir))
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

      -- 使用 Telescope 选择
      pickers
        .new({}, {
          prompt_title = "Select Executable",
          finder = finders.new_table({
       	    results = executables,
          }),
          sorter = conf.file_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
       	    actions.select_default:replace(function()
        		    local selection = action_state.get_selected_entry()
        		    actions.close(prompt_bufnr)
        		    callback(selection[1])
       	    end)
       	    return true
          end,
        })
        :find()
    end

    -- 设置 C/C++ 调试配置
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
        miDebuggerPath = "/usr/bin/gdb",
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
        miDebuggerPath = "/usr/bin/gdb",
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
        miDebuggerPath = "/usr/bin/gdb",
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
    -- C 使用相同配置
    dap.configurations.c = dap.configurations.cpp

    -- mason-nvim-dap 设置 (用于安装 cpptools)
    require("mason-nvim-dap").setup({
      ensure_installed = { "cpptools" },
      automatic_installation = true,
    })

    -- dap-view 设置
    dap_view.setup({
      windows = {
        terminal = { hide = { "stack_trace" } },
      },
    })

    -- 虚拟文本显示变量值
    require("nvim-dap-virtual-text").setup()

    -- 调试开始时自动打开 dap-view
    dap.listeners.after.event_initialized["dap-view"] = function()
      dap_view.open()
    end
    dap.listeners.before.event_terminated["dap-view"] = function()
      dap_view.close()
    end
    dap.listeners.before.event_exited["dap-view"] = function()
      dap_view.close()
    end

    -- 快捷键
    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-view-term",
      callback = function()
        vim.keymap.set("n", "<A-j>", "<C-W>j", { buffer = true, desc = "down win" })
        vim.keymap.set("n", "<A-k>", "<C-W>k", { buffer = true, desc = "up win" })
        vim.keymap.set("n", "<A-h>", "<C-W>h", { buffer = true, desc = "right win" })
        vim.keymap.set("n", "<A-l>", "<C-W>l", { buffer = true, desc = "left win" })
        vim.keymap.set("n", "q", "<cmd>DapTerminate<cr>", { buffer = true, desc = "left win" })
      end,
    })
  end,
}

