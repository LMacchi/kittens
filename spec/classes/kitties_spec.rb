require 'spec_helper'

describe 'kitties' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'when running without parameters' do
        it { is_expected.to compile }
        it { is_expected.to contain_group('cat').with_ensure('present') }
        it { is_expected.to contain_kitties__cat('caliente').with_ensure('present') }
        it { is_expected.to contain_kitties__cat('oswin').with_ensure('present') }
        it { is_expected.to contain_file('/opt/cats').with_ensure('directory') }
      end
      describe 'when running with parameters' do
        context 'internet_cats => ["grumpy_cat,"nyan_cat"]' do
          let(:params) { { 'internet_cats' => ['grumpy_cat','nyan_cat'] } }
          it { is_expected.to compile }
          it { is_expected.to contain_group('cat').with_ensure('present') }
          it { is_expected.to contain_kitties__cat('caliente').with_ensure('present') }
          it { is_expected.to contain_kitties__cat('oswin').with_ensure('present') }
          it { is_expected.to contain_file('/opt/cats').with_ensure('directory') }
          it { is_expected.to contain_group('internet_cats').with_ensure('present') }
          it { is_expected.to contain_kitties__cat('grumpy_cat').with_ensure('present') }
          it { is_expected.to contain_kitties__cat('nyan_cat').with_ensure('present') }
        end
        context 'internet_cats => 5' do
          let(:params) { { 'internet_cats' => 5 } }
          it { is_expected.to compile.and_raise_error(%r{Error while evaluating a Resource Statement}) }
        end
      end
    end
  end
end
