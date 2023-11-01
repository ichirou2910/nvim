return {
    local_client_config = {
        callback = function(port, workspace_config)
            local cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
            vim.fn.jobstart(cmd, {
                detach = true,
                on_exit = function(job_id, exit_code, event_type)
                    -- This function will be called when the job exits
                    print("Job", job_id, "exited with code", exit_code, "Event type:", event_type)
                end,
            })
        end,
    },
}
