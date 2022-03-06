#### Initialize ####
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(tidyverse)
library(janitor)
library(xml2)

####USER DEFINED VARS####
# pgd_file <- "Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.pgd"
ima_metadata_file <- "Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima.metadata"
ima_seqs_file <- "Pfalcifer.3.7.Fltr19.popmap.3.7.ppr_genclust.haps2.ima.seqs"
                  
out_file_name <- 
  str_replace(ima_seqs_file,
              "\\.seqs$",
              "\\.prearp")

#### READ IN DATA & WRANGLE ####
ima_metadata <-
  read_delim(ima_metadata_file,
             col_names = FALSE) %>%
  ######################### make smaller for testing ###################
  # filter(X1 == "dDocent_Contig_1018" | X1 == "dDocent_Contig_3003" | X1 == "dDocent_Contig_6699") %>%
  rename(locus = X1,
         At_LightBlue = X2,
         At_DarkBlue = X3,
         Kr = X4,
         Pk = X5,
         St = X6,
         bp = X7) %>%
  select(-X8:-X9) %>%
  # mutate(alleles_per_locus = At_LightBlue + At_DarkBlue + Kr + Pk + St) %>%
  mutate(bp = bp -30) %>%
  pivot_longer(cols = At_LightBlue:St) %>%
  uncount(weights = value)

ima_seqs <-
  read_delim(ima_seqs_file,
             col_names = FALSE,
             ################################# make smaller for testing ###########
             n_max = nrow(ima_metadata),
             skip =5) %>%
  select(-X2:-X4) %>%
  rename(individual_id = X1,
         sequence = X5)

#### CALCULATE HOW MANY BP IN EACH CONTIG TO MAKE MISSING HAPLOTYPES #####

# depricated, the bp from the ima file is generally wrong, so this doesn't work
# locus_na <-
#   ima_metadata %>%
#   mutate(dummy_seq = strrep("?",
#                             bp)) %>%
#   select(-name) %>%
#   distinct() %>%
#   pull(dummy_seq) %>%
#   as.character() %>%
#   as.list()

locus_na <-
  bind_cols(ima_metadata,
            ima_seqs) %>%
  distinct(locus,
           sequence) %>%
  mutate(bp = nchar(sequence)) %>%
  select(-sequence) %>%
  distinct() %>%
  mutate(dummy_seq = strrep("?",
                            bp)) %>%
  pull(dummy_seq) %>%
  as.character() %>%
  as.list()

names(locus_na) <- 
  ima_metadata %>% 
  pull(locus) %>% 
  unique()

#### COMBINE DATA INTO PSEUDO ARLEQUIN FORMAT ####

data <-
  bind_cols(ima_metadata,
          ima_seqs) %>%
  select(-bp) %>%
  pivot_wider(names_from = locus,
              values_from = sequence) %>%
  replace_na(locus_na) %>%
  mutate(orig_id = str_c(str_sub(name,
                                 1,
                                 2),
                         "_P",
                         individual_id,
                         sep=""),
         place_holder = str_sub(individual_id,
                                -1,
                                -1)) %>%
  select(name,
         orig_id,
         place_holder,
         dDocent_Contig_1018:last_col()) %>%
  arrange(name,
          orig_id,
          place_holder)

#### CHECK BP CALCS, SHOULD BE NO VARIATION WITHIN LOCI ####
data %>%
  pivot_longer(cols = starts_with("dDocent_Contig"),
               names_to = "contig",
               values_to = "sequence") %>%
  mutate(bp = nchar(sequence)) %>%
  group_by(contig,
           name) %>%
  summarize(bp_mean = mean(bp,
                           na.rm=T),
            bp_sd = sd(bp,
                       na.rm=T)) %>%
  filter(bp_sd != 0) %>%
  ggplot(aes(x=contig,
             y=bp_mean,
             # color = contig
             )) +
  geom_point() +
  geom_errorbar(aes(ymin=bp_mean-bp_sd,
                    ymax=bp_mean+bp_sd)) +
  labs(title="There should be no contigs in the plot")

# data %>%
#   select(name:place_holder,
#          dDocent_Contig_2860,
#          dDocent_Contig_3455,
#          dDocent_Contig_529,
#          dDocent_Contig_8858,
#          dDocent_Contig_9040,) %>%
#   pivot_longer(cols = starts_with("dDocent_Contig"),
#                names_to = "contig",
#                values_to = "sequence") %>%
#   mutate(bp = nchar(sequence)) %>%
#   ggplot(aes(x=orig_id,
#              y=bp,
#              color = contig
#   )) +
#   geom_point()


#### OUTPUT PSEUDO ARLEQUIN FILE ####
write_delim(data,
            out_file_name,
            quote="none")  

