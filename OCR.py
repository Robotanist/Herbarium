# USAGE
# python OCR.py --images HAW_specimens
# python OCR.py --images HAW_specimens --sample 10
# python OCR.py --images HAW_specimens --preprocess blur
# python OCR.py --images HAW_specimens --preprocess thresh


import numpy as np
import collections
import pytesseract
import argparse
import cv2
import sys
import os
from imutils import build_montages
from imutils import paths
from PIL import Image
from pytesseract import image_to_string

pytesseract.pytesseract.tesseract_cmd = 'C:/Program Files (x86)/Tesseract-OCR/tesseract'
# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-p", "--preprocess", type=str, default="thresh",
	help="type of preprocessing to be done")
ap.add_argument("-i", "--images", required=True,
	help="path to input directory of images")
ap.add_argument("-s", "--sample", type=int, default=100,
	help="# of images to sample")
args = vars(ap.parse_args())

# grab the paths to the images,
imagePaths = list(paths.list_images(args["images"]))
imagePaths = imagePaths[:args["sample"]]

# initialize the list of images
images = []
	# load the image and convert it to grayscale
for imagePath in imagePaths:
	image = cv2.imread(imagePath)
	gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
	# check to see if we should apply thresholding to preprocess the images
	if args["preprocess"] == "thresh":
		gray = cv2.threshold(gray, 0, 255,
			cv2.THRESH_BINARY | cv2.THRESH_OTSU)[1]

	# make a check to see if median blurring should be done to remove noise
	elif args["preprocess"] == "blur":
		gray = cv2.medianBlur(gray, 3)
        # write the grayscale image to disk as a temporary file so we can apply OCR to it
	filename = "{}.png".format(os.getpid())
	cv2.imwrite(filename, gray)
	# load the image as a PIL/Pillow image, apply OCR, and then delete the temporary file
	text = pytesseract.image_to_string(Image.open(filename))
	os.remove(filename)
	print(imagePath, text, "\n=======================================================", file=open("OCR.txt", "a"))
	print(imagePath, text, "\n=======================================================")
