// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif













class URLSessionDataTaskProtocolMock: URLSessionDataTaskProtocol {

//MARK: - resume

var resumeCallsCount = 0
var resumeCalled: Bool {
return resumeCallsCount > 0
}
var resumeClosure: (() -> Void)?

func resume() {
resumeCallsCount += 1
resumeClosure?()
}

}
class URLSessionProtocolMock: URLSessionProtocol {

//MARK: - dataTask

var dataTaskWithCompletionHandlerCallsCount = 0
var dataTaskWithCompletionHandlerCalled: Bool {
return dataTaskWithCompletionHandlerCallsCount > 0
}
var dataTaskWithCompletionHandlerReceivedArguments: (request: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)?
var dataTaskWithCompletionHandlerReturnValue: URLSessionDataTaskProtocol!
var dataTaskWithCompletionHandlerClosure: ((URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol)?

func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
dataTaskWithCompletionHandlerCallsCount += 1
dataTaskWithCompletionHandlerReceivedArguments = (request: request, completionHandler: completionHandler)
return dataTaskWithCompletionHandlerClosure.map({ $0(request, completionHandler) }) ?? dataTaskWithCompletionHandlerReturnValue
}

}
