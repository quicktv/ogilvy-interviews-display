package operations
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import qtv.operations.impl.AbstractOperation;
	
	public class HttpOperation extends AbstractOperation
	{
		CONFIG::debug {
			private static const logger:ILogger = getLogger(HttpOperation);
		}
		
		protected var _responseProcessor:IResponseProcessor;
		
		protected function get method():String
		{
			return URLRequestMethod.GET;
		}
		
		protected function get requestContentType():String 
		{
			return "application/x-www-form-urlencoded.";
		}
		
		protected var _args:URLVariables;
		
		protected var _url:String;
		
		protected function get url():String 
		{
			if (method == URLRequestMethod.GET)
			{
				return _url + "?" + _args.toString();
			}
			
			return _url;
		}
		
		protected var _format:String;
		
		protected function get formatString():String 
		{
			return _format ? "." + _format : "";
		}
		
		private var _loader:URLLoader;
		
		protected function get loader():URLLoader
		{
			return _loader ||= new URLLoader();
		}
		
		protected function get request():URLRequest
		{
			var request:URLRequest = new URLRequest(url);
			request.method = method;
			if (method != URLRequestMethod.GET) request.data = _args;
			
			return request;
		}
		
		public function HttpOperation(responseProcessor:IResponseProcessor, url:String, args:URLVariables)
		{
			super();
			
			_responseProcessor = responseProcessor;
			_url = url;
			_args = args;
		}
		
		public override function execute():void
		{
			loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onLoaderHttpStatus);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOError);
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			CONFIG::debug {
				logger.debug("calling '{0}'", [url]);
			}
			
			loader.load(request);
		}
		
		protected function onLoaderComplete(e:Event):void 
		{
			dispatchComplete(_responseProcessor.process(_loader.data));
		}
		
		protected function onLoaderHttpStatus(e:HTTPStatusEvent):void 
		{
			
		}
		
		protected function onLoaderIOError(e:IOErrorEvent):void 
		{
			dispatchError(e);
		}
	}
}