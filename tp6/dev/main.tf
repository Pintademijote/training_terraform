module "ec2module" {
  source  = "../modules/ec2module"

  taille_ec2  = "t2.nano"
  tag_ec2 = {
    Name = "ec2-dev-pg"
    Formation = "ajc"
   }
   sg_name="pg_sg_dev"
   keyname_type="dev"
}