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

resource "aws_route53_zone" "staging_pauwelslabs_com" {
  name = "staging.pauwelslabs.com"
}

resource "aws_route53_zone" "redact_ws" {
  name = "redact.ws"
}

resource "aws_route53_zone" "dev_redact_ws" {
  name = "dev.redact.ws"
}

resource "aws_route53_zone" "staging_redact_ws" {
  name = "staging.redact.ws"
}

resource "aws_route53_zone" "bitmantle_com" {
  name = "bitmantle.com"
}

resource "aws_route53_zone" "dev_bitmantle_com" {
  name = "dev.bitmantle.com"
}

resource "aws_route53_zone" "staging_bitmantle_com" {
  name = "staging.bitmantle.com"
}

resource "aws_route53_record" "bitmantle_com_dev_ns" {
  zone_id = aws_route53_zone.bitmantle_com.zone_id
  name    = "dev.bitmantle.com"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.dev_bitmantle_com.name_servers
}

resource "aws_route53_record" "bitmantle_com_staging_ns" {
  zone_id = aws_route53_zone.bitmantle_com.zone_id
  name    = "staging.bitmantle.com"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.staging_bitmantle_com.name_servers
}

resource "aws_route53_record" "redact_ws_dev_ns" {
  zone_id = aws_route53_zone.redact_ws.zone_id
  name    = "dev.redact.ws"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.dev_redact_ws.name_servers
}

resource "aws_route53_record" "redact_ws_staging_ns" {
  zone_id = aws_route53_zone.redact_ws.zone_id
  name    = "staging.redact.ws"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.staging_redact_ws.name_servers
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

resource "aws_route53_record" "bitmantle_com_mx" {
  zone_id = aws_route53_zone.bitmantle_com.zone_id
  name    = ""
  type    = "MX"
  ttl     = "60"
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
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

resource "aws_route53_record" "bitmantle_com_txt_gmail_verification" {
  zone_id = aws_route53_zone.bitmantle_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = "60"
  records = [
    "google-site-verification=ceeuB5-dR4_zJpg5ZO_mipBrW9fC6O1CfHEVCN3dOUo"
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

resource "aws_route53_record" "bitmantle_com_text_dmarc" {
  zone_id = aws_route53_zone.bitmantle_com.zone_id
  name    = "google._domainkey"
  type    = "TXT"
  ttl     = "60"
  records = [
    "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2C+RsfWWLOPnWD37N7dnmr+B3ricN+lxOQ5EkRiDkFvbY8MPy6IPBoDSfFRkocZhyf2KHawrW2oT0ksOWm8ebYzQf4oLuqFEaxoEhj2KEGj082pSREHuG4xMnmj1NAZ7CQ26HZlpvVx2cGPfRAz+oKtYkFGz+8QcNeC5ZBEwb0YwOqCCpbpW8Jo9sDGAMrrX8\"\"dhtG2BU1TgAGuB23IcAz7jxPSm+gD5BVD0mfq7ZEiFGUBRT7x2hE47Iego4b5mZP/GvCYeFzHVrH6jvWckqT/EXl5OR/lXPDw/CmFotjULDIVctfbK9ZndkKNfJzs2nQbThibv63DqmmWVuSPhiewIDAQAB"
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

resource "aws_route53_record" "pauwelslabs_com_staging_ns" {
  zone_id = aws_route53_zone.pauwelslabs_com.zone_id
  name    = "staging.pauwelslabs.com"
  type    = "NS"
  ttl     = "60"
  records = aws_route53_zone.staging_pauwelslabs_com.name_servers
}
