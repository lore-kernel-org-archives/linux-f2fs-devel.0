Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4D606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kNq5zifC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Sa1ndiaJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JeN4nfcr;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cguM5kn9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:To:Message-ID:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=SpZAd0YyYXtJlVDPR8BlwPr2iNcHXNSIhREWfOKkpck=; b=kNq5zifCagriQzdcYHP3wrs5nF
	N3eukd8NrgpDR0d6leSW5mjuJ/QNRUjl7Jtag4W4WfPMzozT4+Hp25WEUwU7PBvtzKHklavRbaZFp
	5wkG05B59zhjywADDMj1Dk7P/zkxZORKT+0X4v52cgVRwCZUBUsBx8SKysDhDy+69lcI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOwAf-000000003Vi-32sL;
	Thu, 05 Nov 2026 12:02:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <sashiko-bot@kernel.org>) id 1xOwAJ-000000003U6-0Gyy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Cc:To:Reply-To:Subject:From:Message-ID:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=1kh3k6aMqGTsQaqUB7ASZrbf1baX0RqEDBQzsIHmO/A=; b=Sa1ndiaJchB9
 o/9czTLaPlg9jkxa0F9iqiJCzjdELUSv8yD/xPo7LDoqTKsYfg5OTxysNeaiKm8toFFhxzFhs1Xl7
 4axSz/S3DGaLmOFUV6M1m7MqFPQjGe3XY4KoHixf11olVsdjmQJ8ftq5SsD1TxZb9Aq8N4ADnOfuM
 wm9j4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:
 Reply-To:Subject:From:Message-ID:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1kh3k6aMqGTsQaqUB7ASZrbf1baX0RqEDBQzsIHmO/A=; b=JeN4nfcr7AdiBkhjoSLLVh/R/X
 rt8CBVfPcFBCSrv/FJq3x9EbCaazKrW9CYC6fDyIyhacV9h3+VDrxKKA1sTksfU9hQJPInm8odgtF
 MWlB+Qk/3dNEXQI6epG/wFQquM1bdOJiAqLVLWSiVpA8si0o9tdQEIa7ORtx5V+oAJDs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOwAI-000000007rv-1oYG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:01:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DA8B43CB3;
 Thu,  5 Nov 2026 12:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDCD1F000C1;
 Thu,  5 Nov 2026 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793880112;
 bh=1kh3k6aMqGTsQaqUB7ASZrbf1baX0RqEDBQzsIHmO/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cguM5kn9+Wi3r8ZarJhDkIERZP9gaEBeF7Hc70tIZNT06Yv7TFtayNubvANlQiEcf
 yZz+p+fKwXovlX8SzmmT0wjCBnZnR/ajXY0zdyLyRDJ/PFPdBNdjxpDRzoo4glLcTE
 yjog1eeWiddOX1MrWFJ1w9sg/6mqrzDPbkbTi9FE38il8j1NIynOvjW949Wcif8kM5
 I3k3W2OFqvW4WOUhUAq9OEdtx9YYrE7Khn7vsrRWaUiXHWKL+uUky9MaUIxps2gQor
 hOM0smm/Jy3UqRPKJ4HDxHeIBjTx17yExeVc2NQb6JLhTjxyDHNOhQm5BSOKfYv0dv
 m3AdUi2eKMEqg==
Message-ID: <sashiko-outbox-198984@kernel.org>
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261105115532.613467-5-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-5-aalbersh@kernel.org>
Date: Thu, 05 Nov 2026 12:01:52 +0000
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOwAI-000000007rv-1oYG
Subject: Re: [f2fs-dev] [PATCH v2 4/5] ext4: use I_VERITY_BUILDING instead
 of private flags
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBOb3cgdGhhdCB0aGUgVkZTIHRyYWNrcyBhbiBpbm9kZSB3aG9zZSBNZXJrbGUgdHJlZSBpcyB1
bmRlciBjb25zdHJ1Y3Rpb24KPiB2aWEgSV9WRVJJVFlfQlVJTERJTkcgYW5kIGhhbmRsZXMgdGhl
IGNvbmN1cnJlbnQtZW5hYmxlIGd1YXJkIGluIHRoZQo+IGdlbmVyaWMgZnMtdmVyaXR5IGVuYWJs
ZSBwYXRoLCBkcm9wIHRoZSBwZXItZmlsZXN5c3RlbSBydW50aW1lIGZsYWdzIHRoYXQKPiBkdXBs
aWNhdGVkIHRoaXMgc3RhdGUuCj4gCj4gUmVwbGFjZSBleHQ0IG93biBoZWxwZXIgZXh0NF92ZXJp
dHlfaW5fcHJvZ3Jlc3MoKSB3aXRoCj4gZnN2ZXJpdHlfaXNfYnVpbGRpbmcoKSwgYW5kIHJlbW92
ZSB0aGUgRVhUNF9TVEFURV9WRVJJVFlfSU5fUFJPR1JFU1MKPiBmbGFncy4gVGhlIElTX0VOQUJM
RUQoKSBndWFyZCBpcyBmaW5lIHRvIHJlbW92ZSBub3cgYXMKPiBmc3Zlcml0eV9pc19idWlsZGlu
ZygpIGhhcyBzdHViIGZvciBkaXNhYmxlZCBmc3Zlcml0eS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZXkgQWxiZXJzaHRleW4gPGFhbGJlcnNoQGtlcm5lbC5vcmc+CgpTYXNoaWtvIGhhcyByZXZp
ZXdlZCB0aGlzIHBhdGNoIGFuZCBmb3VuZCBubyBpc3N1ZXMuCgotLSAKU2FzaGlrbyBBSSByZXZp
ZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMTA1MTE1NTMyLjYxMzQ2
Ny0xLWFhbGJlcnNoQGtlcm5lbC5vcmc/cGFydD00CgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
