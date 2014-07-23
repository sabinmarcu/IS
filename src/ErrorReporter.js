// Generated by CoffeeScript 1.7.1
(function() {
  var ErrorReporter,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ErrorReporter = (function() {
    function ErrorReporter() {
      this.toString = __bind(this.toString, this);
    }

    ErrorReporter._errors = {
      "Unknown Error": ["An unknown error has occurred"]
    };

    ErrorReporter._indices = [ErrorReporter._errors["Unknown Error"][0]];

    ErrorReporter._groups = ["Unknown Error"];

    ErrorReporter.wrapCustomError = function(error) {
      return "[" + error.name + "] " + error.message;
    };

    ErrorReporter.generate = function(errorCode, extra) {
      if (extra == null) {
        extra = null;
      }
      return (new this).generate(errorCode, extra);
    };

    ErrorReporter.extended = function() {
      var error, errors, group, key, _i, _len, _ref;
      _ref = this.errors;
      for (group in _ref) {
        errors = _ref[group];
        this._errors[group] = errors;
        this._groups.push(group);
        for (key = _i = 0, _len = errors.length; _i < _len; key = ++_i) {
          error = errors[key];
          this._indices.push(this._errors[group][key]);
        }
      }
      this.prototype._ = this;
      delete this.errors;
      return this.include(ErrorReporter.prototype);
    };

    ErrorReporter.prototype.generate = function(errCode, extra) {
      var errors, group, _ref, _ref1;
      this.errCode = errCode;
      if (extra == null) {
        extra = null;
      }
      if (!this._._indices[this.errCode]) {
        this.name = this._._groups[0];
        this.message = this._._errors[this._._groups[0]][0];
      } else {
        this.message = this._._indices[this.errCode];
        if (extra) {
          this.message += " - Extra Data : " + extra;
        }
        _ref = this._._errors;
        for (group in _ref) {
          errors = _ref[group];
          if (!(_ref1 = this.message, __indexOf.call(errors, _ref1) >= 0)) {
            continue;
          }
          this.name = group;
          break;
        }
      }
      return this;
    };

    ErrorReporter.prototype.toString = function() {
      return "[" + this.name + "] " + this.message + " |" + this.errCode + "|";
    };

    return ErrorReporter;

  })();

  module.exports = ErrorReporter;

}).call(this);