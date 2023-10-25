package
{
   import Shared.Components.ButtonControls.ButtonBar.ButtonBar;
   import UIHUD.ConfigIni;
   import UIHUD.ConfigLoader;
   
   public dynamic class MonocleButtonBar extends ButtonBar
   {
       
      
      public var configIni:ConfigIni;
      
      public var configLoader:ConfigLoader;
      
      public function MonocleButtonBar()
      {
         super();
         configIni = ConfigIni.getInstanceClass();
         configLoader = new ConfigLoader();
         configLoader.prepareFile("UI_HUD.ini",OnConfigLoaded,false);
      }
      
      public function OnConfigLoaded(data:Object) : void
      {
         if(data != null)
         {
            configIni.applyData(data);
            return;
         }
      }
   }
}
