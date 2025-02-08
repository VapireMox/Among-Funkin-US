package;

#if hscript
import hscript.Parser;
import hscript.Interp;
import hscript.Expr;
#end

class HScript
{
  public static var defaultVariables:Map<String, Dynamic> = [
    "FlxG" => flixel.FlxG,
    "FlxSprite" => flixel.FlxSprite,
    "FlxCamera" => flixel.FlxCamera,
    "FlxTimer" => flixel.util.FlxTimer,
    "FlxTween" => flixel.tweens.FlxTween,
    "FlxEase" => flixel.tweens.FlxEase,
    "PlayState" => PlayState,
    "game" => flixel.FlxG.state,
    "Paths" => Paths,
    "Conductor" => Conductor,
    "ClientPrefs" => ClientPrefs,
    "Character" => Character,
    "Alphabet" => Alphabet,
    "CustomSubstate" => CustomSubstate,
    #if (!flash || sys) "FlxRuntimeShader" => flixel.addons.display.FlxRuntimeShader, #end
    "ShaderFilter" => openfl.filters.ShaderFilter,
    "StringTools" => StringTools,
    "StorageUtil" => StorageUtil
  ];

  public static var curHScript:HScript = null;

	public var parser:Dynamic = null;
	public var interp:Dynamic = null;

	public var variables(get, never):Map<String, Dynamic>;

	public function get_variables()
	{
		#if hscript
    return (interp != null ? interp.variables : []);
    #elseif
    return [];
    #end
	}

  #if hscript
  private var expr:Expr;
  #end

	public function new()
	{
    curHScript = this;
    
    parser = setupParser();
		interp = setupInterp();
	}

  public function load():Dynamic {}

  public function createFromPath(path:String) {}

	public function execute(codeToRun:String):Dynamic
	{
		return executeCode(codeToRun);
	}

  public function set(key:String, value:Dynamic):Bool {
    if(interp == null) return false;

    interp.variables.set(key, value);
    return true;
  }

  public function get(key:String):Dynamic {
    if(interp == null) return null;
    if(!interp.variables.exists(key)) return null;

    return interp.variables.get(key);
  }

  public function call(key:String, ?args:Dynamic):Dynamic {
    if(interp == null) return null;
    if(!interp.variables.exists(key)) return null;

    return Reflect.callMethod(null, interp.variables.get(key), (args != null ? (args is Array ? args : [args]) : []));
  }

  private function setDefaultVariables(?setThis:Bool = true):Void {
    if(interp == null) return;
    if(defaultVariables == null) return;
    
    for(key in defaultVariables.keys()) {
      set(key, defaultVariables.get(key));
    }
  }

  private function setupInterp():Dynamic {
    #if hscript
    var result:Interp = new Interp();
    return result;
    #end

    return null;
  }

  private function setupParser():Dynamic {
    #if hscript
    var result:Parser = new Parser();
    result.allowMetadata = true;
    result.allowTypes = true;

    return result;
    #end

    return null;
  }

  private function executeCode(code:String) {
    if(interp == null) return null;
    @:privateAccess
    parser.line = 1;

    return interp.execute(parser.parseString(code));
  }
}
