assing_clust <- function (clustered){
  asigned_clusters <- as.data.frame(NULL)
  for (i in 1:length(clustered)) {
    asigned_clusters <- rbind(asigned_clusters, as.data.frame(clustered[[i]]))
  }
  asigned_clusters$id <- paste(asigned_clusters$round, asigned_clusters$medianx, asigned_clusters$mediany, sep = "_")
  asigned_clusters$p_weight <- 0
  asigned_clusters$cubre <- 0
  asigned_clusters$p_dist <- 0
  for (i in unique(asigned_clusters$id)) {
    asigned_clusters[asigned_clusters$id == i, ]$cubre <- 
      nrow(asigned_clusters[asigned_clusters$id == i, ])
    asigned_clusters[asigned_clusters$id == i, ]$p_weight <- 
      round(sum(asigned_clusters[asigned_clusters$id == i, ]$weight) / 
              nrow(asigned_clusters[asigned_clusters$id == i, ]), 2)
    asigned_clusters[asigned_clusters$id == i, ]$p_dist <-
      mean(asigned_clusters[asigned_clusters$id == i, ]$dist)
  }
  assing_clust.output <- list(centres_clusters = subset(asigned_clusters, duplicated(asigned_clusters$id) == F,
                                                     select = c(id, x, y, weight, medianx, mediany, p_dist, cubre, round)), 
                           assigned_clusters = subset(asigned_clusters, select = c(id, x, y, weight, medianx, mediany, dist, round)))
}
