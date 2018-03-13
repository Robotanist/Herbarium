# USAGE
# python3 batch.py --images images/miccal
# python3 batch.py --images images/miccal --sample 2
import argparse
import numpy as np
import cv2
import collections
import os
from imutils import build_montages
from imutils import paths


# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-c", "--cascade",
	default="miccal-cascades-30stages.xml",
	help="path to plant haar cascade")
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

for imagePath in imagePaths:
        image = cv2.imread(imagePath)



# load the penset detector Haar cascade, then detect penset
# in the input image
# alter variable for scaleFactor, minNeighbors, minSize
# update the list of image
        detector = cv2.CascadeClassifier(args["cascade"])
        rects = detector.detectMultiScale(image, scaleFactor=1.1, minNeighbors=1, minSize=(24, 24))


# loop over the penset and draw a rectangle surrounding each
        for (i, (x, y, w, h)) in enumerate(rects):
                cv2.rectangle(image, (x, y), (x + w, y + h), (0, 0, 255), 2)
                cv2.putText(image, "Target #{}".format(i + 1), (x, y - 10),
                cv2.FONT_HERSHEY_SIMPLEX, 0.55, (0, 255, 255), 2)
                print(imagePath, file=open("output.txt", "a") )


        # construct the montages for the images
        montages = build_montages(images, (200, 300), (1, 1))
        images.append(image)
        # loop over the montages and display each of them
        for montage in montages:
                cv2.imshow("Results", montage)
				# Put waitKey in for loop for image by image and press any key to exit montage and create sorted output file "image with image name and number of detections"
cv2.waitKey(0)
with open('output.txt') as infile:
    counts = collections.Counter(l.strip() for l in infile)
for line, count in counts.most_common():
    print(line, count, file=open("sort.txt", "a"))
