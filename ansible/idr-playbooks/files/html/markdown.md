#Image Data Repository

## Overview

Welcome to the Image Data Repository (IDR). This online, public resource seeks to
store, integrate and serve image datasets from published scientific studies.
We have collected and are continuing to receive existing and newly created
“reference” image datasets that are valuable resources for a broad community
of users, either because they will be frequently accessed and cited or because
they can serve as a basis for re-analysis and the development of new
computational tools.


[![data link](/about/take_a_look.png "Take a look at the data")](/webclient/userdata/?experimenter=-1)

## Goal

The IDR aims to make datasets that have never previously been accessible
publicly available, allowing the community to search, view, mine and even
process and analyze large complex multidimensional life sciences image data.
Sharing data promotes the validation of experimental methods and scientific
conclusions, the comparison with new data obtained by scientists around the
world, and allows the possibility of data reuse by developers of new analysis
and processing tools.

All datasets have been annotated with author-supplied metadata (e.g.,
annotations, defined regions, feature vectors and ontological annotations)
which are all stored and available for browsing. All metadata are also
available through the OMERO API.

## Technology

IDR uses OME’s
[Bio-Formats](http://www.openmicroscopy.org/site/products/bio-formats) and
[OMERO](http://www.openmicroscopy.org/site/products/omero) tools to read,
manage and serve data, and provide links to EMBL-EBI’s molecular and
structural resources. The resource is built upon EMBL-EBI’s OpenStack-based
Embassy infrastructure. All tools used for reading and converting metadata
associated with each dataset are available and all scripts used to build the
infrastructure are maintained and available. We will be extending the system
to enable computational re-analysis of the data.

## Examples

[Datasets in human cells](/webclient/?show=well-45407),
[Drosophila](/webclient/?show=well-547609),
and
[fungi](/webclient/?show=well-590686) are
included. The full
[Mitocheck dataset](/webclient/?show=well-771034) and a
comprehensive
[chemical screen in human cells](/webclient/?show=plate-4101) are
included. Imaging data from
[Tara Oceans](/webclient/?show=plate-4751),
a global survey of plankton and other marine organisms is also included.

Wherever possible, functional annotations (e.g., “increased peripheral
actin") and experimental components have been converted to defined terms in
the [EFO](http://www.ebi.ac.uk/ols/ontologies/efo),
[CMPO](http://www.ebi.ac.uk/ols/ontologies/cmpo) or other
ontologies, always in collaboration with the data submitters
([see example](/webclient/?show=image-109846)). >80% of the functional
annotations have links to defined, published controlled vocabularies.


[![Plate8_Actinome1](/webgateway/render_thumbnail/122770/96/  "Plate8_Actinome1 [Well O02 Field #1]")](/webclient/?show=image-122770)
[![toret-adhesionB](/webgateway/render_thumbnail/928607/96/  "Secondary_001a [Well C05 Field #1]")](/webclient/?show=image-928607)
[![graml-sysgroA](/webgateway/render_thumbnail/1230008/96/  "JL_120731_S6A [Well F-7; Field #1]")](/webclient/?show=image-1230008)
[![mitocheck](/webgateway/render_thumbnail/1484759/96/  "LT0002_02 [Well E2, Field 1]")](/webclient/?show=image-1484759)

## Funding and Project Participants

This project is funded by the BBSRC (BB/M018423/1) and is a collaboration
between the OME Consortium at Dundee (www.openmicroscopy.org), EMBL-EBI and
the University of Cambridge. Further development of the IDR UI is funded by
Euro-BioImaging Prep Phase II award (Horizon2020 Ref:688945). The IDR Project
PIs are [Jason Swedlow (Dundee)](https://www.openmicroscopy.org/site/about/development-teams/jason),
[Alvis Brazma (EMBL-EBI)](http://www.ebi.ac.uk/about/people/alvis-brazma) and
[Rafael Carazo-Salas (Cambridge)](http://www.gen.cam.ac.uk/research-groups/carazo-salas).

## Current Status

Currently the IDR contains 35 Tb of multi-dimensional image data consisting of
26 million individual planes from 20 different imaging studies. Data comes
from studies on human, Drosophila, budding and fission yeast, and mouse cells.
Imaging modalities included so far include high content screens and
histopathology, super-resolution and 3D-SIM datasets.

## The IDR infrastructure

Details of the infrastructure underlying the IDR, and instructions for deploying your IDR own version are on the [IDR Deployment page](/about/idr-deployment.html).
