Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15444CD8C88
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  6 Jun 2026 01:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GL+KAchi/3N6+i1CY7JQT0MWCu6OYnrgmlN/Pe6VQdQ=; b=dOIeQFledyMU5Y3rWTipAWK7zu
	NOQdNzKB2OUztkBEFQYPndgtlZWAv6ThDc8+8LWClm+66vqEa1NTeQK75hiA8FOIOGc3OPMMWmg7M
	ELMCEc9HAHz22enLTpWcYFGL6T0cHevJzmtahZyvgNagfaw7iZVa+WCHTj5A+80B5ae0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wVfSg-00015J-86;
	Sat, 06 Jun 2026 01:04:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wVfSf-00015D-6J
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 Jun 2026 01:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=11fEbEQzBE0cs78+ZXkDLvl/3GqPtzswg0m6u8OrOsg=; b=ZbL9Xwv7akvI6dtm2/B4I6oSJH
 I6wG9gkMKTP9F54ozIXgu9IznhWkJc2Xj+bpCVtndqhCxJ44F+8/gRJFZB/TzLhF+xCn0lKUc4klV
 CUpZUdLxmf3boO/jHvA8F+tFZd+jpV4I+p59YGdukBF6yYIrRd0MEHO/otF6PEap7vg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=11fEbEQzBE0cs78+ZXkDLvl/3GqPtzswg0m6u8OrOsg=; b=RxxYHeA5H/N/+SiKrZqOXHQLld
 MfPrNK4DtfH58/J4owIES1LOjqZ7qM98M+QKnQkPHvVEARphDLqq4uYWjOh9Qkzxmn4XiES45OFk5
 Z3MaJWoX+8iSKPVaOs7ZHglJZHYix694+oE0eXY9/rtw8HkAb3PAJrgRekN0DfrPlH2Y=;
Received: from mail-ua1-f49.google.com ([209.85.222.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wVfSe-0006f1-Af for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 Jun 2026 01:04:29 +0000
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-963a7e48493so1764837241.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2026 18:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780707858; cv=none;
 d=google.com; s=arc-20240605;
 b=PQxUjpLUvsp7346TJpk1bMasFDCj9BmrFBnigav7q4LVzuuiFK6KCY3IOyActf1NYs
 aevUL9JnwtOkShdcby30WPth//DD/oWIYEdcZ3yE0+DLNccdXSyY+2Gr4tWyuq7ZyA5h
 DNncpXwXh38vlF+GGOVRvHkz8jCgsyob594C8gsK1I2FWXBlB5hcEHbfvZQAVYsEpG+I
 WsxNI6aOTs1BT7Y2fbKfboAlo4sRFjrl7E7fl1A4/rEg+vtLzX4FIzUVmrifXh7Zlclj
 fFk4FOJiA1ALA6C//Xyan+eS4+IN3PG3SrgbqT+rClOM3QD4ZRgrOtkftqo348tDPVaW
 Dkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=11fEbEQzBE0cs78+ZXkDLvl/3GqPtzswg0m6u8OrOsg=;
 fh=alFVnhxG2qzCkT8et3U0IlkwSH/TfUnHnsEtk+GA9k8=;
 b=V3G3Pk39zyNvmlIWmtrvbg1fysVlpGxvskJshD/cwzuLh6MSu1/ZQKr8GL0oeSRTdu
 f6Cc7aUh8YcYqIgADqzOmWFh+C2efpaWQir35VK+vpLREQLye64/zImteaibfoniLvu0
 jV5MpiWKlzDU2Dqvw89LPP6h/o7PdwB9FA7n0u+6qlift7xI2B4LZxIMxfqI88FU1XML
 Q3NCSTuTofc/bq02o4iIFLkFTMBxrdkrLKRZsYl5p6gDjRcTT46M3gaTAXR3OFv+vsH3
 f1Is1oAtpyCrPob2oc4RAXDCF3LH2q9QGWs6ES35FOWtFD/UujL5guJ/ds++E07+mF3U
 xt1g==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780707858; x=1781312658; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11fEbEQzBE0cs78+ZXkDLvl/3GqPtzswg0m6u8OrOsg=;
 b=on3SrWQkM83q3r0PKvY3aaYJmY7Dw/a8EPMor4Wmrx+yPy8oUdyIS3FOlsan12wP62
 R80CAuLQfVljUjcorRq6POxQvfPi9R1SIvRRmSbaN/0au4M5zN4q8bMwtpwOp/Y/Htxg
 W6HkpAqGKpRYAoBkArExeNI9t9WtTwgs91ry3eDPogZMkYvK7uL2xTFqd/l9O1FBIwDe
 dxPhHNsp9cBkRXm1YpHFXaWrPd9R9fA7B4fLMbi7tSBV6K3iqlsxnnH6QYDxg/NdEK6c
 o19k36Eac1CFiNT/zfli0oY4lwWMyEk1EoP8jHuenhK0lPMv9B62OaPBDgwUm45RIQqq
 6F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780707858; x=1781312658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=11fEbEQzBE0cs78+ZXkDLvl/3GqPtzswg0m6u8OrOsg=;
 b=D+Ih8ZBUM+p/JUfWRUT2nVw9GZKeE6IHA77ruSWxeV/eneTrjSAv6qFhtHL8jqKdBt
 wDQLI5ZeM39G+5fTUBvbk1KJ9sjErm/qElgnZ8Hhl3wk+nrCpyX7RGhfieXWC33AHxdz
 US8lwndURpPJyxiaMCk1pW71zF/scZ99v1oSwvKfVLcvq13qzx00K5mqG3/6qIkiKxcj
 xtYr95pV5hjjJ7i9wQlmzEFAxIioyVFfE9Mb07sSPN8O2y9UQ6Gs91QbAfkkoUo/NJTF
 zwANL6M73m4F7RQ3/yqTCS4TbDmv+I9vZEf17wNAQkTO6+eoJb14eGiD78Z+wvqdTF1B
 Ag2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UnOkNYOt0+pjLxd+Yt4DsOrCI/RI7y+kasW1zhTyNVAfg1FbIRM4d7lGiX6ufPbRFehsVxHcJV+FaXzGDTOiq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyDX7eCdTJbG8lsTlVYwAC+sPXf3V18pac6Uuk73ac6Jc87eEPR
 IEK5CvcV29g7Pna9s3uRvDkcwX7muyTpnr/J/EwhwrvKB+sRA89/FIehltLk++RG3oOTXgIKfIb
 SBkkLg5HbOIOkCU5x1EBmlnXZsbTY5tJxRQ==
X-Gm-Gg: Acq92OGMmqqiyOsnDAef0Xw1WSYbAafqeBi9ftyRhKEGBOsN2WA+aYLCUNsk9ay/4hV
 zBEhYggMlybUSwDGPDJsV6Rr5SOkSPDrrf08d45iWP/DugZlhKblAsqECDIUyTbSd5CzxrA5z52
 MWqHrhUHz+1Fm/9LGl5kG3IaPPa5++s0+2aAX2pajGYdQkj6N8fgvoh/VJTYHpVtoTDOtpPsJ/m
 HjFieGlhZ5Ztw2y+i0WE4c4Iv5XTk8EVQsTCb3w7cLL5K+6vv1Ed+z8CvhST5k4KVuxyI5yETca
 7oKtZmxSWe2mc+gZO/u8bjqtE+vC7SEL4T5oC2vJ0fTAmSJwoMSfiG9U7rP88M7EZWEMnTIZ4/Y
 hIl4Q1Tc=
X-Received: by 2002:a05:6102:c53:b0:65b:47:2c8 with SMTP id
 ada2fe7eead31-6feef48deafmr3752121137.10.1780707857860; Fri, 05 Jun 2026
 18:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260605212504.1080138-1-daeho43@gmail.com>
 <20260605221027.GA2312230@google.com>
 <CACOAw_xrMij0pXjFkS4gY0kt5buvfZ0gmzbcP+zx4-ox7n+_3Q@mail.gmail.com>
 <20260606003240.GB2312230@google.com>
In-Reply-To: <20260606003240.GB2312230@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 5 Jun 2026 18:04:06 -0700
X-Gm-Features: AVVi8Cf9ucSg375Q5-cKVQ-QSz8Hnftf_Qor5RW8CkMTc9cDKvjPQX5r0zaOA54
Message-ID: <CACOAw_w=9C0KmHT_WEzc5UMK0dDViw_DUc9cAhkJDWXjm5LxCw@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1wVfSe-0006f1-Af
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support dynamic include/exclude for
 device aliasing
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBKdW4gNSwgMjAyNiBhdCA1OjMy4oCvUE0gRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Br
ZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIEZyaSwgSnVuIDA1LCAyMDI2IGF0IDA0OjUxOjM0UE0g
LTA3MDAsIERhZWhvIEplb25nIHdyb3RlOgo+ID4gLSBBY2Nlc3MgQ29udHJvbDogVGhlIEYyRlNf
SU9DX0VYQ0xVREVfREVWX0FMSUFTIGlvY3RsIHN0cmljdGx5Cj4gPiByZXF1aXJlcyBDQVBfU1lT
X0FETUlOLiBVbnByaXZpbGVnZWQgdXNlcnMgY2Fubm90IHRyaWdnZXIgdGhpcwo+ID4gdHJhbnNp
dGlvbi4KPgo+IE5vLCBpdCBkb2Vzbid0Lgo+Cj4gSG93IG11Y2ggb2YgdGhpcyBiZWVuIHJldmll
d2VkIGJ5IGEgaHVtYW4/Cj4KPiAtIEVyaWMKCkxldCBtZSBjaGVjayB0aGF0IHBhcnQgYWdhaW4u
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
