const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    console.log(event)
    console.log(event)

    const id = event.id; // Get the ID from the path parameters
    const params = {
        TableName: process.env.DYNAMODB_TABLE, // Use the DynamoDB table name from environment variables
        Key: {
            id: id
        }
    };

    try {
        const data = await dynamoDB.get(params).promise();
        
        if (!data.Item) {
            return {
                statusCode: 404,
                body: JSON.stringify({ message: 'Item not found' }),
            };
        }

        return {
            statusCode: 200,
            body: JSON.stringify(data.Item),
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: 'Could not fetch item' }),
        };
    }
};