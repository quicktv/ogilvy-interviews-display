package controllers
{
	import controllers.commands.BootstrapCommand;
	import controllers.commands.UpdateAnswersCommand;
	import controllers.signals.Bootstrap;
	import controllers.signals.UpdateAnswers;
	
	import flash.display.DisplayObjectContainer;
	
	import mediators.ApplicationContainerMediator;
	import mediators.QuestionsListMediator;
	
	import models.signals.QuestionsChanged;
	
	import org.robotlegs.mvcs.SignalContext;
	
	import services.ApplicationService;
	
	import views.ApplicationContainer;
	import views.QuestionsList;
	
	public class ApplicationContext extends SignalContext
	{
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		public override function startup():void
		{
			injector.mapSingleton(ApplicationService);
			injector.mapSingleton(QuestionsChanged);
			
			mediatorMap.mapView(ApplicationContainer, ApplicationContainerMediator);
			mediatorMap.mapView(QuestionsList, QuestionsListMediator);
			
			signalCommandMap.mapSignalClass(Bootstrap, BootstrapCommand);
			signalCommandMap.mapSignalClass(UpdateAnswers, UpdateAnswersCommand);
		}
	}
}