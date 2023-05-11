local ParkingMeters = {
    "prop_parknmeter_01",
    "prop_parknmeter_02"
}

exports['qb-target']:AddTargetModel(ParkingMeters, {
    options = {
        {
            type = "client",
            event = "gz_parkingmeter:client:payParking",
            icon = "fas fa-parking",
            label = "Pay Parking ($5)",
        },
        { 	
            type = "client",
            event = "gz_parkingmeter:client:checkParking",
            icon = "fas fa-parking",
            label = "Check payment",
            job = { "police", "sheriff" },
        },
    },
    distance = 2.5,
})
