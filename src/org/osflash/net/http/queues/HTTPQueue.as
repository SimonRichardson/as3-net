package org.osflash.net.http.queues
{
	import org.osflash.logger.logs.error;
	import org.osflash.net.http.errors.HTTPError;
	import org.osflash.net.http.loaders.IHTTPLoader;
	import org.osflash.net.http.loaders.signals.HTTPLoaderObserver;
	import org.osflash.net.net_namespace;

	import flash.events.Event;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPQueue implements IHTTPQueue
	{
		
		/**
		 * @private
		 */
		private var _running : Boolean;
		
		/**
		 * @private
		 */
		private var _active : IHTTPLoader;
		
		/**
		 * @private
		 */
		private var _queue : Vector.<IHTTPQueueBinding>;
		
		/**
		 * @private
		 */
		private var _observer : HTTPLoaderObserver;
		
		public function HTTPQueue()
		{
			_queue = new Vector.<IHTTPQueueBinding>();
			
			_observer = new HTTPLoaderObserver();
			_observer.stopSignal.add(handleStopSignal);
			_observer.completeSignal.add(handleCompleteSignal);
			_observer.ioErrorSignal.add(handleErrorSignal);
			_observer.securityErrorSignal.add(handleCompleteSignal);
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(loader : IHTTPLoader) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			if(contains(loader)) throw new ArgumentError('Can not add loader more than once');
			
			_queue.push(new HTTPQueueBinding(loader, 0));
			
			if(!_running) advance();
			
			return loader;
		}
				
		/**
		 * @inheritDoc
		 */
		public function remove(loader : IHTTPLoader) : IHTTPLoader
		{
			if(null == loader) throw new ArgumentError('Loader can not be null');
			
			if(_active == loader) 
			{
				_active.unregisterObservable(_observer);
				
				_active.stop();
				_active = null;
					
				_running = false;
					
				advance();
			}
			else
			{
				const index : int = getIndex(loader);
				if(index >= 0)
				{
					loader.unregisterObservable(_observer);
					
					const bindings : Vector.<IHTTPQueueBinding> = _queue.splice(index, 1);
					if(bindings.length > 1) throw new HTTPError('HTTPQueue Buffer Overflow');
					
					const binding : IHTTPQueueBinding = bindings[0];
					if(binding.loader != loader) throw new HTTPError('IHTTPLoader mismatch');
										
					advance();	
				}
			}
			
			return loader;
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(loader : IHTTPLoader) : Boolean
		{
			if(_active == loader) return true;
			
			var index : int = _queue.length;
			while(--index > -1)
			{
				const binding : IHTTPQueueBinding = _queue[index];
				if(binding.loader == loader) return true;
			}
			
			return false;
		}

		/**
		 * @inheritDoc
		 */
		public function advance() : void
		{
			if(_running) return;
			
			if(_queue.length > 0)
			{
				const binding : IHTTPQueueBinding = _queue.shift();
				if (null == binding)
				{
					throw new HTTPError('Binding can not be null, mismatch occured');
						
					_running = false;
					return;
				}
				else
				{
					_active = binding.loader;
					if(null == _active)
					{
						throw new HTTPError('Active can not be null, mismatch occured');
						
						_running = false;
						return;
					}
				}
			}
			else
			{
				_active = null;
				_running = false;
				return;
			}
			
			_running = true;
			
			try
			{
				_active.registerObservable(_observer);
				_active.start(this);
			}
			catch(http : HTTPError)
			{
				try
				{
					_active.stop();
				}
				catch(stopError : Error)
				{
					error('HTTPQueue Error', stopError);
				}
				finally
				{
					remove(_active);
				}
			}
			catch(startError : Error)
			{
				throw startError;
			}
		}
		
		/**
		 * @private
		 */		
		private function getIndex(loader : IHTTPLoader) : int
		{
			var index : int = _queue.length;
			while(--index > -1)
			{
				const binding : IHTTPQueueBinding = _queue[index];
				if(binding.loader == loader) return index;
			}
			return -1;
		}
		
		/**
		 * @private
		 */
		private function handleErrorSignal(loader : IHTTPLoader, event : Event) : void
		{
			remove(loader);
		}

		/**
		 * @private
		 */
		private function handleCompleteSignal(loader : IHTTPLoader, event : Event) : void
		{
			remove(loader);
		}

		/**
		 * @private
		 */
		private function handleStopSignal(loader : IHTTPLoader) : void
		{
			remove(loader);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return (null == _active ? 0 : 1) + _queue.length; }
		
		net_namespace function get queue() : Vector.<IHTTPQueueBinding> { return _queue; }
	}
}
