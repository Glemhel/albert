# Hivemind example setup

Using Hivemind base example ALBERT, we reproduce it for our needs in the test scenario.

Each peer should run `run_trainer.sh` with options:
  - Fill PORT, IDENTITY with custom values
  - Fill INITIAL_PEERS with multiaddr of initial peers (hidden for security reasons for now)
  - Tune training parameters per_device_batch_size and gradient_accumulation_steps
  - Use --client_mode if peer is behind firewall
  