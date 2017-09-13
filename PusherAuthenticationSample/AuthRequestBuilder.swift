import Foundation
import PusherSwift

class AuthRequestBuilder: AuthRequestBuilderProtocol {
    @objc func requestFor(socketID: String, channelName: String) -> URLRequest? {
        var request = URLRequest(url: URL(string: "http://localhost:3000/pusher-auth")!)
        request.httpMethod = "POST"
        request.httpBody = "socket_id=\(socketID)&channel_name=\(channelName)".data(using: String.Encoding.utf8)
        print("socketID: \(socketID), ChannelName: \(channelName)")
        request.addValue("1234567890", forHTTPHeaderField: "Authorization")
        return request
    }
}
