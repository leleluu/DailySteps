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
    
    func getStepCount(for numberOfDaysSinceToday: Int, completion: @escaping (Double, Error?) -> Void) {
    
        guard numberOfDaysSinceToday <= 0 else { return }
        guard let stepCountType = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }
    
        guard let targetDate = Calendar.current.date(byAdding: .day, value: numberOfDaysSinceToday, to: Date.now) else { return }
        
        let startOfTargetDate = Calendar.current.startOfDay(for: targetDate)
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        let endOfTargetDate = Calendar.current.date(byAdding: components, to: startOfTargetDate)


          let predicate = HKQuery.predicateForSamples(
            withStart: startOfTargetDate,
            end: endOfTargetDate,
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
