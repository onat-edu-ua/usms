shared_context :api_test_helper do
  let(:response_body) { JSON.parse(response.body).presence.try!(:with_indifferent_access) }
end
