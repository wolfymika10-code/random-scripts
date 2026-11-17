from MY_FUNCS import awaitinputV2, clear

def menuprint(title, body, options, selection): # helper for ShowMenu
    clear()
    print(f"{title}\n{body}\n")
    index=0
    for item in options:
        if index==selection:
            print(f"> {item} <")
        else:
            print(f"  {item}")
        index+=1

def ShowMenu(title:str, body:str, options:list[str]):
    selection=0
    menuprint(title, body, options, selection)
    while True:
        key=awaitinputV2()
        if key=="DownArrow" or key=="w":
            selection+=1
            if selection>=len(options):
                selection=0
        elif key=="UpArrow" or key=="s":
            selection-=1
            if selection<0:
                selection=len(options)-1
        elif key=="Enter":
            return options[selection]
        menuprint(title, body, options, selection)
        
        
