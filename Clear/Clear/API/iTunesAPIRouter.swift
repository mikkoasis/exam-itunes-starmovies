//
//  iTunesAPIRouter.swift
//  Clear
//
//  Created by Adrian Mikko Asis on 8/12/20.
//  Copyright © 2020 Adrian Mikko Asis. All rights reserved.
//

import Alamofire
import Foundation

public enum iTunesAPIRouter: URLRequestConvertible {
  static let baseURLPath = "https://itunes.apple.com"

  case movie(term: String, limit: Int, offset: Int)

  var method: HTTPMethod {
    switch self {
    case .movie:
      return .get
    }
  }

  var path: String {
    switch self {
    default:
      return "/search"
    }
  }

  var parameters: [String: Any] {
    switch self {
    case .movie(let term, let limit, let offset):
      var parameters: [String: Any] = ["media": "movie", "country": "au"]
      parameters["term"] = term
      parameters["limit"] = limit
      parameters["offset"] = offset
      return parameters
    }
  }

  public func asURLRequest() throws -> URLRequest {
    let url = try iTunesAPIRouter.baseURLPath.asURL()
    var request = URLRequest(url: url.appendingPathComponent(path))

    request.httpMethod = method.rawValue

    return try URLEncoding.default.encode(request, with: parameters)
  }
}
