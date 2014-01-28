module CsslintRuby
  class Source

    def self.path
      ENV['CSSLINT_PATH'] ||
        File.expand_path("../../../vendor/csslint/csslint.js", __FILE__)
    end

    def self.contents
      @contents ||= File.read(path)
    end

  end
end
