data {
  int<lower=0> N;                        // number of observations
  matrix[N, 7] X;                        // matrix of 7 psychological traits
}

parameters {
  real alpha;                            // intercept
  vector[7] beta;                        // coefficients for predictors
}

model {
  // Priors
  alpha ~ normal(-2, 1);                  // intercept prior
  beta ~ normal(0, 1);                   // weakly informative priors for traits

}

generated quantities {
  vector[N] y_sim;
  for (n in 1:N) {
    y_sim[n] = bernoulli_logit_rng(alpha + dot_product(X[n], beta));
  }
}