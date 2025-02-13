package extra;

import haxe.io.Path;
import haxe.ds.StringMap;

class FunkinScript {
  public static function getProcessedFields(parent:FunkinScript):Map<String, Dynamic> {
    var sb:Map<String, Dynamic> = [
      "psychEngineVersion" => MainMenuState.psychEngineVersion
    ];

    return sb;
  }
  
  public var scriptName:String;
  public var scriptExtension:String;
  public var path:String;
  public var directory:String;
  
  public function new(path:String) {
    this.path = path;
    scriptName = Path.withoutDirectory(path);
    scriptExtension = Path.extension(path);
    directory = Path.directory(path);
  }

  public function set(name:String, val:Dynamic) {
  }

  public function get(name:String):Dynamic {
    return null;
  }

  public function call(name:String, ?args:Array<Dynamic>):Dynamic {
    return null;
  }

  @:noCompletion
  private function toString():String {
    return '{Path: $path}';
  }
}
