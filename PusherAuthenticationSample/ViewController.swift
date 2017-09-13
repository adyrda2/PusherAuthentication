import UIKit
import PusherSwift

class ViewController: UIViewController, PusherDelegate, AuthRequestBuilderProtocol {
    var client: Pusher?
    var channel: PusherChannel?
    var options: PusherClientOptions?
    var appKey: String?
    var channelName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        startSubscription()
    }

    func getKey(completion: @escaping ()-> Void) {
        let url = Bundle.main.url(forResource: "Test", withExtension: "plist")
        let dict = NSDictionary(contentsOf: url!) as? [String: Any]

        if let dict = dict {
            appKey = dict["appKey"] as? String
            channelName = dict["channelName"] as? String
            completion()
        }
    }

    func startSubscription() {
        getKey {
            self.subscribeToPresenceChannel()
        }
    }

    func subscribeToPresenceChannel() {
        options = PusherClientOptions(
            authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder())
        )
        client = Pusher(withAppKey: appKey!, options: options!)
        client?.connection.delegate = self
        channel = client?.subscribeToPresenceChannel(channelName: channelName!)
        client?.connect()
    }
}
