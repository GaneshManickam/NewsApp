//
//  BehaviorRelay+Extension.swift
//  Demo
//
//  Created by Ganesh Manickam on 11/04/21.
//

import Foundation
import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {

       func append(_ subElement: Element.Element) {
           var newValue = value
           newValue.append(subElement)
           accept(newValue)
       }

       func append(contentsOf: [Element.Element]) {
           var newValue = value
           newValue.append(contentsOf: contentsOf)
           accept(newValue)
       }

       public func remove(at index: Element.Index) {
           var newValue = value
           newValue.remove(at: index)
           accept(newValue)
       }

       public func removeAll() {
           var newValue = value
           newValue.removeAll()
           accept(newValue)
       }

   }
