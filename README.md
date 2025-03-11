# Option Pricing with Lattice Models

## Overview

This repository contains the code and thesis paper for my Master's research project on option pricing using lattice-based models. The research focuses on comparing the performance of different hedging methods under the Constant Elasticity of Variance (CEV) model, an alternative to the Black-Scholes-Merton (BSM) model that addresses its limitations in incorporating skewness and excess kurtosis.

## Project Summary

In my thesis, I developed recursive trinomial lattice approaches for pricing European, American, Bermudan, and Asian (Arithmetic and Geometric average) options under the CEV model. The research aims to:

*   **Implement recursive trinomial lattice methods:** Develop and implement algorithms for pricing various option styles under the CEV model.
*   **Compare CEV to BSM:** Compare the option prices obtained using the CEV model with those from the BSM model to assess their differences and similarities.
*   **Analyze Hedging Performance:** Evaluate the effectiveness of delta and delta-gamma hedging strategies for option portfolios under different contract styles, using both ordinary and auxiliary trinomial lattices.
*   **Assess Approximation Errors:** Analyze the approximation errors associated with delta and delta-gamma hedging for different elasticity values and market volatility conditions.

The key findings of the research include:

*   For recursive trinomial option pricing under the CEV model, the number of time steps significantly impacts the accuracy of the results.
*   The auxiliary lattice approach provides more effective Greeks (delta and gamma) for hedging compared to the ordinary trinomial lattice.
*   Delta-gamma hedging outperforms linear delta hedging, especially for larger price movements in the underlying asset.
*   Delta and delta-gamma approximations perform better for Asian option portfolios compared to European, American, and Bermudan options.
*   In low volatility markets, delta and delta-gamma approximations under the CEV model show slightly improved accuracy compared to the BSM model (when elasticity is close to 2) for European, American, and Bermudan options.

## Repository Contents

*   **`option_pricing_and_greeks/`:** This directory contains the code for option pricing and calculating Greeks (delta and gamma).
*   **`hedging_Analysis/`:** This directory contains the code for performing hedging analysis and simulating hedging strategies.
*   **`hedging/`:** This directory contains related hedging code or data. 
   

*   **`thesis/`:** This directory contains the thesis paper in PDF format.
    *   `OptionPricingThesis.pdf`: The complete thesis document.
*   **`README.md`:** This file.

## Technologies Used
*   MATLAB
## Getting Started

1.  **Clone the repository:**

    ```
    git clone https://github.com/farhanataiyebah/LatticeBasedOptionValuation
    cd LatticeBasedOptionValuation
    ```


## Thesis Paper

The `thesis/OptionPricingThesis.pdf` file contains the full details of the research methodology, results, and conclusions.

## Author

*   Farhana Taiyebah
*   taiyebahfarhana@gmail.com
*   https://github.com/farhanataiyebah

