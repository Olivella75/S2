db.dropDatabase();

db.createCollection("videos", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id", "title", "description", "sizeMB", "file_name", "duration", "thumbnail", "reproductions", "likes_count", "dislikes_count", "label", "status", "publications_date", "coments"],
            properties: {
                id: {bsonType: "objectId"},
                title: {bsonType: "string"},
                description: {bsonType: "string"},
                sizeMb: {bsonType: "number"},
                file_name: {bsonType: "string"},
                duration: {bsonType: "number"},
                thumbnail: {bsonType: "string"},
                reproductions: {bsonType: "number"},
                likes_count: {bsonType: "number"},
                dislikes_count: {bsonType: "number"},
                label: {bsonType: "objectId"},
                status: {bsonType: "string"},
                publication_date: {bsonType: "date"},
                coments: {bsonType: "objectId"}
            }, likes: {
                bsonType: "array",
                required: ["user", "date"],
                properties: {
                    user: {bsonType: "objectId"},
                    date: {bsonType: "date"}
                }
            }, dislikes: {
                bsonType: "array",
                required: ["user", "date"],
                properties: {
                    user: {bsonType: "objectId"},
                    date: {bsonType: "date"}
                }
            }
        }
    }
})

db.createCollection("playlist", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id", "user", "name", "date", "status", "videos"],
            properties: {
                id: {bsonType: "objectId"},
                user: {bsonType: "objectId"},
                name: {bsonType: "string"},
                date: {bsonType: "date"},
                status: {bsonType: "string"},
                videos: {bsonType: "array"}
            }
        }
    }
})

db.createCollection("chanels", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id", "user", "name", "description", "date", "videos", "subscribers"],
            properties: {
                id: {bsonType: "objectId"},
                user: {bsonType: "objectId"},
                name: {bsonType: "string"},
                description: {bsonType: "string"},
                date: {bsonType: "date"},
                videos: {bsonType: "array"},
                subscribers: {bsonType: "array"}
            }
        }
    }
})

db.createCollection("labels", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id", "name"],
            properties: {
                id: {bsonType: "objectId"},
                name: {bsonType: "string"}
            }
        }
    }
})

db.createCollection("comments", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id", "user", "text", "date"],
            properties: {
                id: {bsonType: "objectId"},
                user: {bsonType: "objectId"},
                text: {bsonType: "string"},
                date: {bsonType: "date"}
            }, likes: {
                bsonType: "array",
                required: ["user", "date"],
                properties: {
                    user: {bsonType: "objectId"},
                    date: {bsonType: "date"}
                }
            }, dislikes: {
                bsonType: "array",
                required: ["user", "date"],
                properties: {
                    user: {bsonType: "objectId"},
                    date: {bsonType: "date"}
                }
            }
        }
    }
})

db.createCollection("users", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["id", "email", "password", "name", "birth_date", "sex", "country", "zipcode"],
            properties: {
                id: {bsonType: "objectId"},
                email: {bsonType: "string"},
                name: {bsonType: "string"},
                birth_date: {bsonType: "date"},
                sex: {bsonType: "string"},
                country: {bsonType: "string"},
                zipcode: {bsonType: "string"}
            }
        }
    }
})

db.videos.insertOne([{
    id: 1,
    title: "Video1",
    description: "Video guapo guapo",
    sizeMb: 111,
    file_name: "v1.mp4",
    duration: 5,
    thumbnail: "resum.png",
    reproductions: 10,
    likes_count: 2,
    dislikes_count: 0,
    label: [objectId(1)],
    status: "public",
    publication_date: "2023-01-01 21:00:00",
    coments: [objectId(1)],
    likes: [{"user": objectId(1), "date": "2023-02-02 21:00:00"}],
    dislikes: [{"user": "", "date": ""}]
}]);

db.playlist.insertOne([{
    user: [objectId(1)],
    name: "LLista1",
    date: "2023-01-02 21:00:00",
    status: "public",
    videos: [objectId(1)]
}]);

db.chanels.insertOne([{
    id: 1,
    user: [objectId(1)],
    name: "Canal1",
    description: "Super canal 1",
    date: "2023-02-01 21:00:00",
    videos: [objectId(1)],
    subscribers: [objectId(1)]
}]);

db.labels.insertOne([{
    id: 1,
    name: "Etiqueta 1"
}]);

db.comments.insertOne([{
    id: 1,
    user: [objectId(1)],
    text: "Comentari",
    date: "2023-01-05 21:00:00",
    likes: [{"user": objectId(1), "date": "2023-02-02 21:00:00"}],
    dislikes: [{"user": "", "date": ""}]
}]);

db.users.insertOne([{
    id: 1,
    email: "A1.gmail.com",
    name: "Jordi",
    birth_date: "1975-08-25",
    sex: "man",
    country: "Spain",
    zipcode: "08860"
}]);