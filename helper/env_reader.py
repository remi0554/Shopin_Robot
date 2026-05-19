import os

def get_env(var):
    value = os.getenv(var)
    if not value:
        raise ValueError(f"Environment variable '{var}' not found")
    return value


# from dotenv import load_dotenv
# import os

# load_dotenv()

# def get_env(var):
#     return os.getenv(var)