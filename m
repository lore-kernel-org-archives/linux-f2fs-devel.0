Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C680CA5FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eObBI7RYhPt96Ham1TtTDUd9kdxRMq1aoWpdAykjtrU=; b=P4spsQsfktIL7opeb5EL5MmUXT
	VnRXmPMVsjvlkNtMl4A4rzeYyp6eGe/qgj2obgKacBCacF9DFtfobEyc8KI+sY61m3RBDWzOjjxRp
	P4bw6Z3X2LCIzDKRyYRep9dW3ox2xtFZFWVu1adFJJAGtQITBOCHdRC/6+NhblJKJjv8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodp-0002rd-8y;
	Sat, 03 Oct 2026 01:34:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodn-0002cR-Kc
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+O9LM30e3T4xFjIK9E8xD59gAWHAklJ9oPVFOmADKlA=; b=Bm2F+7jXnc2hSwuEfFuaEi55TO
 rH56v7F8cb6y4NmeUssX7F9VIHfNa6CqdfVQQjnpUtUhzRQa0v7ms2WgdI60V82k1aFvXPIyqy0Dw
 2GFeuD2fabMcGFPx6aeV+UapmM0gXmeMUettRMOtJ4OjpzxGeeY0KRTnKAGCLBJgrUk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+O9LM30e3T4xFjIK9E8xD59gAWHAklJ9oPVFOmADKlA=; b=mGICJfQmLBvUlZlepuyuJ8VEsG
 tzwPWopHE+psO8n6RBaRgMiL8SCeG7qUlCuM1TvyJ3qHGhxegcEbohIheQqnAaJ46ZbtIj4D/tFKF
 a1SJ60XwtgXQ+NfQ5jI7tPpBcfdUSN6KQqOTqhJzhcaa5GDokwMCj6YUDTJnI8+fIyJc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodj-0001jR-Id for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04CAD60DA8;
 Sat,  3 Oct 2026 01:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6A41F0089A;
 Sat,  3 Oct 2026 01:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991249;
 bh=+O9LM30e3T4xFjIK9E8xD59gAWHAklJ9oPVFOmADKlA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j2ALVcLtT7h6I8+G5E9gU5/Bw34HAAMJG/ltL7zVkljaQVf20u+VhiXHlTe2VvvOo
 kgm/vzjlCdvyhLNcoimBAPnrh0FeCIHy6lg0FRlLIlhJ+KV4aXz60MfGgUByWBTrlg
 90bcBJ+/HCamIzaK5F2/8tsu240/dVx/2O2Y9aKqi776HulQf83wCD+2IwGPX6ad5O
 SekLAnQj3coP0OfneRz9XYGZFxv1zTHFdaYg1Jl8yJbphoF1PP0zMYFP4JhrBYrKgg
 E8hPHsJPCQ7CPi2LoGPUXSBUfpF3a9UcUHOpgGK8I6awDuradIXhYS4vmC8Zexrt1I
 orAN25QM7BuQA==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-17-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-17-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:08 +0000
Message-Id: <20261003013409.6F6A41F0089A@smtp.kernel.org>
X-Headers-End: 1xCodj-0001jR-Id
Subject: Re: [f2fs-dev] [PATCH v17 16/21] xfs: initialize fs-verity on file
 open
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
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
 dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

PiBmcy12ZXJpdHkgd2lsbCByZWFkIGFuZCBhdHRhY2ggbWV0YWRhdGEgKG5vdCB0aGUgdHJlZSBp
dHNlbGYpIGZyb20KPiBhIGRpc2sgZm9yIHRob3NlIGlub2RlcyB3aGljaCBhbHJlYWR5IGhhdmUg
ZnMtdmVyaXR5IGVuYWJsZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGFycmljayBKLiBXb25nIDxk
andvbmdAa2VybmVsLm9yZz4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEFsYmVyc2h0ZXluIDxhYWxiZXJzaEBrZXJu
ZWwub3JnPgoKU2FzaGlrbyBoYXMgcmV2aWV3ZWQgdGhpcyBwYXRjaCBhbmQgZm91bmQgbm8gaXNz
dWVzLiBJdCBsb29rcyBncmVhdCEKCi0tIApTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nh
c2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjEwMDIyMjM3MDUuMjE3NTU0Mi0xLWFhbGJlcnNoQGtl
cm5lbC5vcmc/cGFydD0xNgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
