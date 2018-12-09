import os
from PIL import Image
import imagehash


def rename(path, newpath):
    try:
        os.rename(path, newpath)
        print(path, newpath, sep="  ===>  ")
    except FileExistsError:
        os.remove(path)
        print("Duplicate file:", newpath)
    except PermissionError:
        print("Permission denied:", path)
        pass

def hash_and_move():
    for root, dirs, files in os.walk(os.getcwd()):
        for name in files:
            if name.endswith('.jpg'):
                if len(name) < 25:
                    path = os.path.join(root, name)
                    ext = name[-4:]
                    im = Image.open(path)
                    hsh = imagehash.phash(im, hash_size=16)
                    im.close()
                    newpath = os.path.join(root, str(hsh) + ext)
                    rename(path, newpath)

    for root, dirs, files in os.walk(os.getcwd()):
        dirs[:] = ['Originals']
        for name in files[:]:
            if name.endswith('.jpg') and root.endswith('Originals'):
                path = os.path.join(root, name)
                im = Image.open(path)
                width, height = im.size
                im.close()
                if width > height:
                    newpath = os.path.join(root[:-9] + 'Wide', name)
                    rename(path, newpath)
                elif height > width:
                    newpath = os.path.join(root[:-9] + 'Tall', name)
                    rename(path, newpath)

if __name__ == "__main__":
    hash_and_move()
