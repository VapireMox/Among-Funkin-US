package;

import flixel.addons.display.FlxBackdrop;
import extra.SUSButton;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;

@:access(extra.SUSButton)
class MainMenuState extends MusicBeatState {
  public static var psychEngineVersion:String = "0.6.3(AFUS)";
  public var canSelected(default, set):Bool = false;
  @:noCompletion private function set_canSelected(val:Bool):Bool {
    if(buttons != null && buttons.length > 0) {
      buttons.forEachAlive(function(obj:SUSButton) {
        if(val)
          obj.callEffect = NORMAL(0.5);
        else obj.callEffect = NONE;
      });
    }
    return val;
  }
  
  var bg:FlxSprite;
  var blank:FlxSprite;
  var charTopState:FlxSprite;
  var starrySky:FlxSprite;
  var logo:FlxSprite;

  var buttons:FlxTypedSpriteGroup<SUSButton>;
  var susPeople:FlxGroup;

  public override function create() {
    if(!FlxG.mouse.visible) FlxG.mouse.visible = true;
    
    super.create();

		canSelected = true;
    
	  starrySky = new FlxBackdrop(Paths.image("mainmenu/StarrySky"));
	  starrySky.setGraphicSize(FlxG.width + 2, FlxG.height);
	  add(starrySky);
	
	  susPeople = new FlxGroup();
	  createSUSPeople();
	  add(susPeople);

	  bg = new FlxSprite().loadGraphic(Paths.image("mainmenu/panelBG"));
	  bg.setGraphicSize(FlxG.width + 2, FlxG.height);
	  bg.updateHitbox();
    bg.scrollFactor.set();
	  add(bg);
	
	  blank = new FlxSprite(-65, 81).loadGraphic(Paths.image("mainmenu/blank"));
	  blank.scale.set(0.333, 0.333);
	  blank.updateHitbox();
    blank.scrollFactor.set();
	  add(blank);
	
	  charTopState = new FlxSprite(-8, -50).loadGraphic(Paths.image("mainmenu/CharTopState"));
	  charTopState.scale.set(0.264, 0.2);
	  charTopState.updateHitbox();
    charTopState.scrollFactor.set();
	  add(charTopState);
	
	  logo = new FlxSprite(FlxG.width, -25).loadGraphic(Paths.image("mainmenu/MainLOGO"));
	  logo.scale.set(0.15, 0.15);
	  logo.updateHitbox();
    logo.scrollFactor.set(0.1, 0.1);
	  logo.x -= logo.width;
	  add(logo);
	
	  buttons = new FlxTypedSpriteGroup<SUSButton>(blank.x + 92.5, blank.y + 85);
	  createButtons();
    buttons.scrollFactor.set();
	  add(buttons);
  }

  public override function update(elapsed:Float) {
	  super.update(elapsed);

    var fudu:Float = 2.5;
    if(canSelected) {
      FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX - FlxG.width / 2) * (fudu / (FlxG.width / 2)), 0.1);
      FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY - FlxG.height / 2) * (fudu / (FlxG.height / 2)), 0.1);

      logo.y = -25 + (Math.sin((Conductor.songPosition / 1000) / Math.PI) * 5);
    }
	  
	  starrySky.x += elapsed * 2;
  }

  function createButtons() {
	  var buttonNames:Array<String> = ["SM", "FP", "SP", "PE", "CM", "OS", "CS", "LE"];
	
	  for(num=>buttonName in buttonNames) {
		  var button = new SUSButton(0, 0, Paths.image('mainmenu/${buttonName}Button'));
		  button.scale.set(0.333, 0.333);
		  button.updateHitbox();
		  if(num != buttonNames.indexOf("LE"))
			  button.y = num * (num > 0 ? buttons.members[buttons.length - 1].height : 0);
		
		  if(num < buttonNames.indexOf("PE") && num > 0) button.y -= (num % buttonNames.indexOf("PE")) * 10;
		  else if(num >= buttonNames.indexOf("PE") && num < buttonNames.indexOf("LE")) {
			  button.y -= 6.5;
			  if(num > buttonNames.indexOf("PE")) button.y -= 20 * (num % (buttonNames.indexOf("LE") - buttonNames.indexOf("PE")) + 1);
		  }else if(num != 0) {
			  button.y = buttonNames.indexOf("CS") * button.height - 67;
		  }
		
		  if(num > buttonNames.indexOf("OS") && num <= buttonNames.indexOf("LE")) {
			  button.x += 78 * (num == buttonNames.indexOf("CS") ? -1 : 1);
		  }
		  buttons.add(button);

      button.clickCallback = (sb:FlxTween) -> {
        switch(buttonName) {
          case "SM":
            canSelected = false;
            MusicBeatState.switchState(new StoryMenuState());
          case "FP":
            canSelected = false;
            MusicBeatState.switchState(new FreeplayState());
          case "OS":
            canSelected = false;
            MusicBeatState.switchState(new options.OptionsState());
          case "LE":
            canSelected = false;
            MusicBeatState.switchState(new TitleState());
          case "CS":
            canSelected = false;
            MusicBeatState.switchState(new CreditsState());
          default: 
            lime.app.Application.current.window.alert("暂未开饭", "error");
        }
      }; 
	  }
  }

  function createSUSPeople() {
	  var susMans:Array<String> = ["blue-half", "diamondPurple", "orange", "purple", "sadRed", "wazeGrey"];
	
	  var list = FlxG.random.int(1, 2);
	  if(list > 0)
		  for(i in 0...list) {
			  var dataS:Int = FlxG.random.int(0, susMans.length - 1);
			  var susMan:String = susMans[dataS];
			  var sb = new FlxSprite().loadGraphic(Paths.image('mainmenu/characters/${susMan}'));
			  sb.scale.set(0.2, 0.2);
			  sb.updateHitbox();
			
			  var dataX = FlxG.random.int(0, 1);
			  var dataAngle:Int = FlxG.random.int(-1, 1);
			  sb.x = dataX * FlxG.width;
			  sb.y = FlxG.random.float(140, 580);
			  sb.angle = FlxG.random.int(0, 360);
			  susPeople.add(sb);
			
			  var angleSpeed:Int = FlxG.random.int(0, 180);
			
			  FlxTween.tween(sb, {
				  x: (1 - dataX) * FlxG.width,
				  y: FlxG.random.float(140, 580)
			  }, FlxG.random.float(8, 15), {
				  onComplete: function(tween:FlxTween) {
					  susPeople.remove(sb, true);
					  createSUSPeople();
				  },
				  onUpdate: function(tween:FlxTween) {
					  switch(susMan) {
						  case "sadRed":
							  //sb.origin.set(FlxG.random.float(-2.5, 2.5), FlxG.random.float(-2.5, 2.5));
							  //sb.updateHitbox();
						  default:
							  sb.angle += dataAngle * (FlxG.elapsed * angleSpeed);
					  }
				  }
			  });
			
			  if(susPeople.length > 4) {
				  for(i in 0...susPeople.length - 4) {
					  susPeople.remove(susPeople.members[susPeople.members.length - 1], true);
				  }
			  }
		  }
  }
}
