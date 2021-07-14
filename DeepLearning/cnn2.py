
##################################
#file name: cnn2.py
#변경해보기...

# B1: import tensorflow
import tensorflow as tf
import os
os.environ['TF_CPP_MIN_LOG_LEVEL']='2'

# B2: MNIST data set up
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('MNIST_data', one_hot=True)

# B3: weight initialization with truncated normal distribution
# weight initialization with truncated normal distr
def weight_variable(shape):
    initial=tf.truncated_normal(shape,stddev=0.1)
    return tf.Variable(initial)
# alternativly coding style....
#tf.Variable(tf.truncated_normal(shape,stddev=0.1))

# B4: initialize bias with 0.1
# initialize bias with 0.1
def bias_variable(shape):
    initial=tf.constant(0.1, shape=shape)
    return tf.Variable(initial)
# alternativly coding style....
#tf.Variable(tf.constant(0.1, shape))
#tf.Variable(tf.zeros(shape)+0.1, shape))

# B5: convolution with common setting
def conv2d(x, w):
    return tf.nn.conv2d(x, w, strides=[1, 1, 1, 1], padding='SAME')

# B6: pooling with common setting
def max_pool_2x2(x):
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1], 
      strides=[1, 2, 2, 1], padding='VALID')

# B7: input image reshaping to 4D tensor for CNN
# format: [batch, height, width, channels]
x=tf.placeholder(tf.float32, shape=[None, 784])
x_image=tf.reshape(x,[-1, 28, 28, 1])

# B8: first CNN layer: CONV -> RELU -> POOL
# We use 5x5 patch, accept 1 channel, and produce 2.
w_conv1 = weight_variable([5, 5, 1, 2])
b_conv1 = bias_variable([2])
h_conv1 = tf.nn.relu(conv2d(x_image, w_conv1) + b_conv1)
h_pool1 = max_pool_2x2(h_conv1)

# B9: second CNN layer: CONV -> RELU -> POOL
# We use 5x5 patch, accept 2 channel, and produce 4.
w_conv2 = weight_variable([5, 5, 2, 4])
b_conv2 = bias_variable([4])
h_conv2 = tf.nn.relu(conv2d(h_pool1, w_conv2) + b_conv2)
h_pool2 = max_pool_2x2(h_conv2)
# B10: fully connected layer with 1024 neurons: FC -> RELU
# Images are reduced to 7x7 and reshaped.
w_fc1=weight_variable([7*7*4,1024])
b_fc1=bias_variable([1024])
h_pool2_flat=tf.reshape(h_pool2,[-1,7*7*4])
h_fc1=tf.nn.relu(tf.matmul(h_pool2_flat,w_fc1)+b_fc1)
# B11: neuron dropout to avoid overfitting
# 'keep' contains keep rate
keep = tf.placeholder(tf.float32)
h_fc1_drop = tf.nn.dropout(h_fc1, keep)
# B12: readout layer using softmax regression
W_fc2 = weight_variable([1024, 10])
b_fc2 = bias_variable([10])
y_conv = tf.nn.softmax(tf.matmul(h_fc1_drop, W_fc2) + b_fc2)
#B13 loss function and optimizer
y_ = tf.placeholder(tf.float32, shape=[None, 10])
loss = tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(y_conv), 1))
opt = tf.train.AdamOptimizer(0.001).minimize(loss)

# B14: accuracy calculation for printing
right = tf.equal(tf.argmax(y_conv, 1), tf.argmax(y_, 1))
acc = tf.reduce_mean(tf.cast(right, tf.float32))

# B15: session run
sess = tf.Session()
sess.run(tf.global_variables_initializer())

for i in range(1000):
    batch = mnist.train.next_batch(50)
    sess.run(opt, feed_dict={x: batch[0], y_: batch[1], keep: 0.1})
    if i % 100 == 0:
        check = sess.run(acc, feed_dict={x:batch[0], y_: batch[1], keep: 1.0})
        print("step %d, training accuracy %.2f" % (i, check))
 
# B16: model accuracy with MNIST test set
images = mnist.test.images
labels = mnist.test.labels
final = sess.run(acc, feed_dict={x: images, y_: labels, keep: 1.0})
print("final test accuracy %g" % final)


