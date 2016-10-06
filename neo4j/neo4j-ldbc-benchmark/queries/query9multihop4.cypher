EXPORT personId=2199023259437
EXPORT date="2016-7-7"
EXPORT top=20

MATCH (:Person {id:{personId}})-[:KNOWS*1..4]->(friend:Person)
WITH COLLECT (DISTINCT friend) AS friends
UNWIND friends AS friend
MATCH (friend:Person)<-[:HAS_CREATOR]-(message)
WHERE message.creationDate < {date}
WITH DISTINCT message
ORDER BY message.creationDate DESC, message.id ASC
LIMIT {top}
MATCH (friend:Person)<-[:HAS_CREATOR]-(message)
RETURN
message.id AS messageId,
CASE EXISTS(message.content)
        WHEN true THEN message.content
        ELSE message.imageFile
END AS messageContent,
message.creationDate AS messageCreationDate,
friend.id AS personId,
friend.firstName AS personFirstName,
friend.lastName AS personLastName
;