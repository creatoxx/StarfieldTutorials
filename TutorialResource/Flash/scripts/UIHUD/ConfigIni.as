package UIHUD
{
   public class ConfigIni
   {
      
      private static var _classInstance:UIHUD.ConfigIni;
       
      
      public var Encumbrance_bMassLeftToRight = 0;
      
      public var Encumbrance_sEncTextColor:String = "#FFFFFF";
      
      public var Encumbrance_sEncTextColor80:String = "#FF9900";
      
      public var Encumbrance_sEncTextColor90:String = "#FF6600";
      
      public var Encumbrance_sEncTextColor100:String = "#800000";
      
      public var Encumbrance_sEncTextColorMax:String = "#FFFFFF";
      
      public var Encumbrance_fEncCurrentMassY = 518;
      
      public var Encumbrance_fEncCurrentMassX = 590;
      
      public var Encumbrance_fEncMaxMassY = 518;
      
      public var Encumbrance_fEncMaxMassX = 758;
      
      public var Encumbrance_sMassLabel:String = "Mass";
      
      public var Encumbrance_sMetricMass:String = "kg";
      
      public var Encumbrance_sCreditLabel:String = "Cr";
      
      public var Experience_sExpCurTextColor:String = "#FFFFFF";
      
      public var Experience_sExpNxtTextColor:String = "#FFFFFF";
      
      public var Experience_fExpCurrentExpY = 548;
      
      public var Experience_fExpCurrentExpX = 535;
      
      public var Experience_fExpNextExpY = 548;
      
      public var Experience_fExpNextExpX = 701;
      
      public var Experience_sLevelLabel:String = "Level";
      
      public var Time_sTimeTextColor:String = "#FFFFFF";
      
      public var Time_fTimeHorY = 548;
      
      public var Time_fTimeVerX = 971;
      
      public var Time_sTimeLabel:String = "Time";
      
      public function ConfigIni()
      {
         super();
         if(_classInstance)
         {
            Trace("ConfigIni initialized.");
         }
         _classInstance = this;
      }
      
      public static function getInstanceClass() : UIHUD.ConfigIni
      {
         if(!_classInstance)
         {
            _classInstance = new UIHUD.ConfigIni();
         }
         return _classInstance;
      }
      
      public function applyData(extData:Object) : void
      {
         for(var section in extData)
         {
            for(var variable in extData[section])
            {
               var sPropertyString:String = section + "_" + variable;
               if(this.hasOwnProperty(sPropertyString))
               {
                  this[sPropertyString] = extData[section][variable];
               }
            }
         }
      }
   }
}
