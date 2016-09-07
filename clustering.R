# This mini-project is based on the K-Means exercise from 'R in Action'
# Go here for the original blog post and solutions
# http://www.r-bloggers.com/k-means-clustering-from-r-in-action/

# Exercise 0: Install these packages if you don't have them already

# install.packages(c("cluster", "rattle","NbClust"))

# Now load the data and look at the first few rows
data(wine, package="rattle")
head(wine)

# Exercise 1: Remove the first column from the data and scale
# it using the scale() function

 for (i in 1:178) { 
           wine$type[i] <- scale(as.integer(wine$type[i]))
   }
 wine$Type
 
 df <- scale(wine[-1])

# Now we'd like to cluster the data using K-Means. 
# How do we decide how many clusters to use if you don't know that already?
# We'll try two methods.

# Method 1: A plot of the total within-groups sums of squares against the 
# number of clusters in a K-means solution can be helpful. A bend in the 
# graph can suggest the appropriate number of clusters. 

wssplot <- function(data, nc=15, seed=1234){
	              wss <- (nrow(data)-1)*sum(apply(data,2,var))
               	      for (i in 2:nc){
		        set.seed(seed)
	                wss[i] <- sum(kmeans(data, centers=i)$withinss)}
	                
		      plot(1:nc, wss, type="b", xlab="Number of Clusters",
	                        ylab="Within groups sum of squares")
	   }

wssplot(wine)


# Exercise 2:
#   * How many clusters does this method suggest? 
# --seems to suggest at least 2 and possible 4--
#   * Why does this method work? What's the intuition behind it?
# -- seems to group items by the square means --
#   * Look at the code for wssplot() and figure out how it works

# Method 2: Use the NbClust library, which runs many experiments
# and gives a distribution of potential number of clusters.

library(NbClust)
set.seed(1234)
nc <- NbClust(df, min.nc=2, max.nc=15, method="kmeans")
barplot(table(nc$Best.n[1,]),
	          xlab="Numer of Clusters", ylab="Number of Criteria",
		            main="Number of Clusters Chosen by 26 Criteria")


# Exercise 3: How many clusters does this method suggest?

# --This method suggests 3 clusters--

# Exercise 4: Once you've picked the number of clusters, run k-means 
# using this number of clusters. Output the result of calling kmeans()
# into a variable fit.km

# fit.km <- kmeans( ... )

fit.km <- kmeans(wine,3, iter.max = 10)

#K-means clustering with 3 clusters of sizes 62, 47, 69

#Cluster means:
#  Type  Alcohol    Malic      Ash Alcalinity Magnesium  Phenols Flavanoids Nonflavanoids
#1 2.258065 12.92984 2.504032 2.408065   19.89032 103.59677 2.111129   1.584032     0.3883871
#2 1.021277 13.80447 1.883404 2.426170   17.02340 105.51064 2.867234   3.014255     0.2853191
#3 2.275362 12.51667 2.494203 2.288551   20.82319  92.34783 2.070725   1.758406     0.3901449
#Proanthocyanins    Color       Hue Dilution   Proline
#1        1.503387 5.650323 0.8839677 2.365484  728.3387
#2        1.910426 5.702553 1.0782979 3.114043 1195.1489
#3        1.451884 4.086957 0.9411594 2.490725  458.2319

#Clustering vector:
#  [1] 2 2 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 2 2 1 1 2 2 1 2 2 2 2 2 2 1 1 2 2 1 1 2 2 1 1 2 2 2 2
##[50] 2 2 2 2 2 2 2 2 2 2 3 1 3 1 3 3 1 3 3 1 1 1 3 3 2 1 3 3 3 1 3 3 1 1 3 3 3 3 3 1 1 3 3 3 3 3 1 1 3
#[99] 1 3 1 3 3 3 1 3 3 3 3 1 3 3 1 3 3 3 3 3 3 3 1 3 3 3 3 3 3 3 3 3 1 3 3 1 1 1 1 3 3 3 1 1 3 3 1 1 3
#[148] 1 1 3 3 3 3 1 1 1 3 1 1 1 3 1 3 1 1 3 1 1 1 1 3 3 1 1 1 1 1 3

#Within cluster sum of squares by cluster:
#  [1]  566610.4 1360951.4  443180.5
#(between_SS / total_SS =  86.5 %)

#Available components:
  
#  [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"   
#[7] "size"         "iter"         "ifault"

# Now we want to evaluate how well this clustering does.

# Exercise 5: using the table() function, show how the clusters in fit.km$clusters
# compares to the actual wine types in wine$Type. Would you consider this a good
# clustering?

#--seems ok the clustering

# Exercise 6:
# * Visualize these clusters using  function clusplot() from the cluster library
# * Would you consider this a good clustering?
library(cluster)
#clusplot( ... )

clusplot(wine, wine$Type)
#-I would consider it a decent clustering, it looks to be 3 separat groups
