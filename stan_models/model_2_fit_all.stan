data {
  int<lower=0> N;          
  matrix[N, 10] X;     
  array[N] int <lower=0, upper=1>  y;     
}

parameters {
   real alpha;
   vector[10] beta;
}

model {

  alpha ~ normal(-1, 0.5);

  for (i in 1:5) {
    beta[i] ~ normal(0, 0.3);          
  }

  for (i in 6:7) {
    beta[i] ~ normal(0.5, 0.3);       
  }

  beta[8] ~ normal(-0.2, 0.3);    
  beta[9] ~ normal(-0.4, 0.3);     
  beta[10] ~ normal(-0.2, 0.05); 

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