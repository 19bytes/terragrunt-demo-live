# terragrunt-demo-live

Der Code der Terraform Module wird hier: [Terraform Module Repo](https://github.com/19bytes/terragrunt-demo-modules) verwaltet.

## Voraussetzungen

Installation von:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [az](https://learn.microsoft.com/en-gb/cli/azure/install-azure-cli) (Auzre CLI) Falls Azure als Remote Backend verwendet wird.
- [Hetzner Cloud](https://www.hetzner.com/de/cloud) Projekt

### Zugang zur Hetzner Cloud

Im Hetzner Projekt einen API Key erzeugen:

- Wir loggen uns in die Hetzner Cloud Oberfläche ein.
- Wir wählen das gewünschte Cloud Projekt in der Hetzner Cloud Oberfläche aus.
- Navigieren am linken Bildschirmrad zu dem Punkt Security (unterster Punkt).
- Wählen dann den Punkt API tokens
- Dort wählen wir über die Schaltfläche Generate API token, fügen in dem neu geöffneten Modalfenster eine aussage kräftige Beschreibung ein und wählen als Permissions Read & Write aus. Abschließend bestätigen wir mit Generate API token und notieren uns den erzeugten API token.

- Den Hetzner API Key als Umgebungsvariable setzen

```bash
# Unix
# .bashrc / .zshrc
export TF_VAR_hcloud_token="YourCloudToken"
```

## Einrichtung des Remote-Backends

In diesem Beispiel wird ein Azure Blob Storage als Remote Backend genutzt. Man kann ebenso mit einem lokalen Backend arbeiten.
Weiteres zu [Terraform Backends](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)

### Azure

Der User der in der az-cli eingeloggt ist benötigt die entsprechenden Berechtigungen um auf den Azure Blob-Storage zuzugreifen.

```bash
# Im Terminal
az login 
```

Dann wird man zur Login-Seite des Azure Portals geleitet, dort wird der Login mit dem entsprechenden Nutzer durgeführt.

Das Remote Backend wird nun automatisch mit angelegt, für die jeweilige Stage.

## Ausführen des Beispiels

Wir wechseln in die jeweilige zu deployende Stage und führen unseren Code aus:

```bash
cd stage/development
terragrunt run-all plan
terragrunt run-all apply 
```
