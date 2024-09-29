const AWS = require("aws-sdk");
const dynamoDB = new AWS.DynamoDB.DocumentClient();
const uuid = require('uuid');

exports.handler = async (event) => {
  try {
    const { name, email, telephone, message } = JSON.parse(event.body);

    if (!name || !email || !telephone || !message) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: "All fields are required" }),
      };
    }

    const keyId = uuid.v4();

    const item = {
      id: keyId,
      name,
      email,
      telephone,
      message,
    };

    const params = {
      TableName: process.env.DYNAMODB_TABLE,
      Item: item,
    };

    await dynamoDB.put(params).promise();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Data inserted successfully",
        id: keyId,
      }),
    };
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        error: "An error occurred while processing your request",
      }),
    };
  }
};
