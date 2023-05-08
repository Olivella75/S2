db.dropDatabase();

db.createCollection("pizzeria", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["order"],
            properties: {
                orders: {
                    bsonType: "object",
                    required: ["customer"],
                    properties: {
                        customer : {
                            bsonType: "object",
                            required: ["name", "last_name", "address", "zipcode", "city", "region", "phone"],
                            properties: {
                                name: {bsonType: "string"},
                                last_name: {bsonType: "string"},
                                address: {bsonType: "string"},
                                zipcode: {bsonType: "string"},
                                city: {bsonType: "string"},
                                region: {bsonType: "string"},
                                phone: {bsonType: "number"}
                            }
                        }, time : {
                            bsonType: "object",
                            required: [time, delivery],
                            properties: {
                                time: {bsonType: "date"},
                                delivery: {bsonType: "string"}
                            }
                        }, empdelivery: {
                            bsonType: "object",
                            required: ["name", "last_name", "nif", "phone", "employment"],
                            properties: {
                                name: {bsonType: "string"},
                                last_name: {bsonType: "string"},
                                nif: {bsonType: "string"},
                                phone: {bsonType: "number"},
                                employment: {bsonType: "string"}
                            }
                        }, store: {
                            bsonType: "object",
                            required: ["address", "zipcode", "city", "region"],
                            properties: {
                                address: {bsonType: "string"},
                                zipcode: {bsonType: "string"},
                                city: {bsonType: "string"},
                                region: {bsonType: "string"}
                            }
                        }
                    }, price: {
                        bsonType: "object",
                        properties: {
                            price: {bsonType: "number"}
                        }
                    }, store: {
                        bsonType: "object",
                        required: ["address", "zipcode", "city", "region"],
                        properties: {
                            address: {bsonType: "string"},
                            zipcode: {bsonType: "string"},
                            city: {bsonType: "string"},
                            region: {bsonType: "string"}
                        }
                    }
                }, products: {
                    bsonType: "object",
                    required: ["name", "type", "description", "category", "image", "price"],
                    properties: {
                        name: {bsonType: "string"},
                        type: {bsonType: "string"},
                        description: {bsonType: "string"},
                        category: {bsonType: "string"},
                        image: {bsonType: "string"},
                        price: {bsonType: "number"}
                    }
                }, quantity: {
                    bsonType: "object",
                    properties: {
                        quantity: {bsonType: "number"}
                    }
                }
            }
        }
    }
});