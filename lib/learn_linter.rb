require_relative './learn_linter/version'
require_relative './learn_linter/learn_error'
require_relative './learn_linter/license_linter'
require_relative './learn_linter/readme_linter'
require_relative './learn_linter/yaml_linter'

class LearnLinter

  attr_accessor :filepath, :quiet


  def initialize(dir=nil, quiet=nil)
    @filepath = dir || Dir.pwd
    @learn_error = LearnError.new
    @quiet = quiet
  end

  def lint_directory
    self.yaml_lint
    self.license_lint
    self.readme_lint
    unless quiet
      @learn_error.result_output
    end
    @learn_error.total_errors
  end



  def has_file?(file)
    Dir.entries(filepath).include?(file)
  end

  def yaml_lint
    if self.has_file?(".learn")
      @learn_error.yaml_error[:present_dotlearn] = true
      @learn_error.present_learn = {message: "present .learn file", color: :green}
      YamlLint.parse_file("#{filepath}/.learn", @learn_error)
    end
  end

  def license_lint
    if self.has_file?("LICENSE.md")
      @learn_error.license_error[:present_license] = true
      @learn_error.present_license = {message: "present LICENSE.md", color: :green}
      LicenseLinter.parse_file("#{filepath}/LICENSE.md", @learn_error)
    end
  end

  def readme_lint
    if self.has_file?("README.md")
      @learn_error.readme_error[:present_readme] = true
      @learn_error.present_readme = {message: "present README.md", color: :green}
      ReadmeLinter.parse_file("#{filepath}/README.md", @learn_error)
    end
  end

end
