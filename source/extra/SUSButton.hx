package extra;

import flixel.FlxSprite;
import flixel.inputs.mouse.FlxMouseEvent;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class SUSButton extends FlxSprite {
  public static var groupName:Array<String> = [""];

  public var clickCallback:Dynamic = null;

  private var callEffect:CallEffect;

  private var scaleNB:Float = 0.5;
  
  public function new(?x:Float = 0, ?y:Float = 0, graphic:FlxGraphicAsset, ?callEffect:CallEffect = NORMAL) {
    super(x, y);

    loadGraphic(graphic);
    this.callEffect = callEffect;
    FlxMouseEvent(this, onMouseDown, null, onMouseOver, onMouseOut);
  }

  private function onMouseDown(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL:
          FlxTween.tween(scale, {x: 1 - scaleNB, y: 1 - scaleNB}, 0.15, {ease: FlxEase.quadIn, onComplete: huiTang});
    }
  }

  private function onMouseOver(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL:
          FlxTween.tween(scale, {x: 1 + scaleNB, y: 1 + scaleNB}, 0.15, {ease: FlxEase.circIn});
    }
  }

  private function onMouseOut(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL:
          FlxTween.tween(scale, {x: 1, y: 1}, 0.15, {ease: FlxEase.circOut});
    }
  }

  private function huiTang(tween:FlxTween) {
    FlxTween.tween(scale, {x: 1, y: 1}, 0.15, {ease: FlxEase.quadOut, onComplete: clickCallback});
  }
}

enum CallEffect {
  NORMAL;
}
