//
//  NetworkError.swift
//  NewsApp
//
//  Created by A Mairam on 9/10/24.
//

import Foundation

enum NetworkError: Error {
    case wrongURL
    case requestFaild
    case decodingFaild
    case unknownError
}
