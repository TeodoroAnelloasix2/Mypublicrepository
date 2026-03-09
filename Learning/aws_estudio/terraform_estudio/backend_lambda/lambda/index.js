const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");
const { randomUUID } = require("crypto");

const ddbDocClient = DynamoDBDocumentClient.from(new DynamoDBClient({}));


exports.handler = async (event, context) => {
    try {
        const body = JSON.parse(event.body);
        
        const newUser = {
            ...body,
            user_id: body.user_id,
            timestamp: Date.now(),
            username: body.username
        };
        await ddbDocClient.send(new PutCommand({
            TableName: process.env.TABLE_NAME,
            Item: newUser,
        }));

        return {
            statusCode: 201,
            body: JSON.stringify(newUser),
        };
    }
    catch (error) {
        console.error(error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: error.message }),
        };
    }
}