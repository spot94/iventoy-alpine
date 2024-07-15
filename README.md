# iventoy
Docker image for iventoy: https://iventoy.com/en/index.html
# Install
1. Build image from Dockerfile
```
docker build . --file Dockerfile --tag iventoy:latest
```
2. Use docker-compose.yml for reference to start-up container
# Example usage
I have Mikrotik hAP ax3 and server with iVentoy Docker container
To make PXE work you need to complete next steps:
*iVentoy GUI - change DHCP Server Mode to ExternalNet
![image](https://github.com/user-attachments/assets/e9686ae9-2876-40e2-b86b-3e0d0c6b5f46)
*Mikrotik - Configure your DHCP Network options:
Next Server: \<your container IP>
Boot File Name: _iventoy_loader_16000_uefi_
![image](https://github.com/user-attachments/assets/53574126-1766-4d39-84e1-41a1bec2ae4c)
*Mikrotik - Configure routes:
Add route: 
Dst: \<your container network>; Gate: \<your Docker server ip>
![image](https://github.com/user-attachments/assets/28c0af81-af29-490f-a61d-075d1baa0715)
