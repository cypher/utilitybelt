# S3 (http://amazon.rubyforge.org/)
UTILITY_BELT_IRB_STARTUP_PROCS[:define_s3_convenience_methods] = lambda do
  %w{aws/s3 cgi platform}.each {|lib| require lib}
  def aws_upload(bucket,filename)
    AWS::S3::Base.establish_connection!(:access_key_id => ENV['AMAZON_ACCESS_KEY_ID'], 
                                        :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY'])
    AWS::S3::S3Object.store(filename, open(filename), bucket, :access => :public_read)
    url = "http://s3.amazonaws.com/#{bucket}/#{filename}".gsub(/ /, "%20")
    MacClipboard.write(url) if :macosx == Platform::IMPL && defined? MacClipboard
    url
  end
end

# a quick note: the "google" command uses CGI.escape, but the URLs produced by CGI.escape
# don't seem to succeed here, in practice. this may differ by OS and/or browser. Let me
# know if you see something weird -- the Utility Belt mailing list is here:
#
# http://rubyforge.org/mailman/listinfo/utilitybelt-tinkering