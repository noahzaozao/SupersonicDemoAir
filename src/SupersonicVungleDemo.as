package
{
    import com.supersonic.mediation.Supersonic;
    import com.supersonic.mediation.SupersonicError;
    import com.supersonic.mediation.SupersonicEvent;
    import com.supersonic.mediation.SupersonicPlacement;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.system.Capabilities;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class SupersonicVungleDemo extends Sprite
    {
        private var statusText:TextField;
        
        public function SupersonicVungleDemo()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
        }
        
        protected function onAddToStage(e:Event):void
        {
            Supersonic.getInstance.addEventListener( "onRewardedVideoInitSuccess" ,onRVInitSuccess );
            Supersonic.getInstance.addEventListener("onRewardedVideoAdRewarded", onRVAdRewarded);
            Supersonic.getInstance.addEventListener( "onRewardedVideoAvailabilityChanged" ,onRVAvailabilityChange);
            Supersonic.getInstance.addEventListener( "onRewardedVideoInitFailed" ,onRVInitFailed);
            Supersonic.getInstance.addEventListener( "onRewardedVideoAdOpened" ,onRVAdOpened);
            Supersonic.getInstance.addEventListener( "onRewardedVideoAdClosed" ,onRVAdClosed);
            Supersonic.getInstance.addEventListener( "onRewardedVideoAdEnded" ,onRVAdEnded);
            Supersonic.getInstance.addEventListener( "onRewardedVideoAdStarted" ,onRVAdStarted);
            Supersonic.getInstance.addEventListener( "onRewardedVideoFailed" ,onRVFailed);
            
            if(Capabilities.manufacturer.indexOf("Android") == -1)
            {
                Supersonic.getInstance.initInterstitial("3b3e1d31", "SupersonicVungleDemoIOS");
                Supersonic.getInstance.initRewardedVideo("3b3e1d31", "SupersonicVungleDemoIOS");
            }
            else
            {
                Supersonic.getInstance.initInterstitial("3c0c6ae1", "SupersonicVungleDemoIOS");
                Supersonic.getInstance.initRewardedVideo("3c0c6ae1", "SupersonicVungleDemoIOS");
            }
            // 支持 autoOrient
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            
            var btnShowInterstitial:Button = new Button("Show Interstitial");
            btnShowInterstitial.x = 10;
            btnShowInterstitial.y = 10;
            
            var btnShowRewardedVideo:Button = new Button("Show RewardedVideo");
            btnShowRewardedVideo.x = 10;
            btnShowRewardedVideo.y = 100;

            var tf:TextFormat = new TextFormat();
            tf.size = 20;
            statusText = new TextField();
            statusText.defaultTextFormat = tf;
            statusText.x = 10;
            statusText.y = 200;
            statusText.width = 600;
            statusText.height = 500;
            statusText.text = "Status: waiting for initialize...\n";
            
            addChild(statusText);
            addChild(btnShowInterstitial);
            addChild(btnShowRewardedVideo);
            
            btnShowInterstitial.addEventListener(MouseEvent.MOUSE_UP, onShowInterstitialHandler);
            btnShowRewardedVideo.addEventListener(MouseEvent.MOUSE_UP, onShowRewardedVideoHandler);
        }
        
        protected function onShowRewardedVideoHandler(e:MouseEvent):void
        {
            Supersonic.getInstance.showRewardedVideo();
        }
        
        protected function onShowInterstitialHandler(e:MouseEvent):void
        {
            Supersonic.getInstance.showInterstitial();
        }
        
        /**
         * Invoked each time an ad is available, at this point you can show the user
         * some in-game traffic driver.
         **/
        private function onRVInitSuccess(event : SupersonicEvent):void{

            trace("RVInitSuccess");
            statusText.appendText("RVInitSuccess\n");
            statusText.scrollV = statusText.maxScrollV;
            
        }
        
        /**
         * Invoked each time an ad fails to return, or if you have a problem in
         * the integration
         * @param event.message - the reason for the init failure
         **/
        private function onRVInitFailed(event : SupersonicError):void{
            
            trace("RVInitFail  : " + event.errorCode +"  "+event.errorMessage);
            
        }
        
        /**
         * Invoked when there is a update on ads availability 
         * At this point you can hide/show the in-game traffic driver from/to the user
         */
        private function onRVAvailabilityChange(event : SupersonicEvent):void{
            
            if(event.message == "true"){
                
                trace("You can now show RV");
                statusText.appendText("You can now show RV\n");
                statusText.scrollV = statusText.maxScrollV;
            }
                
            else {
                
                trace("RV is not available");
                statusText.appendText("RV is not available\n");
                statusText.scrollV = statusText.maxScrollV;
            }
        }
        
        /*
        * Invoked when the user should be rewarded according to the value in the
        * credits parameter.
        * @param event -  the credits amount and name.
        */
        private function onRVAdRewarded(event : SupersonicPlacement):void{
            
            trace("ad rewaeded" + event.rewardAmount + "  " + event.rewardName);
            
        }
        
        /*
        * Invoked after the rewarded video screen has opened.
        */
        private function onRVAdOpened(event : SupersonicEvent):void{
            
            trace("RV Ad Opened");
            
        }   
        
        /*
        * Invoked after the rewarded video screen has closed.
        */
        private function onRVAdClosed(event : SupersonicEvent):void{
            
            trace("RV Ad Closed");
            
        } 
        
        /*
        * Invoked after the rewarded video finished playing.
        */
        private function onRVAdEnded(event : SupersonicEvent):void{
            
            trace("RV Ad Ended");
            
        }
        
        /*
        * Invoked after the rewarded video started playing.
        */
        private function onRVAdStarted(event : SupersonicEvent):void{
            
            trace("RV Ad Started");
            
        }
        
        /*
        * Invoked after the rewarded video screen has opened.
        */
        private function onRVFailed(event : SupersonicError):void{
            
            trace("RV Fail  : " + event.errorCode +"  "+event.errorMessage);
            statusText.appendText("RV Fail  : " + event.errorCode +"  "+event.errorMessage + "\n");
            statusText.scrollV = statusText.maxScrollV;
            
        } 
    }
}