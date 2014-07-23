// Generated by CoffeeScript 1.7.1
(function() {
  var IS, chai, obj,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  IS = require("../../lib/isf.js");

  chai = require("chai");

  obj = IS.Object.clone();

  chai.should();

  describe("Function Pythonize Module", function() {
    it("make basic parameter parsing", function() {
      var inst, object;
      object = (function(_super) {
        __extends(object, _super);

        function object() {
          return object.__super__.constructor.apply(this, arguments);
        }

        object.prototype.get = IS.Modules.Pythonize.parameterize(["name", "surname"], function(options) {
          return "" + options.name + " " + options.surname;
        });

        return object;

      })(obj);
      inst = new object();
      return (inst.get("Anca", "Gramada")).should.equal("Anca Gramada");
    });
    it("handle defaults", function() {
      var inst, object;
      object = (function(_super) {
        __extends(object, _super);

        function object() {
          return object.__super__.constructor.apply(this, arguments);
        }

        object.prototype.get = IS.Modules.Pythonize.parameterize([
          "name", {
            name: "surname",
            "default": "NOBODY"
          }
        ], function(options) {
          return "" + options.name + " " + options.surname;
        });

        return object;

      })(obj);
      inst = new object();
      return (inst.get("Anca")).should.equal("Anca NOBODY");
    });
    it("handle a basic complex example", function() {
      var inst, object;
      object = (function(_super) {
        __extends(object, _super);

        function object() {
          return object.__super__.constructor.apply(this, arguments);
        }

        object.prototype.get = IS.Modules.Pythonize.parameterize([
          "name", {
            name: "surname",
            "default": "NOBODY"
          }
        ], function(options) {
          return "" + options.name + " " + options.surname;
        });

        return object;

      })(obj);
      inst = new object();
      return (inst.get({
        name: "Anca",
        surname: "Becali"
      })).should.equal("Anca Becali");
    });
    it("handle a mixed complex example", function() {
      var inst, object;
      object = (function(_super) {
        __extends(object, _super);

        function object() {
          return object.__super__.constructor.apply(this, arguments);
        }

        object.prototype.get = IS.Modules.Pythonize.parameterize([
          "name", {
            name: "surname",
            "default": "NOBODY"
          }, "age"
        ], function(options) {
          return "" + options.name + " " + options.surname + ", age: " + options.age;
        });

        return object;

      })(obj);
      inst = new object();
      return (inst.get("Anca", {
        age: 13,
        surname: "Becali"
      })).should.equal("Anca Becali, age: 13");
    });
    return it("handle a heavy example", function() {
      var inst, object;
      object = (function(_super) {
        __extends(object, _super);

        function object() {
          return object.__super__.constructor.apply(this, arguments);
        }

        object.prototype.get = IS.Modules.Pythonize.parameterize([
          "name", {
            name: "surname",
            "default": "NOBODY"
          }, "age"
        ], function(options) {
          return "" + options.name + " " + options.surname + ", age: " + options.age;
        });

        return object;

      })(obj);
      inst = new object();
      return (inst.get("Anca", {
        age: 13
      })).should.equal("Anca NOBODY, age: 13");
    });
  });

}).call(this);
