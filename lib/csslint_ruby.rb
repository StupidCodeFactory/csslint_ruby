require 'csslint_ruby/version'
require 'csslint_ruby/source'
require 'execjs'

module CsslintRuby

  def self.context
    ExecJS.compile(
      Source.contents + <<-EOJS
function gatherRules(options){
    var ruleset,
        ignores  = options.ignores,
        warnings = options.rules || options.warnings,
        errors   = options.errors;

    if (ignores) {
        ruleset = ruleset || {};
        for( var _i = 0, _len = ignores.length; _i < _len; _i++ ) {
            ruleset[ignores[_i]] = 0;
        };
    }

    if (warnings) {
        ruleset = ruleset || {};
        for( var _i = 0, _len = warnings.length; _i < _len; _i++ ) {
            ruleset[warnings[_i]] = 1;
        };
    }

    if (errors) {
        ruleset = ruleset || {};
        for( var _i = 0, _len = errors.length; _i < _len; _i++ ) {
            ruleset[errors[_i]] = 2;
        };
    }

    return ruleset;
};

function CSSLINTER(source, options) {
    var result    = CSSLint.verify( source, gatherRules( options ) );
    var messages  = result.messages || [];
    return [ messages ];
};
EOJS
    )
  end

  def self.run(source, options = {})
    source = source.respond_to?(:read) ? source.read : source
    processor = SourceProcessor.new(source, options.fetch(:ignore_tag, false))
    Result.new(*context.call('CSSLINTER', processor.data_without_ignores, options))
  end

  class Result

    TYPE_ERROR = "error".freeze

    attr_reader :errors, :warnings

    def initialize(errors)
      @errors, @warnings = errors.partition {|error| error['type'] == TYPE_ERROR }
    end

    def valid?
      errors.empty?
    end
  end

  class SourceProcessor
    DEFAULT_IGNORE_TAG = 'lintingIgnore'

    attr_reader :ignore_tag, :data

    def initialize(data, ignore_tag)
      @data = data
      @ignore_tag = ignore_tag || DEFAULT_IGNORE_TAG
    end

    def data_without_ignores
      data.gsub(/\/\* @#{ignore_tag}Begin \*\/.+?\/\* @#{ignore_tag}End \*\//m, '')
    end
  end
end
