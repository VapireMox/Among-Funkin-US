package;

import extra.SUSButton;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import tjson.TJSON;
import openfl.Assets;

class MainMenuState extends MusicBeatState {
  public static var psychEngineVersion:String = "0.6.3-special";
  
  //星空
  var starrySky:FlxBackdrop;
  var panelBG:FlxSprite;
  var blank:FlxSprite;
  var charTopState:FlxSprite;
  var logo:FlxSprite;

  var buttons:FlxTypedSpriteGroup<SUSButton>;
  var asChars:Array<FlxSprite>;

  var debugJson:DebugJSON;
  
  override function create() {
    super.create();

    debugJson = cast(TJSON.parse(Assets.getText(Paths.json("mainmenu"))), DebugJson);

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

    blank = new FlxSprite(50, 100).loadGraphic(Paths.image("mainmenu/blank"));
    blank.scrollFactor.set();
    add(blank);
    if(Reflect.hasField(debugJson, "blank")) {
      blank.x = debugJson.blank.x;
      blank.y = debugJson.blank.y;

      if(Reflect.hasField(debugJson.blank, "scale")) {
        blank.scale.set(debugJson.blank.scale.x, debugJson.blank.scale.y);
      }

      if(Reflect.hasField(debugJson.blank, "updateHitbox") && debugJson.blank.updateHitbox) blank.updateHitbox();
    }

    buttons = new FlxTypedSpriteGroup<SUSButton>(blank.x, blank.y);
    blank.scrollFactor.set();
    createButtons();
    add(buttons);
    if(Reflect.hasField(debugJson, "buttons")) buttons.setPosition(debugJson.buttons.x, debugJson.buttons.y);

    charTopState = new FlxSprite().loadGraphic(Paths.image("mainmenu/CharTopState"));
    charTopState.scrollFactor.set();
    add(charTopState);
    if(Reflect.hasField(debugJson, "charTopState")) {
      charTopState.x = debugJson.charTopState.x;
      charTopState.y = debugJson.charTopState.y;

      if(Reflect.hasField(debugJson.charTopState, "scale")) {
        charTopState.scale.set(debugJson.charTopState.scale.x, debugJson.charTopState.scale.y);
      }

      if(Reflect.hasField(debugJson.charTopState, "updateHitbox") && debugJson.charTopState.updateHitbox) blank.updateHitbox();
    }

    logo = new FlxSprite().loadGraphic(Paths.image("mainmenu/MainLOGO"));
    logo.scrollFactor.set();

    logo.x = FlxG.width - logo.width;
    add(logo);
    if(Reflect.hasField(debugJson, "logo")) {
      logo.x = debugJson.logo.x;
      logo.y = debugJson.logo.y;

      if(Reflect.hasField(debugJson.logo, "scale")) {
        logo.scale.set(debugJson.logo.scale.x, debugJson.logo.scale.y);
      }

      if(Reflect.hasField(debugJson.logo, "updateHitbox") && debugJson.logo.updateHitbox) logo.updateHitbox();
    }
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }

  private function createButtons() {
    var buttonNames:Array<String> = ["SM", "FP", "SP"];
    var jiange:Float = 0;

    for(num=>buttonName in buttonNames) {
      var button:SUSButton = new SUSButton(0, 0, Paths.image('mainmenu/${buttonName}Button'));
      button.scale.set(0.4, 0.4);
      button.updateHitbox();
      button.y += num * button.height;
      button.scrollFactor.set();
      buttons.add(button);
    }
  }
}

typedef DebugJSON = {
  var ?blank:DebugSprite;
  var ?charTopState:DebugSprite;
  var ?logo:DebugSprite;
  var ?buttons:DebugScale;
}

typedef DebugSprite = {
  var x:Float;
  var y:Float;
  var ?scale:DebugScale;
  var ?updateHitbox:Bool;
}

typedef DebugScale = {
  var x:Float;
  var y:Float;
}
