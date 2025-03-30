//
//  Response.swift
//  TestMELI
//
//  Created by Taylor Jefte da silva on 27/03/25.
//

enum Response<T> {
    case success(T)
    case failure(APIError)
    case loading(Bool)
}
