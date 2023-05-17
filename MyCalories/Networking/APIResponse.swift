//
//  APIResponse.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
