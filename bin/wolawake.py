#!/usr/bin/python3
# -*- coding: utf-8 -*-
# wol.py

import socket
import struct


def wake_on_lan(macaddress, ip):
    """ Switches on remote computers using WOL. """

    # Check macaddress format and try to compensate.
    if len(macaddress) == 12:
        pass
    elif len(macaddress) == 12 + 5:
        sep = macaddress[2]
        macaddress = macaddress.replace(sep, '')
    else:
        raise ValueError('Incorrect MAC address format')

    # Pad the synchronization stream.
    data = b'FFFFFFFFFFFF' + (macaddress * 20).encode()
    send_data = b''

    # Split up the hex values and pack.
    for i in range(0, len(data), 2):
        send_data += struct.pack('B', int(data[i: i + 2], 16))

    # Broadcast it to the LAN.
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    sock.sendto(send_data, (ip, 7))


if __name__ == '__main__':
    table = {
        "a": ["Alla", '', True, '<broadcast>', "Ok"],
        "1": ["benelli", '28:CF:DA:03:49:81', False, '<broadcast>', "Ej Ok"],
        "2": ["ducati", '00:1A:92:40:E9:18', True, '<broadcast>', "EJ Ok"],
        "3": ["huskvarna", '04:0C:CE:E0:DE;7A', False, '<broadcast>', "Ej Ok"],
        "4": ["kawa", '6C:F0:49:01:B1:EF', True, '<broadcast>', "Ok"],
        "5": ["medion30", '00:0C:76:9D:D8:A4', False, '<broadcast>', "Ej Ok"],
        "6": ["motoguzzi", '00:22:15:6a:92:51', True, '<broadcast>', "OK"],
        "7": ["bumse", '08:62:66:35:49:23', True, '<broadcast>', "OK"],
        "8": ["derbi", '00:22:3f:e2:ab:c9', True, '<broadcast>', "OK"],
        "9": ["jawa", '24:4b:fe:5a:3a:f1', True, '<broadcast>', "OK"],
        "10": ["gw1", '00:17:9a:3a:c7:c2', True, '<broadcast>', "OK"],
        "11": ["condor", 'd4:5d:64:80:94:3d', True, '<broadcast>', "OK"],
        "12": ["nimbus", '84:2b:2b:af:24:3e', True, '<broadcast>', "OK"],
        "q": ["Avsluta (quit)", '', True, '<broadcast>', "Ok"]
    }
    # print(table.items())

    while True:
        while True:
            for k, v in table.items():
                if v[2]:
                    print(k, v[0])

            selection = input("Ange vilken maskin som skall väckas:")
            # print(selection, table.has_key(selection))

            if selection in table:
                break
            print("Fel svar, försök igen")

        if selection == "a":
            for k, v in table.items():
                if k != "q" and k != "a" and v[2]:
                    # wake_on_lan(v[1],v[3])
                    print("Wake on LAN sent to", v[0], v[1])

        elif selection != "q" and v[2]:
            m = table.get(selection)
            # print (m[0], m[1])
            wake_on_lan(m[1], m[3])
            print(
                "Wake on LAN sent to", m[0], m[1])

        elif selection == "q":
            break
