data {
  int<lower=0> N;
  array[N] int <lower=0, upper=1> y;
  matrix[N, 7] X;
}

parameters {
  real alpha;
  vector[7] beta;
}

model {
  alpha ~ normal(-2.41, 0.5);
  beta[1:5] ~ normal(0, 0.3);
  beta[6:7] ~ normal(0.5, 0.3);

  y ~ bernoulli_logit(alpha + X * beta);
}

generated quantities {
  vector[N] y_pred;
  for (n in 1:N) {
    y_pred[n] = bernoulli_logit_rng(alpha + dot_product(X[n], beta));
  }
}