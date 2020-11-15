//
//  CallbacksDefinition.swift
//  weather
//
//  Created by David Parizek on 13/11/2020.
//

import Foundation

typealias GenericCallback<T> = ((T) -> Void)
typealias VoidCallback = (() -> Void)
