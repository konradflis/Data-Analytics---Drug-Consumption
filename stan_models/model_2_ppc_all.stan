data {
  int<lower=0> N;             // number of observations
  matrix[N, 10] X;            // predictors
}

generated quantities {
  real alpha;                 // intercept
  vector[10] beta;            // regression coeffs
  vector[N] p;                // addiction probability
  vector[N] y_sim;            // label

  alpha = normal_rng(-2.75, 1.5);

  for (i in 1:5) {
    beta[i] = normal_rng(0, 0.25);          // neutral
  }
  for (i in 6:7) {
    beta[i] = normal_rng(0.75, 0.75);       
  }

  beta[8] = normal_rng(-0.2, 0.3);         // age
  beta[9] = normal_rng(-0.4, 0.3);         // gender
  beta[10] = normal_rng(-0.2, 0.05);       // education

  for (n in 1:N) {
    p[n] = inv_logit(alpha + dot_product(X[n], beta));  // addiction probability
    y_sim[n] = bernoulli_rng(p[n]);                     // label
  }
}