require 'spec_helper'

describe 'kitties::cat' do
  let(:title) { 'namevar' }
  let(:facts) { { 'hostname' => 'laura' } }

  on_supported_os.each do |os, _os_facts|
    context "on #{os}" do
      describe 'when running with parameters' do
        context 'ensure => present and group => nice_kitty' do
          let(:params) { { 'ensure' => 'present', 'group' => 'nice_kitty' } }

          it { is_expected.to compile }
          it { is_expected.to contain_user('namevar').with_ensure('present') }
          it { is_expected.to contain_user('namevar').with_gid('nice_kitty') }
          it { is_expected.to contain_user('namevar').with_managehome(true) }
          it { is_expected.to contain_user('namevar').with_home('/opt/cats/namevar') }
          it { is_expected.to contain_user('namevar').with_comment('Cat namevar in laura') }

          it { is_expected.to contain_file('/opt/cats/namevar/cat.txt').with_ensure('file') }
          it { is_expected.to contain_file('/opt/cats/namevar/cat.txt').with_owner('namevar') }
          it { is_expected.to contain_file('/opt/cats/namevar/cat.txt').with_group('nice_kitty') }
          it { is_expected.to contain_file('/opt/cats/namevar/cat.txt').with_content('I am namevar and I am a good kitty') }
        end
        context 'ensure => present' do
          let(:params) { { 'ensure' => 'present' } }

          it { is_expected.to compile }
          it { is_expected.to contain_user('namevar').with 
            ({
              'ensure'     => 'present',
              'gid'        => 'cat',
              'managehome' => true,
              'home'       => '/opt/cats/namevar',
              'comment'    => 'Cat namevar in laura'
            })
          }
          it { is_expected.to contain_file('/opt/cats/namevar/cat.txt').with
            ({
              'ensure'  => 'file',
              'owner'   => 'namevar',
              'group'   => 'cat',
              'content' => 'I am namevar and I am a good kitty',
            })
          }
        end
        context 'ensure => wrong_value' do
          let(:params) { { 'ensure' => 'wrong_value' } }

          it { is_expected.to compile.and_raise_error(%r{Error while evaluating a Resource Statement}) }
        end
      end
      describe 'when running without parameters' do
        it { is_expected.to compile }
        it { is_expected.to contain_user('namevar').with_ensure('absent') }
      end
    end
  end
end
