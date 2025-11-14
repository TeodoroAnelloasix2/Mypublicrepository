import boto3
#Author Teodoro Anello Asix2 A
user_pool=boto3.client("cognito-idp")
name=input("Nombre user pool: ")

create_user_pool_request = user_pool.create_user_pool(
    PoolName=name,
    Policies={
        'PasswordPolicy': {
            'MinimumLength': 8,
            'RequireUppercase': False,
            'RequireLowercase': False,
            'RequireNumbers': True,
            'RequireSymbols': True,
            'TemporaryPasswordValidityDays': 123
        }
    },
    DeletionProtection='INACTIVE',

    AutoVerifiedAttributes=[
        'email'
    ],

    UsernameAttributes=[
       'email'
    ],
   
    EmailVerificationMessage='Hola, bienvenido a nuestro sitio. Utiliza el código de verificación {####} para confirmar tu dirección de correo electrónico.',
    EmailVerificationSubject='El Duende Verde',
    
    MfaConfiguration='OFF',
    UserAttributeUpdateSettings={
        'AttributesRequireVerificationBeforeUpdate': [
          'email'
        ]
    },
    DeviceConfiguration={
        'ChallengeRequiredOnNewDevice':False,
        'DeviceOnlyRememberedOnUserPrompt': False
    },

    UserPoolTags={
        'name': 'pool_pildora4'
    },

    Schema=[
        {
            'Name': 'name',
            'AttributeDataType': 'String',  #|'Number'|'DateTime'|'Boolean',
            'DeveloperOnlyAttribute' : False, #True|False,
            'Mutable': True,
            'Required': False, 
        
            'StringAttributeConstraints': {
                'MinLength': '1',
                'MaxLength': '100'
            }
        },
        {
           'Name': 'age',
           'AttributeDataType': 'Number',
           'DeveloperOnlyAttribute' : False,
           'Mutable': True,
           'Required': False,
           'NumberAttributeConstraints': {
                'MinValue': '18',
                'MaxValue': '90'
            },

        },
    ],
    UserPoolAddOns={
        'AdvancedSecurityMode': 'OFF'
    },
    UsernameConfiguration={
        'CaseSensitive':False
    },
    AccountRecoverySetting={
        'RecoveryMechanisms': [
            {
                'Priority': 1,
                'Name': 'verified_email'
            },
        ]
    }
)

print(create_user_pool_request)