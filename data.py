# import requests
#
# def get_data_from_ip(ip, port=80, endpoint="/"):
#     """
#     Fetches and prints data from the given IP address and endpoint.
#
#     Args:
#         ip (str): The IP address to connect to.
#         port (int): The port to use (default is 80 for HTTP).
#         endpoint (str): The endpoint to request (default is root '/').
#     """
#     try:
#         url = f"http://{ip}:{port}{endpoint}"
#         response = requests.get(url)
#         response.raise_for_status()  # Raise an error for HTTP codes 4xx/5xx
#         print(f"Data from {ip}:\n{response.text}")
#     except requests.exceptions.RequestException as e:
#         print(f"Error fetching data from {ip}: {e}")
#
# # Example usage
# if __name__ == "__main__":
#     ip_address = "192.168.100.111"
#     port = 80  # Change if needed
#     endpoint = "/"  # Change if needed
#     get_data_from_ip(ip_address, port, endpoint)
