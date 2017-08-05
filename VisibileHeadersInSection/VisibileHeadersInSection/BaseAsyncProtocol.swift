//
//  BaseAsyncProtocol.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright (c) 2017 Ohad Maor. All rights reserved.
//

import Foundation

protocol BaseAsyncProtocol : class
{
    func didFinish(responseType : BaseGeneralResponse.CommonType?)
}

struct BaseGeneralResponse
{
    enum CommonType
    {
        case refreshData
        case noData
    }
}
