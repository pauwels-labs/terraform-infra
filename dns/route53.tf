provider "aws" {
  region = "eu-west-1"
  profile = "mfa"  
  assume_role {
    role_arn = "arn:aws:iam::114374921412:role/OrganizationAccountAccessRole"
  }  
}

resource "aws_route53_zone" "pauwelslabs_com" {
  name = "pauwelslabs.com"  
}

resource "aws_route53_zone" "dev_pauwelslabs_com" {
  name = "dev.pauwelslabs.com"  
}

resource "aws_route53_zone" "redact_ws" {
  name = "redact.ws"
}

resource "aws_route53_record" "docs_redact_ws_cname" {
  zone_id = aws_route53_zone.redact_ws.zone_id
  name    = "docs.redact.ws"
  type    = "CNAME"
  ttl     = "60"
  records = [
    "readthedocs.io"
  ]
}

resource "aws_route53_record" "pauwelslabs_com_mx" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = ""
  type    = "MX"
  ttl     = "60"
  records = [
    "10 MAIL.PROTONMAIL.CH",
    "20 MAILSEC.PROTONMAIL.CH"    
  ]
}

resource "aws_route53_record" "pauwelslabs_com_txt_github_verification" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "_github-challenge-pauwels-labs"
  type    = "TXT"
  ttl     = "60"
  records = [
    "79fde57072",
  ]
}

resource "aws_route53_record" "pauwelslabs_com_txt_protonmail_verification" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "60"
  records = [
    "protonmail-verification=c20ae8c935eaa53239d52e85a46201da5964dbea",
    "v=spf1 include:_spf.protonmail.ch mx ~all"
  ]
}

resource "aws_route53_record" "pauwelslabs_com_cname_protonmail_1" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  ttl     = "60"
  records = [
    "protonmail._domainkey.depmvxmidqazixienchgi2tfgmiuwdpqnvavewnmo24l7chhgfuqa.domains.proton.ch."
  ]
}

resource "aws_route53_record" "pauwelslabs_com_cname_protonmail_2" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  ttl     = "60"
  records = [
    "protonmail2._domainkey.depmvxmidqazixienchgi2tfgmiuwdpqnvavewnmo24l7chhgfuqa.domains.proton.ch."
  ]
}

resource "aws_route53_record" "pauwelslabs_com_cname_protonmail_3" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  ttl     = "60"
  records = [
    "protonmail3._domainkey.depmvxmidqazixienchgi2tfgmiuwdpqnvavewnmo24l7chhgfuqa.domains.proton.ch."
  ]
}

resource "aws_route53_record" "pauwelslabs_com_txt_keybase_pauwelslabs_verification" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "_keybase"
  type    = "TXT"
  ttl     = "300"
  records = [
    "keybase-site-verification=K4v6le2Zle1zeptqwWEYkiFO152FsmZwX3XvR1ja2Fc"
  ]
}

resource "aws_route53_record" "pauwelslabs_com_dev_ns" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "dev.pauwelslabs.com"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.dev_pauwelslabs_com.name_servers
}
