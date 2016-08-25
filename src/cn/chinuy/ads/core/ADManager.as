package cn.chinuy.ads.core {
	import cn.chinuy.ads.core.position.IPosition;
	import cn.chinuy.ads.core.provider.IProvider;
	
	/**
	 * @author chin
	 */
	public class ADManager {
		
		private var positions : Object = {};
		private var providers : Object = {};
		
		private var providerPool : Object = {};
		
		public function unloadAll() : void {
			for( var i : String in positions )
				unload( i );
		}
		
		public function unload( positionName : String ) : void {
			var position : IPosition = getPosition( positionName );
			if( position )
				position.unload();
		}
		
		public function load( request : ADRequest ) : Boolean {
			var s : Boolean = hasPosition( request.position );
			if( s )
				getPosition( request.position ).load( request );
			return s;
		}
		
		public function addPosition( name : String, position : IPosition ) : void {
			position.manager = this;
			positions[ name ] = position;
		}
		
		public function getPosition( name : String ) : IPosition {
			return positions[ name ];
		}
		
		public function removePosition( name : String ) : void {
			var position : IPosition = positions[ name ];
			if( position ) {
				position.destroy();
				if( position.parent ) {
					position.parent.removeChild( position.displayObject );
				}
				delete positions[ name ];
			}
		}
		
		public function hasPosition( name : String ) : Boolean {
			return positions[ name ] != null;
		}
		
		public function addProvider( name : String, providerClass : Class ) : void {
			providers[ name ] = providerClass;
		}
		
		public function removeProvider( name : String ) : void {
			delete providers[ name ];
		}
		
		public function hasProvider( name : String ) : Boolean {
			return providers[ name ] != null;
		}
		
		public function getProvider( name : String ) : IProvider {
			if( hasProvider( name )) {
				var provider : IProvider;
				var pool : Array = providerPool[ name ];
				if( pool != null && pool.length > 0 ) {
					provider = pool.shift();
				} else {
					var ProviderClass : Class = providers[ name ];
					provider = new ProviderClass() as IProvider;
					if( provider != null ) {
						provider.addEventListener( ADEvent.ProviderDestroy, destroyHandler( name, provider ));
					}
				}
			}
			return provider;
		}
		
		private function destroyHandler( name : String, provider : IProvider ) : Function {
			return function( e : ADEvent ) : void {
				var pool : Array = providerPool[ name ];
				if( pool == null )
					providerPool[ name ] = pool = [];
				pool.push( provider );
			}
		}
	
	}
}
