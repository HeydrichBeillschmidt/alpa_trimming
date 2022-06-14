import jax
import jax.numpy as jnp
import numpy as np

import alpa

N = 1024
n_iter = 5

x = np.ones((N, N), dtype=np.float32)
w = np.ones((N, N), dtype=np.float32)


def compute_numpy():
    y = x
    for i in range(n_iter):
        y = y @ w
    return y


def func(a, b):
    init_state = (0, x, w)
    cond_func = lambda state: state[0] < n_iter
    body_func = lambda state: (state[0] + 1, state[1] @ state[2], state[2])

    final_state = jax.lax.while_loop(cond_func, body_func, init_state)
    return final_state[1]


def compute_jax_jit():
    return jax.jit(func)(x, w)


def compute_alpa():
    return alpa.parallelize(func)(x, w)


# Check correctness
expected = compute_numpy()
# actual = compute_jax_jit()
actual = compute_alpa()
np.testing.assert_allclose(expected, actual)

# Inspect the HLO IR
hlo_text = jax.jit(func).lower(x, w).compile().compiler_ir()[0].to_string()
print(hlo_text)

# Currently, alpa does not support while loop. The following function
# causes assertion errors. We want to support it.
# actual = compute_alpa()
# np.testing.assert_allclose(expected, actual)