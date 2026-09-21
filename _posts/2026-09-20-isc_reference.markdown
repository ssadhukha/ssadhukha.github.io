---
layout: post
title:  "Intersubject Correlation Reference"
subtitle: "Temporal, spatial & spatiotemporal variants of ISC"
lede: "It took me a while to notice these variants exist and another few times of forgetting what they’re useful for."
date:   2026-09-20 08:00:00 -0400
---

Most papers use intersubject correlation (ISC) to ask: do people's brain timecourses rise and fall together while they watch a movie or listen to a story? This is temporal ISC, the original measure introduced by the Hasson lab, that people often use to talk about neural synchrony [[Hasson et al., 2004](#ref1)]. But you can also use ISC to ask whether people's brains are "in sync" across space, or across space *and* time at once. 

It took me a while to notice these variants exist and another few times of forgetting what they’re useful for. So I wrote a quick reference, and a really short “field note” to get into it.  

<div class="isc-card-links">
  <a class="isc-card-link" href="#temporal-isc-the-original-isc">Temporal ISC</a>
  <a class="isc-card-link" href="#spatial-isc">Spatial ISC</a>
  <a class="isc-card-link" href="#spatiotemporal-isc">Spatiotemporal ISC</a>
</div>

## The problem with blocked designs

fMRI used to mostly mean block or event-related designs (i.e., task-based fMRI). Show someone images of houses, then faces, contrast the two. This worked, but it also boxed you in twice. For these kinds of setups, first, you needed repetition; you had to average across many trials to pull the signal from the noise, so stimuli had to be simple and repeatable, and your stimulus set had to be small because otherwise your scan session would become impractically long.  

Second, with GLM-based analyses, you had to determine in advance which features of the stimulus mattered for driving brain responses. For houses and faces, or other contrasts like this, logging this information was easy because you already knew the axis that matters (or that you were trying to investigate). But for more complex stimuli like a movie or a story, the feature space is effectively unbounded and you don’t know in advance which features drive responses, especially given the different timescales at which these things operate. Any set of features you choose to model bakes in your assumptions about what matters, so what you end up capturing would likely be incomplete.

In short, these designs constrained the data and the data constrained the questions. This also meant that higher-order cognition as it unfolds *continuously*, where the cognitive state *depends* on accumulated context, was harder to explore given these methodological constraints.

ISC came out of a growing interest in more complex, naturalistic stimuli [[Hasson et al., 2004](#ref1)]. Its move is to stop modeling the stimulus at all. The basic assumption is:

> If a brain region is responding to the stimulus, it should respond similarly across people watching and/or listening to the same thing. 

In other words, ISC uses consistency across subjects as the signal itself, which eliminates the need for both explicit stimulus models and repeated trials. 

## Interpreting high ISC vs. low ISC

The way to interpret high ISC voxels is that they are actually encoding something stimulus-locked. This follows directly from the method's basic assumption [Nastase et al., 2019](#ref2). Though one caveat here is that shared motion and physiology may also contribute to high ISC values.  

Low ISC is trickier to interpret. For instance, it could mean the voxel or region isn't tracking the stimulus at all and engaging in something like spontaneous thought which is likely to vary across people. Or it might be capturing some interaction between the stimulus and a person's endogenous processing (past experiences, current goals, internal states, etc.), which is also likely to vary across people. A lot of folks file low ISC under "noise" and move on, but I personally think that's where a lot of the interesting stuff is hiding. 

## Temporal ISC (The original ISC) 

#### What it measures

How similarly do subjects' brains respond across time?  

#### How it works

1. For a given voxel or ROI, take each subject's BOLD time series (a single timecourse) and correlate it with every other subject's, pairwise. This gives you a subject-by-subject correlation matrix. 

2. Take the average of these pairwise correlations (using the upper or lower triangle of the matrix to avoid counting pairs twice). This average is your ISC value. 

![Schematic showing pairwise correlations of BOLD time series across subjects](/assets/isc1.png)

This can be computed at multiple spatial scales: voxel-level (ISC for each voxel separately) or ROI-level (ISC for averaged activity within a region) [[Nastase et al., 2019](#ref2)]. For more, you can check out this [tutorial](https://naturalistic-data.org/content/Intersubject_Correlation.html) which includes example code and walks through hypothesis testing. 

## Spatial ISC

This is the spatial analogue of the original ISC. I'll start with the simplest version which is also called “intersubject pattern correlation” (ISPC) [[Nastase et al., 2019](#ref2)].

#### What it measures
How similar are subjects' spatial patterns of brain activity, at a specific timepoint (or time window)?

> While temporal ISC asks "do subjects' brains respond at the same times?", spatial ISC asks "do subjects show the same spatial *pattern* of activation at a given moment?" This can reveal whether subjects are engaging the same network configuration during a given event. For example, during an emotional scene, do all subjects show a similar pattern of high vmPFC and low dlPFC activity?

#### How it works
Say we choose V1 (primary visual cortex, ~500 voxels) as our ROI, and we’re interested in the spatial pattern across subjects at timepoint 7. 

1. At timepoint 7, grab each subject's spatial pattern — the activations across all 500 voxels. Each subject now has a 500-element vector.

2. Correlate each subject's vector with every other subject's (pairwise). This gives you a subject-by-subject correlation matrix for that timepoint. Note the correlation is over voxel position: same 500 values in a different arrangement correlate near zero, because it's the voxel-by-voxel pairing that carries the signal, not the values themselves.

3. Average these pairwise correlations (using the upper or lower triangle of the matrix to avoid counting pairs twice). This average is your *spatial* ISC value for timepoint 7.

![Schematic showing spatial ISC computation at a single timepoint](/assets/isc2.png)

That's it! Now here are the other fun things you can do. 

### Tracking spatial ISC over time

If you want to see how spatial ISC *evolves* over time, repeat steps 1–3 at each timepoint and you get a separate correlation matrix per timepoint; aggregate those into a timecourse of how spatial similarity within an ROI (like V1) rises and falls across the stimulus (see Fig. 1D in [[Chang et al., 2021](#ref3)] for an example).

![Timecourse of spatial ISC values across the stimulus](/assets/isc3.png)

### Other spatial scales

You can also compute spatial ISC across multiple ROIs (e.g., vmPFC, dlPFC, V1, auditory cortex) or within specific brain networks (e.g., only DMN regions). The logic is identical, you're just choosing different spatial units.  


## Spatiotemporal ISC

#### What it measures

How similar are subjects' spatial patterns *and* their evolution over time, taken together?

#### How it works

1. For each subject, grab the spatial pattern (500 voxels) at every timepoint (say 100 total). This is the full voxels × timepoints matrix. Flatten it by stringing the per-timepoint patterns end to end into a single 50,000-element vector. That's a *trajectory* through voxel space.

2. Correlate each subject’s trajectory with every other subject’s, pairwise. 

3. Average the pairwise correlations (upper or lower triangle, to avoid counting pairs twice). This value is your spatiotemporal ISC.  

Because you're correlating across voxels here, the voxels have to be functionally aligned first (via hyperalignment or a shared response model) [[Nastase et al., 2019](#ref2)]. 

![Schematic showing pairwise correlations of ordered sequence of spatial patterns across subjects](/assets/spatiotemporal_isc.png)

## How to think about this stuff

One way I find helpful to think about ISC variants is to start with the question: what is the change in the signal that we care about? Is it how the signal changes over *time*? Is it how the signal changes over *space*? Or both, across time *and* space? Thinking about it like this gives you a quick sense of what exactly goes into the vectors that you end up correlating. 

<div class="references-section">
<ol>
<li><a id="ref1"></a>Hasson, Uri, Yuval Nir, Ifat Levy, Galit Fuhrmann, and Rafael Malach. 2004. <a href="https://doi.org/10.1126/science.1089506" target="_blank">“Intersubject Synchronization of Cortical Activity during Natural Vision.”</a> Science (New York, N.Y.) 303 (5664): 1634–40.</li>

<li><a id="ref2"></a>Nastase, Samuel A., Valeria Gazzola, Uri Hasson, and Christian Keysers. 2019. <a href="https://doi.org/10.1093/scan/nsz037" target="_blank">“Measuring Shared Responses across Subjects Using Intersubject Correlation.”</a> Social Cognitive and Affective Neuroscience 14 (6): 667–85.</li>

<li><a id="ref3"></a>Chang, Luke J., Eshin Jolly, Jin Hyun Cheong, Kristina M. Rapuano, Nathan Greenstein, Pin-Hao A. Chen, and Jeremy R. Manning. 2021. <a href="https://doi.org/10.1126/sciadv.abf7129" target="_blank">"Endogenous Variation in Ventromedial Prefrontal Cortex State Dynamics during Naturalistic Viewing Reflects Affective Experience."</a> Science Advances 7 (17).</li>

</ol>
</div>

<p class="post-footnote">Figures/schemas were made in Adobe Illustrator.</p>
