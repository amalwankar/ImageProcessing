#The first step is to update and upgrade any existing packages
sudo apt-get update
sudo apt-get upgrade

#We then need to install some developer tools, including CMake, which helps us configure the OpenCV build process
sudo apt-get install build-essential cmake pkg-config

#Next, we need to install some image I/O packages that allow us to load various image file formats from disk. 
#Examples of such file formats include JPEG, PNG, TIFF, etc
sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev

#Just as we need image I/O packages, we also need video I/O packages. 
#These libraries allow us to read various video file formats from disk as well as work directly with video streams
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev

#The OpenCV library comes with a sub-module named highgui which is used to display images to our screen and build basic GUIs. 
#In order to compile the highgui  module, we need to install the GTK development library
sudo apt-get install libgtk2.0-dev

#Many operations inside of OpenCV (namely matrix operations) can be optimized further 
#by installing a few extra dependencies
sudo apt-get install libatlas-base-dev gfortran

#Lastly, let’s install both the Python 2.7 and Python 3 header files so we can compile OpenCV with Python bindings
sudo apt-get install python2.7-dev python3-dev

#Now that we have our dependencies installed, let’s grab the 3.1.0  archive of OpenCV from the official OpenCV repository. 
#(Note: As future versions of openCV are released, you can replace 3.1.0  with the latest version number)
cd ~
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.1.0.zip
unzip opencv.zip

#We’ll want the full install of OpenCV 3 (to have access to features such as SIFT and SURF, for instance), 
#so we also need to grab the opencv_contrib repository as well:
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.1.0.zip
unzip opencv_contrib.zip

#Before we can start compiling OpenCV on our Raspberry Pi 3, we first need to install pip , a Python package manage
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

#Our only Python dependency is NumPy, a Python package used for numerical processing:
pip install numpy

# we can setup our build using CMake:
cd ~/opencv-3.1.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
   -D CMAKE_INSTALL_PREFIX=/usr/local \
   -D INSTALL_PYTHON_EXAMPLES=ON \
   -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.1.0/modules \
   -D BUILD_EXAMPLES=ON ..

#Verify Python paths at end of previous script and then install open cv
make

# install OpenCV 3 on your Raspberry Pi 3
sudo make install
sudo ldconfig

# for Python3 the cv2 file will be in the dist-packages and will need to be renamed from cv2.cpython-34m.so to cv2.so
# Testing
# run python and import cv2 then typing cv2.__version__ should show you '3.1.0'