import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { lambdaHandler } from '../../app';
import { expect, describe, it } from '@jest/globals';

describe('lambdaHandler', function () {
    it('should return 400 if any required field is missing', async () => {
        const event: Partial<APIGatewayProxyEvent> = {
            body: JSON.stringify({}),
        } ;

        const result: APIGatewayProxyResult = await lambdaHandler(event as APIGatewayProxyEvent);
        
        expect(result.statusCode).toBe(400);
        expect(JSON.parse(result.body)).toEqual({ error: 'All fields are required' });
    });
});
