import socket
import ipaddress
from concurrent.futures import ThreadPoolExecutor

# Descobre o IP local da máquina
meu_ip = socket.gethostbyname(socket.gethostname())

# Cria uma rede baseada no IP local
rede = ipaddress.ip_network(meu_ip + '/24', strict=False)

print(f"🔍 Escaneando dispositivos na rede: {rede}")

# Função para verificar se o IP está ativo
def verificar_ip(ip):
    try:
        socket.gethostbyaddr(str(ip))
        print(f"✅ Ativo: {ip}")
    except:
        pass  # IP inativo

# Usa múltiplas threads para acelerar o escaneamento
with ThreadPoolExecutor(max_workers=100) as executor:
    executor.map(verificar_ip, rede.hosts())
