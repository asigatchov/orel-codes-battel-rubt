require 'json'
require 'digest'

run  Proc.new { |env|
    req = Rack::Request.new(env)
 
    if req.request_method == 'GET'
      ['200', {'Content-Type' => 'application/json'}, [ 'Only POST json request' ]] 
    else  
    
      params = JSON.parse(req.body.read)
      first_name_md5 =  Digest::MD5.hexdigest(params["first_name"].to_s)
      last_name_md5 =  Digest::MD5.hexdigest(params["last_name"].to_s)
      params["first_name"] <<  " #{first_name_md5}"
      params["last_name"] << " #{last_name_md5}"
      params["current_time"] = Time.now.strftime("%F %T %z")
      params["say"] = "Ruby is best!!"

      ['200', {'Content-Type' => 'application/json'}, [ params.to_json ]]
    end
}
