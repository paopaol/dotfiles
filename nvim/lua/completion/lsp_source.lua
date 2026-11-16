-- 包装 blink 的 lsp 源：cmake 里丢掉 neocmake 返回的文件/目录项，
-- 它们与 blink 的 path 源给出同一批候选；其他 filetype 原样透传
local lsp = require("blink.cmp.sources.lsp")

local M = {}

function M.new(opts)
  local self = setmetatable({}, { __index = M })
  self.inner = lsp.new(opts)
  return self
end

function M:get_trigger_characters()
  return self.inner:get_trigger_characters()
end

function M:get_completions(context, callback)
  local cancel = self.inner:get_completions(context, function(response)
    if response and response.items and vim.bo[context.bufnr].filetype == "cmake" then
      local items = {}
      for _, item in ipairs(response.items) do
        -- 17 = File, 19 = Folder
        if item.kind ~= 17 and item.kind ~= 19 then
          items[#items + 1] = item
        end
      end
      response.items = items
    end
    callback(response)
  end)
  return cancel
end

function M:resolve(item, callback)
  return self.inner:resolve(item, callback)
end

return M
