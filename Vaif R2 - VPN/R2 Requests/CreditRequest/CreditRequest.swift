//
//  CreditRequest.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

import Foundation


enum PaymentAction {
    @available(*, deprecated) case apple(reciept: String)
    case token(token: String)

    var getType: String {
        switch self {
        case .apple: return "apple"
        case .token: return "token"
        }
    }

    var getKey: String {
        switch self {
        case .apple: return "Receipt"
        case .token: return "Token"
        }
    }

    var getValue: String {
        switch self {
        case .apple(reciept: let reciept): return reciept
        case .token(token: let token): return token
        }
    }
}

class CreditRequest<T: Response>: BaseApiRequest<T> {
    private let paymentAction: PaymentAction
    private let amount: Int

    init(api: APIService, amount: Int, paymentAction: PaymentAction) {
        self.paymentAction = paymentAction
        self.amount = amount
        super.init(api: api)
    }

    override var method: HTTPMethod { .post }

    override var path: String { super.path + "/v4/credit" }

    override var parameters: [String: Any]? {
        [
            "Amount": amount,
            "Currency": "USD",
            "Payment": ["Type": paymentAction.getType,
                        "Details": [paymentAction.getKey: paymentAction.getValue]
            ]
        ]
    }
}

final class CreditResponse: Response {
    var newSubscription: Subscription?

    override func ParseResponse(_ response: [String: Any]!) -> Bool {
        PMLog.debug(response.json(prettyPrinted: true))
        guard let code = response["Code"] as? Int, code == 1000 else {
            error = RequestErrors.creditDecode.toResponseError(updating: error)
            return false
        }
        
        return true
    }
}

