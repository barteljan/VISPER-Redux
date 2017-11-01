//
//  Redux.swift
//  VISPER_Redux
//
//  Created by Jan Bartel on 31.10.17.
//

import Foundation


open class Redux<AppState> {
    
    open let store : Store<ObservableProperty<AppState>>
    
    open let reducerContainer : ReducerContainer
    
    open var reducerProvider : ReducerProvider {
        get {
            return self.reducerContainer
        }
    }
    
    open var actionDispatcher : ActionDispatcher {
        get {
            return self.store
        }
    }
    
    public init(appReducer: @escaping AppReducer<AppState>,
               initialState: AppState,
                 middleware: Middleware<AppState> = Middleware<AppState>(),
                 reducerContainer: ReducerContainer = ReducerContainerImpl()){
        
        self.reducerContainer = reducerContainer
        self.store = Store(appReducer: appReducer,
                            observable: ObservableProperty(initialState),
                       reducerProvider: reducerContainer,
                            middleware: middleware)
    }
    
}
