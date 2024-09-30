import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import AWS from 'aws-sdk';
import { v4 as uuidv4 } from 'uuid';

const dynamoDB = new AWS.DynamoDB.DocumentClient();
const sns = new AWS.SNS();

const tableName = process.env.DYNAMODB_TABLE as string;
const snsTopicArn = process.env.SNS_TOPIC_ARN as string;

interface Item {
    id: string;
    name: string;
    email: string;
    telephone: string;
    message: string;
}

const errorResponse = (statusCode: number, message: string): APIGatewayProxyResult => ({
    statusCode,
    body: JSON.stringify({ error: message }),
});

const saveToDynamoDB = async (item: Item) => {
    const params = {
        TableName: tableName,
        Item: item,
    };
    return dynamoDB.put(params).promise();
};

const publishToSNS = async (name: string, email: string, telephone: string, message: string) => {
    const snsParams = {
        Message: `New message received:
                  - Name: ${name}
                  - Email: ${email}
                  - Telephone: ${telephone}
                  - Message: ${message}`,
        TopicArn: snsTopicArn,
        Subject: 'New message received',
    };
    return sns.publish(snsParams).promise();
};

export const lambdaHandler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    try {
        const { name, email, telephone, message } = JSON.parse(event.body || '{}');

        if (!name || !email || !telephone || !message) {
            return errorResponse(400, 'All fields are required');
        }

        const keyId = uuidv4();
        const item: Item = { id: keyId, name, email, telephone, message };

        await saveToDynamoDB(item);

        await publishToSNS(name, email, telephone, message);

        return {
            statusCode: 200,
            body: JSON.stringify({
                message: 'Data inserted and notification sent successfully',
                id: keyId,
            }),
        };
    } catch (error) {
        console.error('Error processing request:', error);
        return errorResponse(500, 'An error occurred while processing your request');
    }
};