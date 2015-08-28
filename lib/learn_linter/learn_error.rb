class LearnError < StandardError
  attr_accessor :filepath, :valid_yaml, :valid_license, 
  :present_learn, :present_license, :present_readme, :yaml_error, :readme_error, :license_error

  ESCAPES = { :green  => "\033[32m",
              :yellow => "\033[33m",
              :red    => "\033[31m",
              :reset  => "\033[0m" }


  def initialize
    @yaml_error = {present_dotlearn: false, valid_yaml: false, valid_whitespace: false}
    @readme_error = {present_readme: false, valid_readme: nil}
    @license_error = {present_license: false, valid_license: false}
    @valid_yaml = {message: "invalid yaml", color: :red}
    @valid_license = {message: "invalid or missing license content", color: :yellow}
    @present_learn = {message: "missing .learn file", color: :red}
    @present_license = {message: "missing LICENSE.md", color: :red}
    @present_readme = {message: "missing README.md", color: :yellow}

  end

  def emit(opts={})
    color   = opts[:color]
    message = opts[:message]
    print ESCAPES[color]
    print message
    print ESCAPES[:reset]
    print "\n"
  end

  def total_errors
    {
      dot_learn: yaml_error,
      license: license_error,
      readme: readme_error
    }
    
  end


  def result_output
    # binding.pry
    all_results = [present_learn, valid_yaml, present_license, valid_license, present_readme]
    all_results.each do |result|
      emit(result)
    end
  end

end