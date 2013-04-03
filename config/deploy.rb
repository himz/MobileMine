BestBay::delayed_job do
  desc "Start delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path};
    script/delayed_job start -- #{stage}"
  end

  desc "Stop delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path};
    script/delayed_job stop -- #{stage}"
  end

  desc "Restart delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path};
    script/delayed_job restart -- #{stage}"
  end
end
after "deploy:start", "delayed_job:start"
after "deploy:stop", "delayed_job:stop"
after "deploy:restart", "delayed_job:restart"