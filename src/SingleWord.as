package
{
    import flash.display.Sprite;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    
    public class SingleWord extends Sprite
    {
        protected var _txtStr:String;
        protected var _txt:TextField;
        protected var _bg:Sprite;
        protected var _bgColor:uint;
        protected var _borderColor:uint;
        protected var _originBgColor:uint;
        protected var _downBgColor:uint;
        
        protected var _tf:TextFormat;
        protected var _size:int;
        protected var _txtColor:uint;
        
        public function SingleWord(txtStr:String, bgColor:uint = 0xAAAAAA, borderColor:uint = 0xAAAAAA, size:uint = 40, txtColor:uint=0xFFFFFF)
        {
            _txtStr = txtStr;
            _bgColor = bgColor;
            _borderColor = borderColor;
            _originBgColor = _bgColor;
            _downBgColor = _bgColor;
            _size = size;
            _txtColor = txtColor;
            
            _bg = new Sprite();
            
            _tf = new TextFormat();
            _tf.align = TextFormatAlign.CENTER;
            _tf.color = _txtColor;
            _txt = new TextField();
            _txt.defaultTextFormat = _tf;
            _txt.antiAliasType = AntiAliasType.ADVANCED;
            _txt.x = 10;
            _txt.y = 10;
            _txt.mouseEnabled = false;
            
            text = _txtStr;

            setSize(_size);

            addChild(_bg);
            addChild(_txt);
            
            mouseChildren = false;
        }
        
        public function set text(value:String):void
        {
            cacheAsBitmap = false;
            
            _txtStr = value;
            _txt.text = _txtStr;
            _txt.width = _txtStr.length * (_size / 2 + 4);
            _txt.height = _size + 10;
            
            setBgSize(_txt.width+20, _txt.height+20);
        }
        
        public function get text():String
        {
            return _txtStr;
        }
        
        public function setSize(size:int):void
        {
            cacheAsBitmap = false;
            
            _size = size;
            _tf.size = _size;
            _txt.defaultTextFormat = _tf;
            _txt.setTextFormat(_tf);
            _txt.width = _txtStr.length * (_size / 2 + 4);
            _txt.height = _size + 4;
            
            setBgSize(_txt.width+20, _txt.height+20);
        }
        
        public function setBgColor(color:int):void
        {
            if(_bgColor == color)
            {
                return;
            }
            _bgColor = color;
            
            setBgSize(_txt.width+20, _txt.height+20);
        }
        
        public function setBgSize(bgWidth:uint, bgHeight:uint):void
        {
            cacheAsBitmap = false;
            
            _bg.graphics.clear();
            _bg.graphics.lineStyle(1, _borderColor);
            _bg.graphics.beginFill(_bgColor);
            _bg.graphics.drawRect(0,0,bgWidth,bgHeight);
            _bg.graphics.endFill();
            
            cacheAsBitmap = true;
        }
        
        public function setBgVisible(bool:Boolean):void
        {
            cacheAsBitmap = false;
            
            _bg.visible = bool;
            
            cacheAsBitmap = true;
        }
    }
}