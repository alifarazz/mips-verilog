from typing import Dict

def convert(ins: int) -> Dict :
    foo = bin(ins)[2:].zfill(32)
    res = {}
    res['op'] = foo[0:6]
    res['rs'] = foo[6:11]
    res['rt'] = foo[11:16]
    res['rd'] = foo[16:21]
    res['shift'] = foo[21:26]
    res['fmt'] = foo[26:]
    return res

x = input()
while 'q' != x:
    res = convert(int(x, 16))
    print(res)
    x = input()
