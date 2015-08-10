package
{
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;

    public class Button extends SingleWord
    {
        public function Button(worldStr:String, bgColor:uint=0xAAAAAA, borderColor:uint = 0xAAAAAA, size:uint=40, downColor:uint=0x0, textColor:uint = 0xffffff)
        {
            super(worldStr, bgColor, borderColor, size, textColor);

            _downBgColor = downColor;
            
            addEventListener(MouseEvent.MOUSE_DOWN, onDownHandler);
            addEventListener(MouseEvent.MOUSE_UP, onUpHandler);
            addEventListener(TouchEvent.TOUCH_BEGIN, onDownHandler);
            addEventListener(TouchEvent.TOUCH_END, onUpHandler);
            addEventListener(TouchEvent.TOUCH_OUT, onUpHandler);
        }
        
        protected function onUpHandler(e:*):void
        {
            setBgColor(_originBgColor);
        }
        
        protected function onDownHandler(e:*):void
        {
            setBgColor(_downBgColor);
        }
    }
}