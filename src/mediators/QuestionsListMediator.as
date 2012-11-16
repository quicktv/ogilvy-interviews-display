package mediators
{
	import controllers.signals.UpdateAnswers;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import models.signals.QuestionsChanged;
	
	import mx.collections.IList;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.QuestionsList;
	
	public class QuestionsListMediator extends Mediator
	{
		[Inject] public var view:QuestionsList;
		
		[Inject] public var questionsChanged:QuestionsChanged;
		
		[Inject] public var updateAnswers:UpdateAnswers;
		
		private var _timer:Timer;
		
		private function get timer():Timer
		{
			if (!_timer)
			{
				_timer = new Timer(1000);
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
			}
			
			return _timer;
		}
		
		public function QuestionsListMediator()
		{
			super();
		}
		
		public override function onRegister():void
		{
			questionsChanged.add(onQuestionsChanged);
		}
		
		public override function onRemove():void
		{
			questionsChanged.remove(onQuestionsChanged);
		}
		
		private function onQuestionsChanged(value:IList):void 
		{
			view.dataProvider = value;
			
			if (value && !timer.running)
			{
				timer.start();
			}
			else if (!value && !timer.running)
			{
				timer.stop();
			}
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			updateAnswers.dispatch();
		}
	}
}