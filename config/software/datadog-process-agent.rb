name "datadog-process-agent"
always_build true
require "./lib/ostools.rb"

process_agent_branch = ENV['PROCESS_AGENT_BRANCH']
if process_agent_branch.nil? || process_agent_branch.empty?
    process_agent_branch = "master"
end
trace_agent_add_build_vars = true
if ENV.has_key?('TRACE_AGENT_ADD_BUILD_VARS') && ENV['TRACE_AGENT_ADD_BUILD_VARS'] == 'false'
  trace_agent_add_build_vars = false
end
default_version process_agent_branch

build do
  if windows?
    binary = "process-agent-windows-#{version}.exe"
    target_binary = "process-agent.exe"
    url = "https://s3.amazonaws.com/datad0g-process-agent/#{binary}"
    curl_command = "powershell -Command wget -OutFile #{binary} #{url}"
    command curl_command
    command "mv #{binary} #{Omnibus::Config.source_dir()}/datadog-agent/dd-agent/dist/#{target_binary}"
  else
=begin
    binary = "process-agent-amd64-#{version}"
    target_binary = "process-agent"
    url = "https://s3.amazonaws.com/datad0g-process-agent/#{binary}"
    curl_command = "curl -f #{url} -o #{binary}"
    command curl_command
    command "chmod +x #{binary}"
    command "mv #{binary} #{install_dir}/bin/#{target_binary}"
=end
    trace_agent_bin = "trace-agent"
    godir = "/usr/local/go"
    gobin = "#{godir}/go/bin/go"
    gopath = "#{Omnibus::Config.cache_dir}/src/#{name}"

    agent_cache_dir = "#{gopath}/src/github.com/DataDog/datadog-agent"

    env = {
      "GOPATH" => gopath,
      "GOROOT" => "#{godir}/go",
      "PATH" => "#{gopath}/bin:#{godir}/go/bin:#{ENV["PATH"]}",
      "TRACE_AGENT_ADD_BUILD_VARS" => trace_agent_add_build_vars.to_s(),
    }
    command "rake deps", :env => env, :cwd => "#{gopath}/src/github.com/DataDog/datadog-process-agent"
    command "rake install", :env => env, :cwd => "#{gopath}/src/github.com/DataDog/datadog-process-agent"
  end
end
