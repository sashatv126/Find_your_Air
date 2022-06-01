struct Weight {
    let bagWeight : Double
    var perKg : Double = 1.0
    
    init(bagWeight: Double) {
        self.bagWeight = bagWeight
        getMultiplicator(bagWeight: bagWeight)
    }
    
    mutating private func getMultiplicator(bagWeight : Double) {
        var border = 20.0
        if bagWeight > border {
            while bagWeight > border {
                border += 1
                perKg += 0.05
            }
        }
        
    }
    
}


