require 'lib/pik/windows_file'
require 'lib/pik/batch_file'
require 'lib/pik/search_path'

describe BatchFile do

  before do
    @bf = BatchFile.new('pik.bat')
  end

	it "should have a header" do
		string =  "@ECHO OFF\n\n" 
		string << "::  This batch file generated by Pik, the\n"
		string << "::  Ruby Manager for Windows\n"	
		@bf.to_s.should == string	
	end

	it "should generate an ftype command for ruby.exe and rubyw.exe" do
		@bf.ftype.to_s.should match(/FTYPE rbfile\=ruby\.exe \"%1\" \%\*\n\nFTYPE rbwfile\=rubyw\.exe \"\%1\" \%\*/)
	end

	it "should generate a path command with the updated ruby path" do
		@bf.set('PATH' => "C:\\ruby\\191\\bin").to_s.should match(/SET PATH\=C:\\ruby\\191\\bin/)
	end

  it "should echo a string given" do 
    @bf.echo("Hello World").to_s.should match(/ECHO Hello World/)
  end

  it "should call the command given" do 
    @bf.call('pik.bat').to_s.should match(/CALL pik\.bat/)
  end
	
end
