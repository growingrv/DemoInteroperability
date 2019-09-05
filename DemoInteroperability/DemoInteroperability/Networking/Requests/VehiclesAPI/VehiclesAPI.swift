//
//  Vehicles.swift
//  DemoInteroperability
//
//  Created by Gaurav Tiwari on 26/07/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import Foundation

// Making VehiclesAPI class compatible to Objective C by NSObject inheritence & adding @objc keyword.
@objc class VehiclesAPI : NSObject {
    typealias Model = VehiclesAPIResource.Model
    let resource : VehiclesAPIResource
    let apiRequest : APIRequest <VehiclesAPIResource>
    
    // Making VehiclesAPI class initializer compatible to Objective C by adding @objc keyword.
    @objc init(p1Lat: Double, p1Long: Double, p2Lat: Double, p2Long: Double) {
        resource = VehiclesAPIResource (p1Lat: p1Lat, p1Long: p1Long, p2Lat: p2Lat, p2Long: p2Long)
        self.apiRequest = APIRequest(resource: resource)
    }
    
    func fetchVehicles() -> Task <[Vehicle], Error> {
        let task = Task<[Vehicle], Error> {  result in
            
            self.apiRequest.load() { data, response, error in
                self.handleResponse(data: data, response: response, error: error) { apiResult in
                    return result(apiResult)
                }
            }
        }
        return task
    }
}

// Following extension to VehiclesAPI acts as a Objective C wrapper for VehiclesAPI class
extension VehiclesAPI {
    // Following method is called from Objective C classes and acts as an interface between VehiclesAPI's fetchVehiclesData and Objective C callee.
    // This is done to minimize the changes in fetchVehiclesData function. e.g. using a Swift specific return type (a Generic)
    // Making following method compatible to Objective C by adding @objc keyword.
    @objc func fetchVehiclesForMap(completion: @escaping ([Vehicle]?, Error?) -> ()) {
        let _ = fetchVehicles().response { result in
            switch result {
            case .response (let vehicles):
                completion (vehicles, nil)
            case .error (let error):
                completion (nil, error)
            }
        }
    }
}

// Following extension to VehiclesAPI is used to handle API Response and to create respective Model
extension VehiclesAPI {
    private func handleResponse (data: Data?, response: URLResponse?, error: Error?, completion: @escaping (APIResult<Model>)->() ) {
        if let error = error {
            completion (APIResult.error(NetworkError.response(error.localizedDescription)))
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion (APIResult.error(NetworkError.response("Can not Convert Response To HTTPURLResponse")))
            return
        }
        
        guard (200 ..< 300) ~= httpResponse.statusCode else {
            completion(APIResult.error(NetworkError.invalidStatusCode(httpResponse.statusCode)))
            return
        }
        
        guard let newData = data else {
            completion (APIResult.error(NetworkError.response("No Data")))
            return
        }
        
        do {
            let model = try self.makeModel(newData)
            completion (APIResult.response(model as Model))
        }
        catch let error {
            completion (APIResult.error(NetworkError.parse(error)))
        }
    }
    
    private func makeModel(_ data: Data) throws -> Model {
        if let recvdData = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject] {
            let vehiclesData = recvdData[VehicleAPIResponseKeys.vehiclePOIList.key] as! Array<Any>
            let model = VehicleList(vehiclesTemp: vehiclesData)
            return model.vehicles
        }
            
        else {
            return [] as! VehiclesAPIResource.Model
        }
    }
}
