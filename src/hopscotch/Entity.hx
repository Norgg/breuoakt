package hopscotch;

import hopscotch.graphics.IGraphic;
import hopscotch.engine.ScreenSize;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;

class Entity implements IEntity {
    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;

    public var graphic:IGraphic;
    var previousGraphic:IGraphic;

    static var tmpPoint:Point = new Point();

    public function new() {
        active = true;
        visible = true;

        x = 0;
        y = 0;

        graphic = null;
        previousGraphic = null;
    }

    public function begin (frame:Int):Void {
    }

    public function end ():Void {
    }

    public function update (frame:Int):Void {
    }

    public function beginGraphic (frame:Int):Void {
        if (graphic != null) {
            graphic.beginGraphic(frame);
            previousGraphic = graphic;
        }
    }

    public function endGraphic ():Void {
        if (previousGraphic != null) {
            previousGraphic.endGraphic();
            previousGraphic = null;
        }
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize):Void {
        if (graphic != previousGraphic) {
            if (previousGraphic != null) {
                previousGraphic.endGraphic();
            }
            if (graphic != null) {
                graphic.beginGraphic(frame);
            }
            previousGraphic = graphic;
        }

        if (graphic != null && graphic.active) {
            graphic.updateGraphic(frame, screenSize);
        }
    }

    public function render (target:BitmapData, position:Point, camera:Matrix):Void {
        if (graphic != null && graphic.visible) {
            tmpPoint.x = position.x + x;
            tmpPoint.y = position.y + y;

            graphic.render(target, tmpPoint, camera);
        }
    }
}