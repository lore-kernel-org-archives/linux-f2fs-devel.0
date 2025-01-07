Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6259E77197
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jan 2025 18:16:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tVE7v-0006mD-Mr;
	Tue, 07 Jan 2025 18:16:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1tVE7q-0006m3-VD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jan 2025 18:16:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UExxcpCdfTsbTmzHCTMTBTh1+P52/4iPUCwoN1TLcVg=; b=fl14dgNRhWHCHZqnajhXrSHigO
 aNjFHjHU8M8PBwgupDyMh295i4iwMK+tLpvu2jr8IX4jNl+7vyhF5LUj69nVU0ssEdzKkrtfuW4ia
 RDZ+ZGyAZJ1IFM+/K0alc7UyE1BfsPOJowMvBm3Ofdr6OUhIEiJE3/gb03sXMo4uCpFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UExxcpCdfTsbTmzHCTMTBTh1+P52/4iPUCwoN1TLcVg=; b=DgTkaC+TXs/5AfSIaTPWEzau5A
 sTHR8cIn9byEXUBS50s67qYW6TDZyub+3Acjy60Fv4H+g/6gcQmNJBByVRMFSzZ1rmY8KQZ1O7KxO
 yzBCWrNr0oRRrYlJ2cvGSjSVeYNS3KFlcqe9nfJPaRoV4urgB4RvZu5CH63PcNIV4Nuo=;
Received: from mail-vk1-f178.google.com ([209.85.221.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tVE7p-0007mL-P6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jan 2025 18:16:22 +0000
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5187cd9b8e5so4938433e0c.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 Jan 2025 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736273776; x=1736878576; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UExxcpCdfTsbTmzHCTMTBTh1+P52/4iPUCwoN1TLcVg=;
 b=Sf0V+AC6GeWZABvYBLU/FHtxRjQpAM9APS4ODNA5wdI7B+f0udVBurbTGk4AC9oawJ
 /uwMCfQSrPQC2Y/TTuaXtNI3NaIyzt41WsxffsnwzdeRvvIjrK8A4Kdny6tTaOT6DXQ8
 F29C7xPO+OMf3mVMQ0WJ6NdlVMftlhpCWyEXh5sklMgUtTafJbJT1S7kIDvjQz/OlZ/z
 vFHrD71ArAIcTUToBA+OmRt5fD77ebi0go8Ma/mRPYbuQ9geWkdg4TFzTNug6XdoLoLi
 y7Hf6cKgg2ggaJXQBIPK2z7fD2zUQEKIybZB9QBxp0RJGPwjljmJh7MSHZOGirZbx37F
 fiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736273776; x=1736878576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UExxcpCdfTsbTmzHCTMTBTh1+P52/4iPUCwoN1TLcVg=;
 b=tzLqBh9tI8vxRVZxoNNK7EFz7tHyy5FuKTGDm4bXgK5dvSVAdncFNnV9NbcrqrVw5h
 bHNvWMYRisUbLTFCS8xEqENbxGwbu4iA1/Tupp+QRevNCzKOcD8qmScVBxPi56K5u0j/
 bsKglDzqUHHSvf1ro/jlc96ZeOULula4tWL8PTMC2+Qm0WuGlzznwJVzFzu99P4d+6kg
 dveVWzdrzStRRKg/hT6XFC5Wqt23PmPCj/oEYJKZbFLvyz7S3KSdfrafhQWF9aWgDatU
 0m6h7sqXgUW0pHQ7lWgqQmHSyj00x0a7uT2UZTyVGIROGc3BhD92m7V2lq4ni69e2OCR
 1+vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0aFyVwpn5X7QMrU9fiuo085kbAGjbiFBm+R13pV2/K1MaQ6KPpVEPNyA7sL/ThaAQrrtAmCxTsP2mFT2dR4/f@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyXwwyzjmeU5joHhmIxwcq7zi8IyY20CDzQ1xJXwfQbxZgFhXP5
 0WSUK+Cg/isWEH9uEaz7uEfcBZhXZYuvAktrs6ze1MjU+xd78oujBnYHd5b3hirPsl66nasTNGa
 TyA2DcEY1Ui4i1dpPfzkUr2r3Nb3W0Pc/
X-Gm-Gg: ASbGncvBjNrAgV1NaSBMspxtmKgaABhtWP2uPZuGwzLesJawi/WBt+lIyecJ2SsHwwB
 ojeR/UWwbgN7uhd7QOV3JMPkwjfZwn23LjgASk65KGu4T/ANq55akwMleXMVFs5E7NxmA
X-Google-Smtp-Source: AGHT+IGaobdeB9My3aaHJEyiFzc/D92OyQLbVj7nK7zwifry6Aa2ccokTW3PmwZ1RPvqK9q1gVblq7+zMTjX6KEpnVs=
X-Received: by 2002:a05:6122:458b:b0:518:8bfe:d5f0 with SMTP id
 71dfb90a1353d-51c6c2b3d25mr187793e0c.0.1736273775757; Tue, 07 Jan 2025
 10:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20250107023248.3702924-1-jaegeuk@kernel.org>
 <86062930-7a8d-40c5-bbe5-b5bd62fc04ec@kernel.org>
In-Reply-To: <86062930-7a8d-40c5-bbe5-b5bd62fc04ec@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 7 Jan 2025 10:16:03 -0800
X-Gm-Features: AbW1kvbHTq87O4bYIZCdXjj1s_JglS8T3nc-uQtpDQxjih1ixl_auDrPyxKcH_Q
Message-ID: <CACOAw_yE01siQ3AgK=PRdoiD3kX1Wn2aAFDb3V9MKPecn6pcYA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tVE7p-0007mL-P6
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't call block truncation for
 aliased file
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCBKYW4gNywgMjAyNSBhdCA3OjAw4oCvQU0gQ2hhbyBZdSB2aWEgTGludXgtZjJmcy1k
ZXZlbAo8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ+IHdyb3RlOgo+Cj4g
T24gMjAyNS8xLzcgMTA6MzIsIEphZWdldWsgS2ltIHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3Rl
Ogo+ID4gVGhpcyBwYXRjaCBzaG91bGQgYXZvaWQgdGhlIGJlbG93IHdhcm5pbmcgd2hpY2ggZG9l
cyBub3QgY29ycnVwdCB0aGUgbWV0YWRhdGEKPiA+IHRoby4KPiA+Cj4gPiBbICAgNTEuNTA4MTIw
XVsgIFQyNTNdIEYyRlMtZnMgKGRtLTU5KTogYWNjZXNzIGludmFsaWQgYmxrYWRkcjozNgo+ID4g
WyAgIDUxLjUwODE1Nl1bICBUMjUzXSAgX19mMmZzX2lzX3ZhbGlkX2Jsa2FkZHIrMHgzMzAvMHgz
ODQKPiA+IFsgICA1MS41MDgxNjJdWyAgVDI1M10gIGYyZnNfaXNfdmFsaWRfYmxrYWRkcl9yYXcr
MHgxMC8weDI0Cj4gPiBbICAgNTEuNTA4MTYzXVsgIFQyNTNdICBmMmZzX3RydW5jYXRlX2RhdGFf
YmxvY2tzX3JhbmdlKzB4MWVjLzB4NDM4Cj4gPiBbICAgNTEuNTA4MTc3XVsgIFQyNTNdICBmMmZz
X3JlbW92ZV9pbm9kZV9wYWdlKzB4OGMvMHgxNDgKPiA+IFsgICA1MS41MDgxOTRdWyAgVDI1M10g
IGYyZnNfZXZpY3RfaW5vZGUrMHgyMzAvMHg3NmMKPiA+Cj4gPiBGaXhlczogMTI4ZDMzM2YwZGZm
ICgiZjJmczogaW50cm9kdWNlIGRldmljZSBhbGlhc2luZyBmaWxlIikKPiA+IFNpZ25lZC1vZmYt
Ynk6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+Cj4gPiAtLS0KPiA+ICAgZnMvZjJm
cy9ub2RlLmMgfCA2ICsrKysrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvbm9kZS5jIGIvZnMvZjJmcy9ub2RlLmMKPiA+
IGluZGV4IGMwNGVlMWE3Y2U1Ny4uMDYzMTNlMWViODg0IDEwMDY0NAo+ID4gLS0tIGEvZnMvZjJm
cy9ub2RlLmMKPiA+ICsrKyBiL2ZzL2YyZnMvbm9kZS5jCj4gPiBAQCAtMTI3NCw2ICsxMjc0LDEy
IEBAIGludCBmMmZzX3JlbW92ZV9pbm9kZV9wYWdlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCj4gPiAg
ICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gPiAgICAgICB9Cj4gPgo+ID4gKyAgICAgLyogVGhl
IGFsaWFzZSBmaWxlIG11c3QgYmUgdHJ1bmNhdGVkIHN1Y2Nlc3NmdWxseS4gKi8KPiA+ICsgICAg
IGlmICh1bmxpa2VseShJU19ERVZJQ0VfQUxJQVNJTkcoaW5vZGUpKSkgewo+ID4gKyAgICAgICAg
ICAgICBmMmZzX3B1dF9kbm9kZSgmZG4pOwo+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsKPgo+
IERvIHdlIG5lZWQgdG8ga2VlcCBjYWxsaW5nIHRydW5jYXRlX25vZGUoKSBmb3IgZGV2aWNlIGFs
aWFzIGlub2RlIGluCj4gZjJmc19yZW1vdmVfaW5vZGVfcGFnZSgpPwo+Cj4gVGhhbmtzLAo+Cj4g
PiArICAgICB9Cj4gPiArCj4gPiAgICAgICAvKiByZW1vdmUgcG90ZW50aWFsIGlubGluZV9kYXRh
IGJsb2NrcyAqLwo+ID4gICAgICAgaWYgKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkgfHwgU19JU0RJ
Uihpbm9kZS0+aV9tb2RlKSB8fAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU19J
U0xOSyhpbm9kZS0+aV9tb2RlKSkKPgoKSG93IGFib3V0IG1vZGlmeWluZyBsaWtlIHRoZSBiZWxv
dz8KCiAgICAgICAgLyogcmVtb3ZlIHBvdGVudGlhbCBpbmxpbmVfZGF0YSBibG9ja3MgKi8KICAg
ICAgICBpZiAoIUlTX0RFVklDRV9BTElBU0lORyhpbm9kZSkgJiYKICAgICAgICAgICAgKFNfSVNS
RUcoaW5vZGUtPmlfbW9kZSkgfHwgU19JU0RJUihpbm9kZS0+aV9tb2RlKSB8fAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNfSVNMTksoaW5vZGUtPmlfbW9kZSkpKQoKVGhhbmtzLAoK
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
