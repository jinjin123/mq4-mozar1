//+------------------------------------------------------------------+
//|                                                      mozar_1.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
      
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
      
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   myFunction();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   myFunction();
  }
//+------------------------------------------------------------------+

extern int pip_stop_loss_from_current_position = 10;
extern bool use_stop_loss_from_current_position = true;


void myFunction(){
   checkStopLoss();
}

void checkStopLoss(){
   int numOrder = OrdersTotal();
   //printf("jumlah order = %d", numOrder);
   for(int i=0; i < numOrder; i++){
      if(OrderSelect(i, SELECT_BY_POS) == false){
         continue;
      }
      if(OrderSymbol() != Symbol()){
         continue;
      }
      //printf("order id = %d order type = %d", OrderTicket(), OrderType());
      if(OrderType() == 0){//buy
         stopLossBuy();
      }else if(OrderType() == 1){
         stopLossSell();
      }
   }
}

double zeroDoubleLimit = 0.000001;

void stopLossBuy(){
   printf("stop loss buy for id = %d, stop loss = %f", OrderTicket(), OrderStopLoss());
   if(use_stop_loss_from_current_position){
      if(OrderStopLoss() < zeroDoubleLimit){
         //stop loss belum di set
         
      }
   }
}
void stopLossSell(){
   printf("stop loss sell for id = %d", OrderTicket());
}
