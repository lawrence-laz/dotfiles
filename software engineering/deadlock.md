A acq lock X
A call B
B try acq lock X

------

A acq lock X
B acq lock Y
A wait for lock Y
B wait for lock X

------


