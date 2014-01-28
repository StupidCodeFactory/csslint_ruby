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
    Result.new(*context.call('CSSLINTER', source, options))
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
end
