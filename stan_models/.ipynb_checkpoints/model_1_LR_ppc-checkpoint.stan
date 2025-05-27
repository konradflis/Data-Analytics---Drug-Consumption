data {
  int<lower=0> N;
  matrix[N, 7] X;
}

generated quantities {
  real alpha;
  vector[7] beta;
  vector[N] y_sim;
  vector[N] p;

  alpha = normal_rng(-2.197, 0.5);

  for (i in 1:5)
    beta[i] = normal_rng(0, 0.3);
  for (i in 6:7)
    beta[i] = normal_rng(0.5, 0.3);

  for (n in 1:N) {
    p[n] = inv_logit(alpha + dot_product(X[n], beta));
    y_sim[n] = bernoulli_rng(p[n]);
  }
}