import os
import shutil
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


def copy(path, newpath):
    shutil.copy2(path, newpath)
    print(path, newpath, sep="  ===>  ")


def fix_file_locations():
    print("Fixing file locations...")
    for root, dirs, files in os.walk(orig):
        for name in files:
            if name.endswith('.jpg'):
                path = os.path.join(root, name)
                im = Image.open(path)
                width, height = im.size
                im.close()
                if width > height:
                    newpath = os.path.join(wide, name)
                    rename(path, newpath)
                elif height > width:
                    newpath = os.path.join(tall, name)
                    rename(path, newpath)
    for root, dirs, files in os.walk(dest_dir):
        for name in files:
            if name.endswith('.jpg.jpg'):
                path = os.path.join(root, name)
                newpath = os.path.join(root, name[:-4])
                rename(path, newpath)


def fix_hash_for_all():
    print("Fixing hashes...")
    thresh = 1920*1080 - 32*32
    for root, dirs, files in os.walk(dest_dir):
        for name in files:
            if name.endswith('.jpg') and len(name) == 14:
                path = os.path.join(root, name)
                ext = name[-4:]
                im = Image.open(path)
                hsh = imagehash.phash(im)
                width, height = im.size
                im.close()
                newpath = os.path.join(root, str(hsh) + ext)
                if width*height > thresh:
                    rename(path, newpath)
    fix_file_locations()


def collect_files():
    print("Collecting files...")
    thresh = 1920*1080 - 32*32
    for dir in (source_dir, dest_dir, orig, tall, wide):
        if not os.path.isdir(dir):
            os.mkdir(dir)
    for root, dirs, files in os.walk(source_dir):
        for name in files:
            path = os.path.join(root, name)
            try:
                im = Image.open(path)
                width, height = im.size
            except:
                continue
            if width*height > thresh:
                hsh = imagehash.phash(im)
                im.close()
                if width > height:
                    newpath = os.path.join(wide, str(hsh)+'.jpg')
                    copy(path, newpath)
                elif height > width:
                    newpath = os.path.join(tall, str(hsh)+'.jpg')
                    copy(path, newpath)



if __name__ == "__main__":
    source_dir = os.environ['LocalAppData'] + r"\Packages\Microsoft.Windows." \
    + r"ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
    dest_dir = os.getcwd()
    orig = dest_dir + r"\Originals"
    tall = dest_dir + r"\Tall"
    wide = dest_dir + r"\Wide"
    fix_hash_for_all()
    collect_files()
