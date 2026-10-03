Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C967CA5FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5XBFOAYCRn6fPBkXoDBc0RZ/xH2tVmXcBNYthw8BiIA=; b=O93qd9fQcNWpEslczTBoeudIa7
	3aMxL+DglMOkUPzeXjcHhPV9gVZ09E9ZbUG1a4qonsSBymO7rPtNO3xGewPuUxSNY3oLipZAv9+Ip
	vfHwb4ijLkYjkoZhemT1B5JUVigcRSnGPZfAsg+dNIDpPk5K7SjpzDDyEC/DJ0MUpAXs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCods-00066G-5w;
	Sat, 03 Oct 2026 01:34:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodp-00065d-Fn
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7bAJTjg1QEHjZdwtGCaKNlCZjkd8j/B4bNjXUJSGC/I=; b=ROkkfLGms1xXK1Z8z5Edwe3fgD
 xOPCsSw7EqkcfgnzpTgno0w9Y7ueHkEtPHMd9hkSGfY5LlEoxEggCa3RGabm45T/Vs6HqV00jIE0J
 dK6qIIwHix6KbReF6Okv0QInPeA4kt5+mAtu/R+v5SbT4CAcOAueiWiHY0pIbMIiW/Xg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7bAJTjg1QEHjZdwtGCaKNlCZjkd8j/B4bNjXUJSGC/I=; b=k4TmLpPGbb2ZNeymISP/itatI5
 mSVcqfUI1wvYiY/guUM4F63ld8U8e+Mi525L65OE/nyNyz5XBR7HzEXgtxsG9ZG7glPlIuG+Dp8lK
 G99Dm8OoTO+ygDpVWt5QaoRhgfN9HyKw9/Gz4Yvwc8j6aeeDmY6dKPihX2+N5yX4HfYE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodp-00071J-Ng for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7215543D00;
 Sat,  3 Oct 2026 01:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B861F00893;
 Sat,  3 Oct 2026 01:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991256;
 bh=7bAJTjg1QEHjZdwtGCaKNlCZjkd8j/B4bNjXUJSGC/I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cFPMQP77EsAs+iTZTLRLFa+z/GscOsvjg6M7gCv0d3v5JvWh1sImlKm+ybkNheS1i
 OKuY5Xv/aa7pW5ewFo5rkkcKtaDQzAEwW4PM+TI6F335f1bavIRfJf/LLTPtGZw+T5
 mMFg5XVL90RDLhoqgzFzwsZnZUybH5RTVB+kQDNTuxfWOKuvf1jIriiX7+yhIirZSd
 fwMY9nGXg09EFIP1HNxMGdR1XV05tjJDyqDrhhkvPoaBRDKx4DDtQPa1N747XphPL6
 V5oyPMGUiK/upTb0X7F2ex6lu2sPgI70M3pe61r57uyBtlrQLlzQDY+qVnLPKJiIer
 O/kHP29kxnhzg==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-14-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-14-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:15 +0000
Message-Id: <20261003013416.14B861F00893@smtp.kernel.org>
X-Headers-End: 1xCodp-00071J-Ng
Subject: Re: [f2fs-dev] [PATCH v17 13/21] xfs: add XFS_BMAPI_UNWRITTEN to
 unmap unwritten extents in __xfs_bunmapi()
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

VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6Ci0gW0hpZ2hdIHhmczogX194ZnNfYnVu
bWFwaSBkYXRhIGNvcnJ1cHRpb24gb24gcmVhbHRpbWUgZnN2ZXJpdHkgZmlsZXMKLS0KCmNvbW1p
dCA5N2I5YzBmOWNiNzI3OGJiN2FiNjY0M2E1N2NiMGQwZjFhYzM5MjRiCkF1dGhvcjogQW5kcmV5
IEFsYmVyc2h0ZXluIHZpYSBMaW51eC1mMmZzLWRldmVsIDxsaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldD4KCnhmczogYWRkIFhGU19CTUFQSV9VTldSSVRURU4gdG8gdW5tYXAg
dW53cml0dGVuIGV4dGVudHMgaW4gX194ZnNfYnVubWFwaSgpCgpUaGUgX194ZnNfYnVubWFwaSgp
IGlzIHVzZWQgdG8gcmVtb3ZlIGFsbCBleHRlbnRzIHBhc3QgRU9GLiBBZGQKWEZTX0JNQVBJX1VO
V1JJVFRFTiB0byByZW1vdmUgb25seSB1bndyaXR0ZW4gZXh0ZW50cywgd2hpbGUgbGVhdmluZwp3
cml0dGVuIG9uZXMgaW4gcGxhY2UuIFRoaXMgd2lsbCBiZSB1c2VkIGluIGZvbGxvd2luZyBwYXRj
aCB0byBjbGVhbiB1cAp1bndyaXR0ZW4gZXh0ZW50cyBvbiBmc3Zlcml0eSBpbm9kZXMuCgo+IGRp
ZmYgLS1naXQgYS9mcy94ZnMvbGlieGZzL3hmc19ibWFwLmMgYi9mcy94ZnMvbGlieGZzL3hmc19i
bWFwLmMKPiBpbmRleCAxOWNhMjA0M2MyYThhLi40OWIwOTNlZjAzMjFmIDEwMDY0NAo+IC0tLSBh
L2ZzL3hmcy9saWJ4ZnMveGZzX2JtYXAuYwo+ICsrKyBiL2ZzL3hmcy9saWJ4ZnMveGZzX2JtYXAu
Ywo+IEBAIC01Mjc3LDYgKzUyNzcsMTAgQEAgX194ZnNfYnVubWFwaSgKPiAgCQlpZiAoZGVsLmJy
X3N0YXJ0b2ZmICsgZGVsLmJyX2Jsb2NrY291bnQgPiBlbmQgKyAxKQo+ICAJCQlkZWwuYnJfYmxv
Y2tjb3VudCA9IGVuZCArIDEgLSBkZWwuYnJfc3RhcnRvZmY7Cj4gIAo+ICsJCWlmICgoZmxhZ3Mg
JiBYRlNfQk1BUElfVU5XUklUVEVOKSAmJgo+ICsJCSAgICBkZWwuYnJfc3RhdGUgIT0gWEZTX0VY
VF9VTldSSVRURU4pCj4gKwkJCWdvdG8gc2tpcDsKPiArCgpbU2V2ZXJpdHk6IEhpZ2hdCkRvZXMg
dGhpcyBjaGVjayBzdWZmaWNpZW50bHkgcHJvdGVjdCB3cml0dGVuIGV4dGVudHMgd2hlbiBvcGVy
YXRpbmcgb24KcmVhbHRpbWUgZmlsZXM/CgpJZiBhbiB1bndyaXR0ZW4gZXh0ZW50IGlzIHVuYWxp
Z25lZCB3aXRoaW4gYSByZWFsdGltZSBibG9jaywgdGhlIGxhdGVyCmxvZ2ljIGluIF9feGZzX2J1
bm1hcGkoKSB3aWxsIGZldGNoIHRoZSBjb250aWd1b3VzIHdyaXR0ZW4gbGVmdCBuZWlnaGJvcgph
bmQgdW5jb25kaXRpb25hbGx5IGNvbnZlcnQgaXRzIHRhaWwgaW50byBhbiB1bndyaXR0ZW4gZXh0
ZW50OgoKZnMveGZzL2xpYnhmcy94ZnNfYm1hcC5jOl9feGZzX2J1bm1hcGkoKSB7CiAgICAuLi4K
CQltb2QgPSB4ZnNfcnRiX3RvX3J0eG9mZihtcCwgZGVsLmJyX3N0YXJ0YmxvY2spOwoJCWlmICht
b2QpIHsKICAgIC4uLgoJCQl9IGVsc2UgaWYgKGRlbC5icl9zdGF0ZSA9PSBYRlNfRVhUX1VOV1JJ
VFRFTikgewoJCQkJc3RydWN0IHhmc19ibWJ0X2lyZWMJcHJldjsKCQkJCXhmc19maWxlb2ZmX3QJ
CXVud3JpdGVfc3RhcnQ7CgoJCQkJLyoKCQkJCSAqIFRoaXMgb25lIGlzIGFscmVhZHkgdW53cml0
dGVuLgoJCQkJICogSXQgbXVzdCBoYXZlIGEgd3JpdHRlbiBsZWZ0IG5laWdoYm9yLgoJCQkJICog
VW53cml0ZSB0aGUga2lsbGVkIHBhcnQgb2YgdGhhdCBvbmUgYW5kCgkJCQkgKiB0cnkgYWdhaW4u
CgkJCQkgKi8KCQkJCWlmICgheGZzX2lleHRfcHJldl9leHRlbnQoaWZwLCAmaWN1ciwgJnByZXYp
KQoJCQkJCUFTU0VSVCgwKTsKCQkJCUFTU0VSVChwcmV2LmJyX3N0YXRlID09IFhGU19FWFRfTk9S
TSk7CiAgICAuLi4KCQkJCXByZXYuYnJfc3RhdGUgPSBYRlNfRVhUX1VOV1JJVFRFTjsKCQkJCWVy
cm9yID0geGZzX2JtYXBfYWRkX2V4dGVudF91bndyaXR0ZW5fcmVhbCh0cCwKCQkJCQkJaXAsIHdo
aWNoZm9yaywgJmljdXIsICZjdXIsCgkJCQkJCSZwcmV2LCAmbG9nZmxhZ3MpOwoKQ291bGQgdGhp
cyB1bndyaXRlIHRoZSBsZWZ0IG5laWdoYm9yIGV2ZW4gd2hlbiBYRlNfQk1BUElfVU5XUklUVEVO
IGlzIHNldCwKZGVzdHJveWluZyB0aGUgYWRqYWNlbnQgd3JpdHRlbiBkYXRhIChzdWNoIGFzIGFu
IGZzdmVyaXR5IE1lcmtsZSB0cmVlKT8KCj4gIAkJaWYgKCFpc3J0IHx8IChmbGFncyAmIFhGU19C
TUFQSV9SRU1BUCkpCj4gIAkJCWdvdG8gZGVsZXRlOwo+CgotLSAKU2FzaGlrbyBBSSByZXZpZXcg
wrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMDAyMjIzNzA1LjIxNzU1NDIt
MS1hYWxiZXJzaEBrZXJuZWwub3JnP3BhcnQ9MTMKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
