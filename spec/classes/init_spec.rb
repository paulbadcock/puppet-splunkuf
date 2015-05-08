require 'spec_helper'
describe 'splunkuf' do

  context 'with defaults for all parameters' do
    it { should contain_class('splunkuf') }
  end
end
