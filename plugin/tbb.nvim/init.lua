local M = {}

local state = {
  tasks_file_name = "tasks.json",
  tasks = nil,
  terminal = {
    buf = nil,
    win = nil,
  },
}

-- Find the root directory containing tasks.json
local function find_tasks_json()
  local cwd = vim.fn.getcwd()
  local file = cwd .. "/" .. state.tasks_file_name
  if vim.fn.filereadable(file) == 1 then
    return file
  end
  vim.notify(state.tasks_file_name .. " not found!", vim.log.levels.ERROR)
  return nil
end

-- Load tasks asynchronously
local function load_tasks_async(callback)
  local file = find_tasks_json()
  if not file then
    vim.notify(state.tasks_file_name .. " not found!", vim.log.levels.ERROR)
    return
  end

  vim.loop.fs_open(file, "r", 438, function(open_err, fd)
    if open_err or not fd then
      vim.schedule(function()
        vim.notify(
          "Failed to open " .. state.tasks_file_name .. "! Error: " .. (open_err or "Unkown error"),
          vim.log.levels.ERROR
        )
      end)
      if callback then
        return callback(nil)
      end
      return
    end

    vim.loop.fs_stat(file, function(stat_err, stat)
      if stat_err or not stat then
        vim.loop.fs_close(fd)
        vim.schedule(function()
          vim.notify(
            "Failed to get info from " .. state.tasks_file_name .. "! Error: " .. (stat_err or "Uknown error"),
            vim.log.levels.ERROR
          )
        end)
        if callback then
          return callback(nil)
        end
        return
      end

      vim.loop.fs_read(fd, stat.size, 0, function(read_err, data)
        vim.loop.fs_close(fd)
        if read_err or not data then
          vim.schedule(function()
            vim.notify(
              "Failed to read " .. state.tasks_file_name .. "! Error: " .. (read_err or "Uknown error"),
              vim.log.levels.ERROR
            )
          end)
          if callback then
            return callback(nil)
          end
          return
        end

        local ok, tasks = pcall(vim.json.decode, data)
        if not ok then
          vim.schedule(function()
            vim.notify("Failed to parse tasks.json with data: " .. vim.inspect(data), vim.log.levels.ERROR)
          end)
          if callback then
            return callback(nil)
          end
          return
        end

        state.tasks = tasks
        if callback then
          callback(tasks)
        end
        return
      end)
    end)
  end)
end

-- Reload tasks manually
function M.reload_tasks()
  load_tasks_async(function()
    vim.notify(state.tasks_file_name .. " reloaded!", vim.log.levels.INFO)
  end)
end

-- Create or reuse a popup terminal
local function open_terminal()
  if not state.terminal.buf or not vim.api.nvim_buf_is_valid(state.terminal.buf) then
    state.terminal.buf = vim.api.nvim_create_buf(false, true)
  end
  if state.terminal.win and vim.api.nvim_win_is_valid(state.terminal.win) then
    return
  end
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local opts = {
    relative = "editor",
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  }
  state.terminal.win = vim.api.nvim_open_win(state.terminal.buf, true, opts)
  vim.fn.termopen("cmd", {
    on_exit = function()
      state.terminal.buf = nil
    end,
  })
end

-- Run a selected task in the terminal
function M.run_task()
  if not state.tasks then
    load_tasks_async(function()
      M.run_task()
    end)
    return
  end

  if not state.tasks then
    vim.schedule(function()
      vim.notify("No tasks found", vim.log.levels.WARN)
    end)
    return
  end

  local tasks_names = {}
  for name, _ in pairs(state.tasks) do
    table.insert(tasks_names, name)
  end

  vim.schedule(function()
    vim.ui.select(tasks_names, { prompt = "Select task" }, function(task)
      if not state.tasks[task] then
        return
      end
      open_terminal()
      local cmd = table.concat(state.tasks[task].command, " ")
      vim.fn.chansend(vim.api.nvim_open_term(state.terminal.buf, {}), cmd)
    end)
  end)
end

-- Toggle terminal visibility
function M.toggle_terminal()
  if state.terminal.win and vim.api.nvim_win_is_valid(state.terminal.win) then
    vim.api.nvim_win_close(state.terminal.win, true)
    state.terminal.win = nil
  else
    open_terminal()
  end
end

--vim.api.nvim_create_user_command("TBBTaskRun", M.run_task, {})
vim.api.nvim_create_user_command("TBBTerminal", M.toggle_terminal, {})
--vim.api.nvim_create_user_command("TBBReload", M.reload_tasks, {})

return M
