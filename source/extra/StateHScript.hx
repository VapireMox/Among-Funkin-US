package extra;

import Type.ValueType;
import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

//用于state的,仅供开发者测试
class StateHScript {
  public var interp:Interp;
  public var parser:Parser;

  var expr:Expr;
  var code:String;

  @:isVar var origin(get, never):String;
  @:noCompletion private function get_origin():String {
    return expr != null ? expr.origin : "hscript";
  }

  private var parent:Dynamic;
  private var parentInstanceField:Array<String>;
  
  public function new(?cl:Dynamic) {
    interp = new Interp();
    parser = new Parser();
    parent = cl;

    if(cl != null) {
      parentInstanceField = Type.getInstanceField(Type.getClass(cl));
      code = Paths.getTextFromFile('states/${Type.getClassName(Type.getClass(cl))}.hx');

      setClField();
    }

    expr = parser.parseString(code, cl != null ? Type.getClassName(Type.getClass(cl)) : null);
  }

  public function execute() {
    try {
      interp.execute(expr);
      call("onLoaded");
    }catch(e) {
      errorMessage(e.message);
    }
  }

  public function call(key:String, ?value:Dynamic) {
    if(!interp.variables.exists(key)) return;
    if(Type.typeof(interp.variables.get(key)) != TFunction) {
      errorMessage("ooo \t你竟然可以让函数和其他的变量重名，太牛逼了，哈哈哈哈:)");
      return;
    }

    Reflect.callMethod(null, interp.variables.get(key), (value == null ? [] : (value is Array ? value : [value])));
  }

  public function get(key:String):Dynamic {
    if(!interp.variables.exists(key)) {
      errorMessage("不存在'${key}'这个词");
      return null;
    }

    return interp.variables.get(key);
  }

  public function set(key:String, value:Dynamic):Dynamic {
    interp.variables.set(key, value);
    return value;
  }

  private function setClField() {
    if(parentInstanceField == null || parent == null) return;
    for(fieldName in parentInstanceField) {
      interp.variables.set(fieldName, Reflect.field(parent, fieldName));
    }
  }

  private function errorMessage(message:String) {
    lime.app.Application.current.window.alert(message, '${origin} ERROR!!');
  }
}
