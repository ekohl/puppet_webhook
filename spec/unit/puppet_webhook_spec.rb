require 'spec_helper'

describe PuppetWebhook do
  it '/heartbeat returns 200 ok and success message' do
    get '/heartbeat'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('{"status":"success","message":"running"}')
  end

  it '/echo returns parsed payload' do
    header 'Content-Type', 'application/json'
    header 'X-GitHub-Event', 'push'
    post '/echo', read_fixture('github/update.json')
    expect(last_response).to be_ok
    expect(last_response.body).to eq('{"branch":"feature_branch","deleted":false,"module_name":"r10k","repo_name":"puppet-r10k","repo_user":"moduletux"}')
  end
end
