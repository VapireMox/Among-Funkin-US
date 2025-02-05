package;

import extra.SUSButton;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import openfl.utils.Assets;
import openfl.utils.AssetType;

import hscript.Interp;
import hscript.Parser;

class MainMenuState extends MusicBeatState {
  public static var psychEngineVersion:String = "0.6.3-special";
  
  //星空
  var starrySky:FlxBackdrop;
  var panelBG:FlxSprite;
  var blank:FlxSprite;
  var charTopState:FlxSprite;
  var logo:FlxSprite;

  var buttons:FlxTypedGroup<SUSButton>;
  var asChars:Array<FlxSprite>;

  var interp:Interp;
  
  override function create() {
    super.create();

    interp = new Interp();
    interp.variables.set("blank", blank);
    var parser:Parser = new Parser();
    interp.execute(parser.parseString(Paths.getTextFromFile("mainmenu.hx")));

    if(!FlxG.mouse.visible) FlxG.mouse.visible = true;

    starrySky = new FlxBackdrop(Paths.image("mainmenu/StarrySky"));
    starrySky.setGraphicSize(FlxG.width, FlxG.height);
    starrySky.updateHitbox();
    starrySky.scrollFactor.set();
    add(starrySky);

    panelBG = new FlxSprite().loadGraphic(Paths.image("mainmenu/panelBG"));
    panelBG.setGraphicSize(FlxG.width, FlxG.height);
    panelBG.updateHitbox();
    panelBG.scrollFactor.set();
    add(panelBG);

    blank = new FlxSprite(-117, 12).loadGraphic(Paths.image("mainmenu/blank"));
    blank.scrollFactor.set();
    blank.scale.set(0.34, 0.34);
    blank.updateHitbox();
    add(blank);

    buttons = new FlxTypedGroup<SUSButton>();
    createButtons();
    add(buttons);

    charTopState = new FlxSprite(-4, -51).loadGraphic(Paths.image("mainmenu/CharTopState"));
    charTopState.scrollFactor.set();
    charTopState.scale.set(0.262, 0.2);
    charTopState.updateHitbox();
    add(charTopState);

    logo = new FlxSprite(0, -40).loadGraphic(Paths.image("mainmenu/MainLOGO"));
    logo.scrollFactor.set();
    logo.scale.set(0.16, 0.16);
    logo.updateHitbox();
    logo.x = FlxG.width - logo.width;
    add(logo);

    Reflect.callMethod(null, interp.variables.get("onCreate"), []);
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }

  private function createButtons() {
    var buttonNames:Array<String> = ["SM", "FP", "SP"];
    var jiange:Float = 0;

    for(num=>buttonName in buttonNames) {
      var susButton:SUSButton = new SUSButton(25, 150, Paths.image('mainmenu/${buttonName}Button'));
      susButton.scale.set(0.35, 0.35);
      susButton.updateHitbox();
      Reflect.callMethod(null, interp.variables.get("onCreateButtons"), [susButton]);

      susButton.y += num * susButton.height + jiange;
      add(susButton);
    }
  }
}
