# Log Export: PubSub destination at Billing Account level

This example configures a billing-account-level log sink that feeds a pubsub topic destination

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| parent\_resource\_id | The ID of the project in which pubsub topic destination will be created. | string | n/a | yes |
| project\_id | The ID of the project in which the log export will be created. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| destination\_map | Outputs from the destination module |
| log\_export\_map | Outputs from the log export module |

[^]: (autogen_docs_end)
