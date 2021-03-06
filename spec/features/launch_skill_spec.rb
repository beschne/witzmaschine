# spec/features/launch_skill_spec.rb  
        
require_relative '../spec_helper'

describe 'Launch Skill' do
  
  def issue_launch_request
    request = load_sample_json('sample_launch_request.json')
    post '/', request
  end
  
  it 'should accept a valid Alexa launch request' do 
    issue_launch_request
    expect(last_response).to be_ok
  end
  
  it 'should ask for buns' do
    issue_launch_request  
    expect(last_response).to be_ok 
    response = JSON.parse last_response.body
    expect(response['version']).to eq '1.0' 
    expect(response['response']['shouldEndSession']).to eq false
    expect(response['response']['outputSpeech']['type']).to eq 'SSML'
    expect(response['response']['outputSpeech']['ssml']).to include 'Bäcker', 'Brötchen', 'wie viele', '?'
    expect(response['response']['outputSpeech']['ssml']).to include '<speak>', '</speak>' 
    expect(response['response']['outputSpeech']['ssml']).to include '<s>', '</s>' 
  end

end