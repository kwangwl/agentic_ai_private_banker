import boto3
import json


def get_flow_response(input_data, flow_id, flow_alias_id, bedrock_region_name):
    session = boto3.Session()
    client = session.client(service_name='bedrock-agent-runtime', region_name=bedrock_region_name)

    response = client.invoke_flow(
        enableTrace=True,
        flowIdentifier=flow_id,
        flowAliasIdentifier=flow_alias_id,
        inputs=[
            {
                "content": {
                    "document": json.dumps(input_data)
                },
                "nodeName": "FlowInputNode",
                "nodeOutputName": "document"
            }
        ]
    )
    return response
