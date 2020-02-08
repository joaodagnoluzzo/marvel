//
//  Error.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import Foundation

enum SystemError: Error {
    case httpRequestError
    case jsonDecodeError
    case genericError
}

extension SystemError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .httpRequestError:
            return NSLocalizedString("Check your internet connection.", comment: "")
        case .jsonDecodeError:
            return NSLocalizedString("Please, try again.", comment: "")
        default:
            return NSLocalizedString("Something went wrong.", comment: "")
        }
    }
}
