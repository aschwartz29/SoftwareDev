from graphics import*
import sys
import math
import random
import subprocess
import functools
import statistics


def main(file):
    inputfile=open(file,"r")
    lines = inputfile.readlines()

    maxx = 0
    minx = 0
    maxy = 0
    miny = 0
    points = [ ]
    standardDeviations = 3

    num_points = len(lines)
    #make list of points
    for line in lines:
        line = line.split()
        points.append(makePoint([float(line[1]), float(line[2])]))
 
    opt_cutoff = .3
    #divide data into two random clusters
    clusters = randomDivide(points,num_points)

    clusters_updated = adjustClusters(clusters, opt_cutoff,standardDeviations)
    
    win = GraphWin("Clusters",500,500)
    win.setCoords(-40,-40,40,40)
    plotClusters(clusters_updated, win,2)

        

class makePoint:
    #An point in n dimensional space

    def __init__(self, coords):
        '''
        coords - A list of values, one per dimension
        '''
        
        self.coords = coords
        self.n = len(coords)
        
    def __repr__(self):
        return str(self.coords)
    
class Cluster:
    #A set of points and their centroid
    
    def __init__(self, points):
       #points - A list of point objects
        # The points that belong to this cluster
        self.points = points
        # Set up the initial centroid (this is usually based off one point)
        self.centroid = self.calculateCentroid()
        
    def __repr__(self):
        '''
        String representation of this object
        '''
        return str(self.points)
    
    def update(self, points):
        '''
        Returns the distance between the previous centroid and the new after
        recalculating and storing the new centroid.
        '''
        old_centroid = self.centroid
        self.points = points
        self.centroid = self.calculateCentroid()
        shift = getDistance(old_centroid, self.centroid) 
        return shift
    
    def calculateCentroid(self):
        '''
        Finds a virtual center point for a group of n-dimensional points
        '''
        numPoints = len(self.points)
        # Get a list of all coordinates in this cluster
        coords = [p.coords for p in self.points]
        # Reformat that so all x's are together and all y's
        unzipped = zip(*coords)
        # Calculate the mean for each dimension
        centroid_coords = [math.fsum(dList)/numPoints for dList in unzipped]
        
        return makePoint(centroid_coords)

def randomDivide(points,num_points):
    #shuffle list randomly
    random.shuffle(points)

    # Split into two clusters
    cluster1 = Cluster(points[0:int(num_points/2)])
    cluster2 = Cluster(points[int(num_points/2):num_points])

    clusters = [cluster1,cluster2]
    win1 = GraphWin('Initial',500,500)
    win1.setCoords(-40,-40,40,40)
    plotClusters(clusters,win1,1)
    return clusters

def adjustClusters(clusters,cutoff,standardDeviations):
                                        
  # Loop through the dataset until the clusters stabilize
    loopCounter = 0
    for trial in range(510):
        distances = [[],[]]
        for i,c in enumerate(clusters):
            for p in c.points:
                distance = getDistance(p, clusters[i].centroid)
                distances[i].append(distance)
        sd = []                         
        sd.append(statistics.stdev(distances[0]))
        sd.append(statistics.stdev(distances[1]))
        #print(sd)
        # Create a list of lists to hold the points in each cluster
        lists = [ [] for c in clusters]
        clusterCount = 2
        
        # Start counting loops
        loopCounter += 1
        tempClusters = clusters
        # For every point in the dataset ...
        for i,c in enumerate(tempClusters):
            for p in c.points:
                # Get the distance between that point and the centroid of the cluster
                distance = getDistance(p, clusters[i].centroid)
                if distance > standardDeviations*sd[i]:
                    if i == 0:
                        lists[1].append(p)
                    else:
                        lists[0].append(p)
                else:
                    lists[i].append(p)
            
            # Set our biggest_shift to zero for this iteration
            biggest_shift = 0.0
            
        # As many times as there are clusters ...
        for i in range(clusterCount):
            # Calculate how far the centroid moved in this iteration
            shift = clusters[i].update(lists[i])
            # Keep track of the largest move from all cluster centroid updates
            biggest_shift = max(biggest_shift, shift)
        
        # If the centroids have stopped moving much --> done!
##        if biggest_shift < cutoff:
##            print ("Converged after %s iterations" % loopCounter)
##            break
    return clusters


def getDistance(a, b):

  #  Euclidean distance between two n-dimensional points.
    
    ret = functools.reduce(lambda x,y: x + pow((a.coords[y]-b.coords[y]), 2),range(a.n),0.0)
    return math.sqrt(ret)

def plotClusters(clusters, win,num):

  # List of symbols each cluster will be displayed using    
    color = ['red','blue','green','pink','purple']

    # Convert data into plotly format
    
    for i, c in enumerate(clusters):
        anchorpoint=Point(150,150)
        height=300
        width=300

        image=Image(anchorpoint, height, width)
        clusters = []
        for p in c.points:
            clusters.append(p.coords)
        clustrers = zip(*clusters)
        for z in range(len(clusters)):
            circ = Circle(Point(clusters[z][0],clusters[z][1]),.1)
            circ.setFill(color[i])
            circ.setOutline(color[i])
            circ.draw(win)
        centroidx = c.centroid.coords[0]
        centroidy = c.centroid.coords[1]

        circ = Circle(Point(centroidx,centroidy),.5)
        circ.setFill(color[i])
        circ.setOutline(color[i])
        circ.draw(win)
        findPixel=image.getPixel(150,150)
       # print findPixel
        # saves the current TKinter object in postscript format
        win.postscript(file="image"+str(num)+".eps", colormode='color')


main("synth_10_10.test")
    
