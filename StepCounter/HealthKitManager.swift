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
    
    func getStepCount(completion: @escaping (Double, Error?) -> Void) {
        
        guard let stepCountType = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }

        // set predicate 
          let now = Date()
          let startOfDay = Calendar.current.startOfDay(for: now)
          let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
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
