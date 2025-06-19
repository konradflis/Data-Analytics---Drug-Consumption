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
  alpha ~ normal(-2.75, 1.5);
  beta[1:5] ~ normal(0, 0.25);
  beta[6:7] ~ normal(0.75, 0.75);

  y ~ bernoulli_logit(alpha + X * beta);
}

generated quantities {
  vector[N] y_pred;
  vector[N] p;
  for (n in 1:N) {
    p[n] = inv_logit(alpha + dot_product(X[n], beta));
    y_pred[n] = bernoulli_rng(p[n]);  
  }
}