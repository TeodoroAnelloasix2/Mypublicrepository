import json

def my_lambda_handler(event, context):
    # TODO implement
    print(event)
    for  i in range(3):
        current_key=f"key{i+1}"
        print(f"value{i+1}={event[current_key] }")

    #raise Exception("this is  expected")
