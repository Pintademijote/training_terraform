module "ec2module" {
  source  = "./modules/ec2module"

  taille_ec2  = "t2.micro"
  tag_ec2 = {
    Name = "ec2-prod-pg"
    Formation = "ajc"
   }
}