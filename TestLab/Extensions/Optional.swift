//
//  Optional.swift
//  TestLab
//
//  Created by Randolph on 5/10/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

extension Optional where Wrapped: Collection {
    public var isBlank: Bool {
        switch(self) {
        case .none:
            return true
        case .some(let concreteSelf):
            return concreteSelf.isEmpty
        }
    }
}

