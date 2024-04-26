export MY_IP=`curl --ipv4 -s http://whatismyip.akamai.com/`
# export PORT=
export LISTEN_ON=/ip4/0.0.0.0/tcp/$PORT
export ANNOUNCE_ON=/ip4/$MY_IP/tcp/$PORT
export CUDA_VISIBLE_DEVICES=0  # supports multiple cuda devices!
# export IDENTITY=

# organization & experiment name
#export WANDB_ENTITY=CALM
#export HF_ORGANIZATION_NAME=CALM
export EXP_NAME=albert
#export WANDB_PROJECT=$EXP_NAME-hivemind-trainers
#export HF_MODEL_NAME=$EXP_NAME

#export WANDB_API_KEY=TODO_get_your_wandb_key_here_https://wandb.ai/authorize_OR_just_login_on_wandb
#export HF_USER_ACCESS_TOKEN=
# note: you can avoid setting the two tokens above: in that case, the script will ask you to login to wandb and huggingface
export WANDB_DISABLED=true
# export INITIAL_PEERS=
# ^-- If you're runnnng an indepent experiment, this must be your own initial peers. Can be either auxiliary peers or full gpu peers.

ulimit -n 16384 # this line is important, ignoring it may cause Too Many Open Files

python run_trainer.py --run_id $EXP_NAME --host_maddrs $LISTEN_ON --announce_maddrs $ANNOUNCE_ON --identity $IDENTITY \
         --per_device_train_batch_size 1 --gradient_accumulation_steps 1 \
         --initial_peers $INITIAL_PEERS --client_mode
# you can tune per_device_train_batch_size, gradient_accumulation steps,
# --fp16, --gradient_checkpoints based on the device. A good rule of thumb is that the device should compute (batch size x num accumulations)
# gradients over 1-10 seconds. Setting very large gradient_accumulation_steps can cause your peer to miss an averaging round.