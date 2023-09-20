import HealthKit

class HealthHitManager {
    
    // MARK: - Properties
    
    private let store = HKHealthStore()
    
    // MARK: - Methods
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {

        let readTypes: Set<HKObjectType> = [
            HKSampleType.quantityType(forIdentifier: .stepCount)!
        ]
        store.requestAuthorization(toShare: nil, read: readTypes) { (success, error) in
            completion(success, error)
        }
    }
}
