data {
  int<lower=0> N;
  matrix[N, 7] X;
}

generated quantities {
  real alpha;
  vector[7] beta;
  vector[N] y_sim;
  vector[N] p;

  alpha = normal_rng(-2.75, 1.5);

  for (i in 1:5)
    beta[i] = normal_rng(0, 0.25);
  for (i in 6:7)
    beta[i] = normal_rng(0.75, 0.75);

  for (n in 1:N) {
    p[n] = inv_logit(alpha + dot_product(X[n], beta));
    y_sim[n] = bernoulli_rng(p[n]);
  }
}