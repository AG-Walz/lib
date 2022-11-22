################################################################################
###                                Purpose                                   ###
################################################################################
## Consists of the function that is necessary to create the protein figures
##  ---- 
## Input: 
##    - rel_json = vector with the json content that initiated the build of
##                 the figure. 
## Output:
##    - p        = a ggplot build which consists of all of the figure info
##  ---- 
## Author:
##    - M.L. Dubbelaar 
################################################################################
################################################################################
##                               Figure content                               ##
################################################################################
## Create the image that represents the protein and the belonging regions
drawProtein <- function(rel_json, legendPos) {
  ## Convert it to a dataframe object
  rel_data <- drawProteins::feature_to_dataframe(rel_json)
  ## Create an empty canvas for the creation of this figure
  p <- draw_canvas(rel_data) 
  ## Draw the protein chain or the protein "base" 
  p <- draw_chains(p, rel_data, label_chains = F)
  ## Add the domains (drawn to scale - lengths)
  p <- draw_domains(p, rel_data, label_domains = F)
  ## Add activation domain
  p <- draw_regions(p, rel_data)
  ## Add repeating regions
  p <- draw_repeat(p, rel_data)
  ## Add motifs of the protein
  p <- draw_motif(p, rel_data)
  ## Add the phosphorylation sites from Uniprot
  p <- draw_phospho(p, rel_data, size = 3, fill = "grey50") 
  ## Alter the figures' style
  p <- p + ggplotTheme +
    scale_x_continuous(expand = c(0, 0)) +
    theme(
      text = element_text(family="Garamond", size=14),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      axis.text.y = element_blank(),
      axis.text.x = element_blank(),
      panel.border = element_blank(),
      legend.position=legendPos,
      plot.margin = margin(t =3,r = 0,b = 3,l = 1.3, "cm"),
      legend.key.size = unit(.25, 'cm'), #change legend key size
      legend.key.height = unit(.25, 'cm'), #change legend key height
      legend.key.width = unit(.25, 'cm'), #change legend key width
      legend.title = element_blank(), #change legend title font size
      legend.text = element_text(size=6)
    ) + 
    guides(fill=guide_legend(nrow=10))
  ## Return the ggplot content
  return(p)
}
