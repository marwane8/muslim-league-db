from passlib.context import CryptContext


#create a hashed password for storages
password_context = CryptContext(schemes=["bcrypt"],deprecated="auto")

def get_hashed_password(password: str) -> str:
    return password_context.hash(password)

hashed_password = get_hashed_password('password')
print(hashed_password)