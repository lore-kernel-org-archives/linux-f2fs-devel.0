Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C465CA5FE4
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ksm51FpHaS2lpGm8p6B0FGUInxWrVdhMYPyxiODXI5E=; b=A1KA35qQ0J268afzjxm70U3LdZ
	0L+xkyTTVR7MD3TSz5NJM6sNX14gdtqJv6Zan0E+u8ZVVeekJ9afAeLFmYAe3+WxdRV+KXnYKk8cN
	GxbxWWrGJ69OTzcsEQwIivjIpVBkUc7pIa6BOAUorBAEQSrNNGjARdI5DENJE8+cOlXw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodi-000640-Ed;
	Sat, 03 Oct 2026 01:34:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodh-00063l-50
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpHLp5jfniwMimCHBWAAF5hBURDlDss1azWugKlI2Tc=; b=ZOEAxPW/h2rno2CZNCAP32pvP6
 7Z0dXXLOrlnrSb9jju32yNjUblCzufEnzC+DnKqMyo/B92AzufYSzpyHCeLmD7mY2b0pArxCcCFz/
 k+LJLKzr8CUf5Cwc37d4b4RAJni/H3HqvfZNecmbgVIFYUBuk52AUnp8l2BBlNCJtdLA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vpHLp5jfniwMimCHBWAAF5hBURDlDss1azWugKlI2Tc=; b=SrKi6VDioqdJsfKL2ZlhvLwslt
 MdW7Q9Luzvnd/TjaeUNvXXRKhLv+Tq4rX57trKjdtUzgJD1bjq+Ps00bEXHdAy83kOGlGwbnPPB8M
 T9iHYPtCkouFWMIWQVM67R7T/yEVC1O5wk1HqFGH+qx+mUsy9oAWaHRA8LUv0j6sTqhs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodh-00070z-7d for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FA9060DA0;
 Sat,  3 Oct 2026 01:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4141F000FF;
 Sat,  3 Oct 2026 01:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991247;
 bh=vpHLp5jfniwMimCHBWAAF5hBURDlDss1azWugKlI2Tc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mShQn/LdoGt603GAu2y3/uqQ4+D8e1sdj3kkPGeAmdpMM+ioU0q0fJxxqMpN1aTQ/
 JcKAMk0wQ/baJgbT4oiCxldiAoIsFtUCQYuCxrrDe1Vyu25AiI3Sg6IRoj08036zVn
 eIldxx01feyuCs/PMnltrIcw5LkxvMADXbwhSQnrHhpHjYs5UKmzys8fpizxyeuIne
 +FRQA4RflKSmSuUF3DK0TCqPBz8l4Zh3hXV0Nqx5sENCP+DCeb+OD5GeaL53Yeuobz
 LGtizmb2bBkogwfygY6qRmcrwM93lZK5m466xg/ti3/kSZu+1GW9wfaAsHxIP0I3X7
 wgvubSpDOV04w==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-11-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-11-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:06 +0000
Message-Id: <20261003013407.0E4141F000FF@smtp.kernel.org>
X-Headers-End: 1xCodh-00070z-7d
Subject: Re: [f2fs-dev] [PATCH v17 10/21] xfs: don't report dio_mem_align
 and dio_offset_align for fsverity files
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

PiBTYXNoaWtvLmRldiByZXBvcnRlZCB0aGF0IHdoaWxlIGZzdmVyaXR5IGZpbGVzIGZhbGxzIGJh
Y2sgdG8gdGhlCj4gYnVmZmVyZWQgSU8gZm9yIERpcmVjdCBJL08sIHRoZXkgc2hvdWxkIG5vdCBy
ZXBvcnQgbm9uLXplcm8gdmFsdWVzIGluCj4gZGlvX21lbV9hbGlnbiBhbmQgZGlvX29mZnNldF9h
bGlnbiwgbWVhbmluZyBpdCdzIG5vdCBzdXBwb3J0ZWQuCj4gCj4gVGhlIFNUQVRYX0RJT0FMSUdO
IHwgU1RBVFhfRElPX1JFQURfQUxJR04gZmxhZ3MgYXJlIHVzZWQgdG8gZXhwbGljaXRseQo+IHJl
cG9ydCBpZiBESU8gaXMgc3VwcG9ydGVkIG9yIG5vdC4gVGhleSBjYW4gbm90IGluZGljYXRlIHRo
YXQgZmFsbGJhY2sKPiB0byB0aGUgYnVmZmVyZWQgSU8gaXMgdXNlZCBpbiB0aGlzIGNhc2UuIFRo
ZSB6ZXJvIGFsaWdubWVudCB2YWx1ZXMgYWxzbwo+IG1lYW4gdGhhdCBESU8gaXMgbm90IHN1cHBv
cnRlZCBvbiB0aGlzIGZpbGUsIHNlZSBzdGF0eCgyKS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbmRy
ZXkgQWxiZXJzaHRleW4gPGFhbGJlcnNoQGtlcm5lbC5vcmc+CgpTYXNoaWtvIGhhcyByZXZpZXdl
ZCB0aGlzIHBhdGNoIGFuZCBmb3VuZCBubyBpc3N1ZXMuIEl0IGxvb2tzIGdyZWF0IQoKLS0gClNh
c2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTAw
MjIyMzcwNS4yMTc1NTQyLTEtYWFsYmVyc2hAa2VybmVsLm9yZz9wYXJ0PTEwCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
