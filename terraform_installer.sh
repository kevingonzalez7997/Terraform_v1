# Install necessary dependencies
sudo apt install -y unzip jq

# Fetch the latest version of Terraform from the HashiCorp API using jq for JSON parsing
latest_version=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)

# Download the Terraform binary zip file for Linux AMD64
wget "https://releases.hashicorp.com/terraform/${latest_version}/terraform_${latest_version}_linux_amd64.zip"

# Unzip the downloaded Terraform binary
unzip "terraform_${latest_version}_linux_amd64.zip"

# Move the Terraform binary to the /usr/local/bin directory to make it accessible globally
sudo mv terraform /usr/local/bin/

# Display a message indicating the completion of the Terraform installation along with the installed version
echo "Terraform installation completed. Version installed : $(terraform --version)"

# Clean up: Remove the downloaded Terraform binary zip file
rm "terraform_${latest_version}_linux_amd64.zip"
