package extra;

import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;
import flixel.FlxG;

class SUSButton extends FlxSprite {
  public static var groupName:Array<String> = [""];

  public var defaultScale:FlxPoint = FlxPoint.get(1, 1);

  public var clickCallback:Dynamic = null;

  private var callEffect:CallEffect;

  private var scaleNB:Float = 0.04;
  private var overed:Bool = true;
  private var outed:Bool = false;
  
  public function new(?x:Float = 0, ?y:Float = 0, graphic:FlxGraphicAsset, ?callEffect:CallEffect) {
    super(x, y);

    loadGraphic(graphic);
    if(callEffect == null) callEffect = NORMAL(0.5);
    this.callEffect = callEffect;
  }

  public override function updateHitbox() {
    defaultScale.set(this.scale.x, this.scale.y);
    super.updateHitbox();
  }

  override function update(elapsed:Float) {
    super.update(elapsed);

    if(overlapFromMouse()) {
      outed = true;
      if(overed) {
        onMouseOver(this);
        overed = false;
      }

      if(FlxG.mouse.justPressed) {
        onMouseDown(this);
      }
      if(FlxG.mouse.justReleased) {
        onMouseUp(this);
      }
    }else {
      overed = true;
      if(outed) {
        onMouseOut(this);
        outed = false;
      }
    }
  }

  private function overlapFromMouse():Bool {
    return (this.x < FlxG.mouse.screenX && this.x + this.width > FlxG.mouse.screenX &&
    this.y < FlxG.mouse.screenY && this.y + this.height > FlxG.mouse.screenY);
  }

  private function onMouseDown(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL(fudu):
          FlxTween.tween(scale, {x: defaultScale.x - scaleNB, y: defaultScale.y - scaleNB}, 0.08, {ease: FlxEase.quadIn});
        case NONE: {}
    }
  }

  private function onMouseUp(obj:FlxSprite) {
    switch(this.callEffect) {
      case NORMAL(fudu):
        FlxTween.tween(scale, {x: defaultScale.x, y: defaultScale.y}, 0.08, {ease: FlxEase.quadOut, onComplete: clickCallback});
      case NONE: {}
    }
  }

  private function onMouseOver(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL(fudu):
          FlxTween.tween(scale, {x: defaultScale.x + scaleNB * fudu, y: defaultScale.y + scaleNB * 0.5}, 0.12, {ease: FlxEase.circIn});
        case NONE: {}
    }
  }

  private function onMouseOut(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL(fudu):
          FlxTween.tween(scale, {x: defaultScale.x, y: defaultScale.y}, 0.12, {ease: FlxEase.circOut});
        case NONE: {}
    }
  }
}

enum CallEffect {
  NORMAL(fudu:Float);
  NONE;
}
