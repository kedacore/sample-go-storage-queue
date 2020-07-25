# KEDA Azure Storage Queue Trigger Samples

Sample program for sending/receiving queue and KEDA v2 Azure Storage Queue Trigger. 

# How to run the sample

## Prerequisite
* Install Go lang (1.13+)
* Docker

## Set Enviornment Variables for the container

| Key | Description |
| ---- | ------ |
| ConnectionString | The Connection String for the Azure Storage Account |
| queueName | The name of the queue |

## Run queue receiver/sender

### receiver

Receive queue messages.

```bash
$ cd cmd/receive
$ go run receive.go
```

### sender

Send 100 messages to the Azure Storage Queue.

```bash
$ cd cmd/send
$ go run send.go 100
```

# How to debug

To see the behavior, you can debug it. This is the sample of the VSCode `.vscode/launch.json`. Then Start Debugging. 
It requires, VSCode [Go extension](https://marketplace.visualstudio.com/items?itemName=golang.Go).

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${fileDirname}",
            "env": {
                "ConnectionString": "YOUR_STORAGE_ACCOUNT_CONNECTION_STRING_HERE",
                "QueueName":"hello"
            },
            "args": []
        }
    ]
}
```

## Run with KEDA

### Prerequisite
KEDA v2 is deployed already. 
You have a kubernetes cluster and configured with kubectl. 

### Start the ScaledJob

#### Copy deploy-consumer-job.yaml.example to deploy-consumer-job.yaml
Modify `YOUR_BASE64_CONNECTION_STRING_HERE` as your Storage Account Connection String with Base64 encoded. 

Then Apply it. This will create a secret, ScaledJob with Storage Queue Trigger.

```
$ kubectl apply -f deploy/deploy-consumer-job.yaml
```

Send queue to the target queue. You can do it with the `send` command. This command will send 3 messages with cleaning up existing messages.

```
$ cd cmd/send
$ export ConnectionString="YOUR_CONNECTION_STRING_HERE"
$ export queueName=hello
$ go run send.go 3
```