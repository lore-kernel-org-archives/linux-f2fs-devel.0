Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CDEC48260
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Feb 2024 08:12:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rXzW1-0005dN-GY;
	Thu, 08 Feb 2024 08:12:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wubo.oduw@gmail.com>) id 1rXzW0-0005dH-C3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 08:12:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+EzGcEGSGki041mX/q4WVvvLib1LrKkmNOXMbNSMe9k=; b=A4Xrr9bPwly83l9Ion9o3clGaM
 3UYZDjAQ30QqzFJCwK86jaRsAXdMEbFVGJpYoXk5PltL2MkTC5LpeIK0xBY9mk8cbiXRcsFF89nV7
 4PTGNV8xW/aLEmeum5m+XXos0R/Fdte+Qm0oGPFilcOD/CgR/1/85A7YondmqCBYw3Wk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+EzGcEGSGki041mX/q4WVvvLib1LrKkmNOXMbNSMe9k=; b=MQDdHhLM2sLDOSffsgDxG/+d84
 Xz7KBu9uxp6ZNX1oySodbRYEF6YSsWhxQ8TvyDTF2Q9jMvzRk3HAukoMqTYWHA1ucnkdWle1rSPx9
 57cKKq7lZ96D2pNZ9VyJ0LBpRY3mByJxNeViibXH1e00TmEtSunkuTNyh10rvhezPMc0=;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rXzVu-0004OQ-Hs for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 08:12:12 +0000
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1d746856d85so12138665ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Feb 2024 00:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707379916; x=1707984716; darn=lists.sourceforge.net;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+EzGcEGSGki041mX/q4WVvvLib1LrKkmNOXMbNSMe9k=;
 b=gqWpOX3rXdNBpI0VM35E1lgchLPFtU2wTA8Ek0qL5RPYicQY6D4pE473LBy3eczfgU
 bCm6iENJUKjqhEtEnfp/dhnmwpb66p14i6mp1gMV3ER1EKGvonmtj9yUuAD+nzxseCMK
 Y2ObPR+63CZXRoti54HGOAL82LsZWAAUqtzfnJYgdp76oW6AQ/QtG2jMgoAMM4B3gmZj
 5wBSD9FlOZUxmPV5tiYvOnOf+kBPAFZ/zuHdvSSN02ZX91YsNTsjxvatMuBlIQ77t/Nj
 ZQ8F29oh18M3KJ5HmM4FhNSqdNckqpZitE/zCd1TC503diQfamX7AUFufcR2FhDwU5rW
 E/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707379916; x=1707984716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EzGcEGSGki041mX/q4WVvvLib1LrKkmNOXMbNSMe9k=;
 b=aweCqWiNN++N5OYcefQ+1P2ZJ0IPF6sqwy0bMyhz5lIxKUNHZvE37lVzlpSPyCbdVW
 0P4N9pRZVnN36ZQ3GxNCBJ8crX/xlLPEcmE/Q7SFfrKSmisUGE8m7x5Wt9MLx+7Yehqh
 RJ+FJsKYF//bkbphNj+M25ig74Z5EgQ/0AOOryqv9ElPv4AcVaiC8f34ahJ13p0JEYK8
 LESf67jFHPEs6UKT+WvgWJbrfV6JsWxvV4G4kPdPpHtfOc9RLvL4kVRdWOZrMHuPFrnG
 uF7ns9Gs+sLyjjKS5ltSH85/aSK5G7eAlDKAzw1w+YCFrvN1vIp6vhB5sQFY/P8BWAyO
 weqQ==
X-Gm-Message-State: AOJu0YwEK83uDZWROkhoHXbCJwDBZjCsd2wXHUBo7jiiFiz2fMpj8RBC
 f6h/r7mKlnwk0s1x8Iac+TIYPVTm4St6kTDtO1Hjr8oAG1GPJ0ohjKSAdJGND4I=
X-Google-Smtp-Source: AGHT+IG5rt3u2UGwyrRiwP0jDNepsx1EaHecgtVzojFLKjbioIlru7dTmEcioRvKo7tRDyS8TaYb7A==
X-Received: by 2002:a17:902:ead1:b0:1d9:6381:a4b3 with SMTP id
 p17-20020a170902ead100b001d96381a4b3mr6541505pld.36.1707379916398; 
 Thu, 08 Feb 2024 00:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVM0Eei7B+s2xu7LIQ5YQ3htmsre/Zi1BiMcqbTuBhg1gCskj5rTO6VTnGufF83HLSNCtEAExblGgFcT8yp/ZF3LR5ZEDEeAYrVsobqzAxjQGDoYqbhVmCV4nyw38q4NiyLY56twVdxK0e2AFytP+cpdv3aFE6RFHGg23dfp3TvQKGM5XgDRhwP
Received: from [192.168.50.127] (42-98-185-035.static.netvigator.com.
 [42.98.185.35]) by smtp.gmail.com with ESMTPSA id
 h4-20020a170902748400b001d8e5a3be8asm2764386pll.259.2024.02.08.00.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 00:11:55 -0800 (PST)
Message-ID: <bab0d763-2907-4412-8075-a7ebb25081c0@gmail.com>
Date: Thu, 8 Feb 2024 16:11:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240205031415.557879-1-bo.wu@vivo.com>
 <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
Content-Language: en-US
From: Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
X-Headers-End: 1rXzVu-0004OQ-Hs
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned
 sections if EAGAIN happens"
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC8yLzUgMTE6NTQsIENoYW8gWXUgd3JvdGU6Cj4gSG93IGFib3V0IGNhbGxpbmcgZjJm
c19iYWxhbmNlX2ZzKCkgdG8gZG91YmxlIGNoZWNrIGFuZCBtYWtlIHN1cmUgCj4gdGhlcmUgaXMK
PiBlbm91Z2ggZnJlZSBzcGFjZSBmb3IgZm9sbG93aW5nIGFsbG9jYXRpb24uCj4KPiDCoMKgwqDC
oMKgwqDCoCBpZiAoaGFzX25vdF9lbm91Z2hfZnJlZV9zZWNzKHNiaSwgMCwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEdFVF9TRUNfRlJPTV9TRUcoc2JpLCBvdmVycHJvdmlzaW9uX3NlZ21lbnRz
KHNiaSkpKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZjJmc19kb3duX3dyaXRlKCZzYmkt
PmdjX2xvY2spOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdF9pbmNfZ2NfY2FsbF9jb3Vu
dChzYmksIEZPUkVHUk9VTkQpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gZjJmc19n
YyhzYmksICZnY19jb250cm9sKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPT0g
LUVBR0FJTikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZjJmc19iYWxhbmNlX2Zz
KHNiaSwgdHJ1ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyICYmIGVyciAhPSAt
RU5PREFUQSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfZXJyOwo+
IMKgwqDCoMKgwqDCoMKgIH0KPgo+IFRoYW5rcywKCmYyZnNfYmFsYW5jZV9mcygpIGhlcmUgd2ls
bCBub3QgY2hhbmdlIHByb2NlZHVyZSBicmFuY2ggYW5kIG1heSBqdXN0IAp0cmlnZ2VyIGFub3Ro
ZXIgR0MuCgpJJ20gYWZyYWlkIHRoaXMgaXMgYSBiaXQgcmVkdW5kYW50LgoKPgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
