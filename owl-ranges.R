## Manu Road Owls and Potoos
library(dplyr)
library(ggplot2)

# enter the data from Birds of Peru ----------------------------------------------------------
name <- c("White-throated Screech Owl", "Tawny-bellied Screech Owl", "Tropical Screech Owl", "Vermiculated Screech Owl", "Cloud Forest Screech Owl", "Rufescent Screech Owl", "Crested Owl", "Spectacled Owl", "Band-bellied Owl", "Black-banded Owl", "Rufous-banded Owl", "Mottled Owl", "Great-horned Owl", "Striped Owl", "Amazonian Pygmy Owl", "Yungas Pygmy Owl", "Ferruginous Pygmy Owl", "Common Potoo", "Andean Potoo", "Long-tailed Potoo", "Great Potoo")

genus <- c(rep("Megascops", 6), "Lophostrix", "Pulsatrix", "Pulsatrix", rep("Ciccaba", 3), "Bubo", "Pseudoscops", rep("Glaucidium", 3), rep("Nyctibius", 4))

species <- c("albogularis", "watsonii", "choliba", "guatemalae", "marshalli", "ingens", "cristata", "perspicillata", "melanota", "huhula", "albitarsis", "virgata", "virginianus", "clamator", "hardyi", "jardinii", "brasilianum", "griseus", "maculosus", "aethereus", "grandis")

upper_limit <- c(3700, 700, 2400, 1700, 2250, 2200, 700, 1150, 2200, 1800, 3500, 1000, 4400, 1700, 1150, 3600, 2000, 1400, 2600, 1000, 1000)

lower_limit <- c(2500, 0, 0, 600, 1650, 1000, 0, 0, 650, 0, 1900, 0, 2600, 0, 0, 1500, 0, 0, 1400, 0, 0)

size <- c(26, 24, 22, 21, 21.5, 26.5, 41, 45, 36.5, 39, 36.5, 32, 53, 36.5, 14.5, 16, 17, 37, 39, 50, 50)

# build a data frame ------------------------------------------------------
df <- data.frame(name, genus, species, lower_limit, upper_limit, size)

# convert to tibble format for easier ggplotting
ranges <- tbl_df(df)

# set order of genera to match taxonomy of Birds of Peru field guide
ranges$genus <- ordered(ranges$genus, levels = c("Megascops", "Lophostrix", "Pulsatrix", "Ciccaba", "Bubo", "Pseudoscops", "Glaucidium", "Nyctibius"))

glimpse(ranges)

# visualize the elevation distributions of each species -------------------

##  change plot colour defaults (this is specific to the number of genera; add more if adding genera, or just stick to default (drop the scale_colour_manual() layer)
manu_palette <- c("purple", "orange", "blue", "forestgreen", "red", "#0072B2", "cyan3", "#CC79A7")

## store the plot as an object
p <- ggplot(ranges, 
            aes(x = reorder(x = reorder(x = name, # reorder species names (on the x axis) by body size
                                    X = size, # see reorder() documentation
                                    FUN = max), # or use min if you want 
                            X = genus, # then reorder that by unique values of genus
                            FUN = unique), 
                ymin = lower_limit, # line_range() will draw from this point...
                ymax = upper_limit, # ...to this point
                colour = genus)) + # colour code by genus

  geom_linerange(size = 2) +
  
  geom_text(aes(y = upper_limit, label = size), # plot body size as text above the range bar
            nudge_y = 150, # move it up so it doesn't overlap with the bar
            colour = "black", # otherwise it will plot based on bar colour, which is hard to read
            size = 3) + # uses different font size scale from theme
  
  scale_colour_manual(values = cbPalette) + # use custom colours specified above
  
  # see theme() documentation; lots of customization potential
  theme(axis.text.x = element_text(angle = 70, # english names plotted vertically under x axis
                                   hjust = 1, # alignment
                                   vjust = 1, 
                                   size = 14),
        axis.title.x = element_text(size = 16),
        axis.text.y = element_text(size = 14),
        axis.title.y = element_text(size = 16),
        legend.text = element_text(face = "italic", # italicized genera
                                   size = 14),
        legend.title = element_text(face = "plain", # but keep plain text for legend title
                                    size = 16)) + # make it bigger
  labs(x = "Species", # no x axis label; names are obvious enough
       y = "Elevation (m)", 
       colour = "Genus") # this is the lable for the legend

# print the object to see it
print(p)
