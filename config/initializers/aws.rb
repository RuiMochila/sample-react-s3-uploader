Aws.config.update({
  region: "eu-west-2",
  credentials: Aws::Credentials.new(ENV.fetch('S3_KEY'), ENV.fetch('S3_SECRET')),
})
