// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Order: Decodable {
    let id: String
    let number: Int
    let productId: String
    let productPrevieew: String
    let productQuantity: Int
    let productSize: String
    let createdAt: Date
    let etd: String
    let deliveryAddress: String
    let status: OrderStatus
}
