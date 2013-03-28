require 'spec_helper'

describe Herohook do
  let(:params) { {:app => 'app'} }

  it "#perform" do
    hook = mock(Herohook::Base)
    Herohook.stub(:hooks => [hook])
    hook.should_receive(:perform)
    Herohook.perform(params)
    Herohook.params.should == params
  end

  describe "with params defined" do
    before {
      Herohook.params = params
    }
    
    describe "with yaml loaded" do
      before do
        Herohook.stub :yaml => {
          'app' => {
            'honeybadger' => {'api_key' => 'honeybadger_api_key'},
            'pivotal_tracker' => {'api_key' => 'pivotal_tracker_api_key'}
          }
        }
      end
  
      it "#hooks" do
        Herohook.hooks.map(&:class).should == [Herohook::Honeybadger, Herohook::PivotalTracker]
      end
  
      it "#config" do
        Herohook.config.should == Herohook.yaml['app']
      end
    end
  end

  it "#app" do
    Herohook.app.should == 'app'
  end
end