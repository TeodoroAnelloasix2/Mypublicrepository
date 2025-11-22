import boto3 
#Author Teodoro Anello Asix2A

def main():
    pool_name_a_buscar=input("Que pool id quieres?: ")
    id=get_user_pool_id(pool_name_a_buscar)

    print(id)
    user_mail=input("mail usuario nuevo: ")

    new_user(id,user_mail)

def new_user(id_user_pool,new_user_mail):

    new_user=boto3.client("cognito-idp")

    request_create_user = new_user.admin_create_user(
    UserPoolId=id_user_pool,
    Username=new_user_mail,
    UserAttributes=[
        {
            'Name': 'email',
            'Value': new_user_mail

        },
        {
            'Name': 'custom:age',
            'Value': '35'

        },
        {
            'Name': 'name',
            'Value':'Giuseppe'
        },
    ],
    ValidationData=[
        {
            'Name': 'string',
            'Value': 'string'
        },
    ],
    TemporaryPassword='system_1234',
    ForceAliasCreation=False,
    MessageAction='SUPPRESS',
    DesiredDeliveryMediums=[
        'EMAIL',
    ],
)

def get_user_pool_id(pool_name_a_buscar):
    
    pool=boto3.client("cognito-idp")

    pool_list=pool.list_user_pools(
    
        MaxResults=20
    )
    
    for user_pool in pool_list['UserPools']:
        print(user_pool['Name'])
        if user_pool['Name']==pool_name_a_buscar:
            print(user_pool['Id'])
            return user_pool['Id']
    
    return "No s'ha trobat"

if __name__=="__main__":
    main()

