import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import AWS from 'aws-sdk';
import { v4 as uuidv4 } from 'uuid';

const dynamoDB = new AWS.DynamoDB.DocumentClient();

export const lambdaHandler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    try {
        const { name, email, telephone, message } = JSON.parse(event.body || '{}');

        if (!name || !email || !telephone || !message) {
            return {
                statusCode: 400,
                body: JSON.stringify({ error: 'All fields are required' }),
            };
        }

        const keyId = uuidv4();

        const item = {
            id: keyId,
            name,
            email,
            telephone,
            message,
        };

        const params = {
            TableName: process.env.DYNAMODB_TABLE as string,
            Item: item,
        };

        await dynamoDB.put(params).promise(); 

        return {
            statusCode: 200,
            body: JSON.stringify({
                message: 'Data inserted successfully',
                id: keyId,
            }),
        };
    } catch (error) {
        console.error(error); 
        return {
            statusCode: 500,
            body: JSON.stringify({
                error: 'An error occurred while processing your request',
            }),
        };
    }
};
