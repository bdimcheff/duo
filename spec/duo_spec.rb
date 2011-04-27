require 'spec_helper'

IKEY = "DIXXXXXXXXXXXXXXXXXX"
SKEY = "deadbeefdeadbeefdeadbeefdeadbeefdeadbeef"

USER = "testuser"

INVALID_RESPONSE = "  |INVALID|SIG"
EXPIRED_RESPONSE = "AUTH|dGVzdHVzZXJ8RElYWFhYWFhYWFhYWFhYWFhYWFh8MTMwMDE1Nzg3NA==|cb8f4d60ec7c261394cd5ee5a17e46ca7440d702"
FUTURE_RESPONSE = "AUTH|dGVzdHVzZXJ8RElYWFhYWFhYWFhYWFhYWFhYWFh8MTYxNTcyNzI0Mw==|d20ad0d1e62d84b00a3e74ec201a5917e77b6aef"


describe Duo do
  
  context "signing" do
    
    it "doesn't fail spectacularly" do
      lambda { Duo.sign_request(SKEY, IKEY, USER) }.should_not raise_error
    end
    pending "write tests, dug!!"
  end
  
  context "verifying" do
    it "verifies a valid response" do
      future_user = Duo.verify_response(SKEY, FUTURE_RESPONSE)
      future_user.should == USER
    end
    
    it "rejects an invalid user" do
      future_user = Duo.verify_response(SKEY, INVALID_RESPONSE)
      future_user.should be_nil
    end
    
    it "rejects an expired user" do
      future_user = Duo.verify_response(SKEY, EXPIRED_RESPONSE)
      future_user.should be_nil
    end
    
    it "doesn't crash when nil" do
      lambda { Duo.verify_response(SKEY, nil) }.should_not raise_error
    end
    
    it "doesn't crash when nonsense" do
      lambda { Duo.verify_response(SKEY, 'abceaouhsnt') }.should_not raise_error
    end
    
    it "doesn't crash when pipey" do
      lambda { Duo.verify_response(SKEY, '|') }.should_not raise_error
    end
    
    it "doesn't crash when 7" do
      lambda { Duo.verify_response(SKEY, 7) }.should_not raise_error
    end
  end
end
