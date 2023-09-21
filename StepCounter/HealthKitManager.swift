import HealthKit

class HealthKitManager {
        
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
    
    func getStepCount(for date: Date, completion: @escaping (Double, Error?) -> Void) {
    
        guard let stepCountType = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }
        
        let startOfDay = Calendar.current.startOfDay(for: date)
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        let endOfDay = Calendar.current.date(byAdding: components, to: startOfDay)

        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: endOfDay,
            options: .strictStartDate
        )
          
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            if let result = result, let sum = result.sumQuantity() {
                let count = sum.doubleValue(for: HKUnit.count())
                completion(count, nil)
            } else {
                completion(0.0, error)
            }
        }
        store.execute(query)
    }
}
