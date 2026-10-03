Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE934CA5FE3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q6gNzo5ERE8Iq8e1AEmXGnlp1kw9ER4jhSHpnJKaotI=; b=OtHnvFc/AEWyzvcC2w+jIJt/CG
	GRAlnOhSaqJ3GKaceYaWfiJO3G0J8OHP7DYXodAtvBCgG2BiLFbv9ng060HNsumciTqjhlUEFdwBM
	30EzhWcWKsIpVcVC2UOYa3pozxAXko1Q59hebZkX4RYNbJZHPJB8G7hju4vr5CZDvQls=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCodk-0005HR-FU;
	Sat, 03 Oct 2026 01:34:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodj-0005HL-FY
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZjSz2uWI/zca8F6UqJC/48h2Wd/ux8nZBq6NIlN3NA=; b=lnVv6De78oQqr2Wh0zUTI6/AjF
 SdeJ4mIgrk1lcjb/MYyKmLyPIuejzLu38ucOlkYQjMgt+pC3gQyyApN9lGjhRkyu42XuWt1P3Tw6o
 w3fBB7EsEr3gCp68leo515ZnPcLF44rUbQv8XfoJ4B84xXyNdqBtau007uyqJqIy63Yw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lZjSz2uWI/zca8F6UqJC/48h2Wd/ux8nZBq6NIlN3NA=; b=SRVR7QF3Q2CLp0n7KWgwqtpMyn
 tsXc/kmXkhF3gz8uS4+FkNMyyFXpj+5zP5JBDCMmYy9URaWTqwviIUlNNE/6qMZxxT5iPOUPuKMM7
 NOl7rF6JzubEXp2zh8J4f/MarlN1QBp9qsXNweFAmWxzMPMo20xarwMMhiGH9ktIW/bM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodi-000711-N1 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2776C60D86;
 Sat,  3 Oct 2026 01:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F32F1F00893;
 Sat,  3 Oct 2026 01:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991248;
 bh=lZjSz2uWI/zca8F6UqJC/48h2Wd/ux8nZBq6NIlN3NA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BycnnpHSEqOgtdK8pjsmatEh7c0VFojfg+O43WwDE4nAhgey8uF/zz1Z2g7q+YiK+
 PiNlVzm6RgluTFg/RRXbBZkLjKlAqoUi3jRd9uOvq2/5JDXiClTTmm+pX1BsWMyWAy
 lHmhBmEdavIoALmKsIQ6boca0G1EGlhy9tlZ/cQ6CxNRmhGuYI9xvkqzgwOCMIILsr
 r8nuJCMGP18gDuU5bfdn6gqrK1nZD3M22mxKiImHPE/TRL/gBrZ5Nk520iMQ0m4Ml8
 LROmn2CBtBmAZkjnAuU0372b7C7TUt0cXqHGz7qL6SBpx15GMOXUcEn78jt/1uF6u/
 dqOiSNQcZMrmg==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-5-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-5-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:08 +0000
Message-Id: <20261003013408.8F32F1F00893@smtp.kernel.org>
X-Headers-End: 1xCodi-000711-N1
Subject: Re: [f2fs-dev] [PATCH v17 04/21] fsverity: hoist pagecache_read
 from f2fs/ext4 to fsverity
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

PiBUaGlzIGlzIHRoZSBzYW1lIGZ1bmN0aW9uIHRvIHJlYWQgZnJvbSBwYWdlYWNoZS4gWEZTIHdp
bGwgYWxzbyBuZWVkCj4gdGhpcywgc28gbW92ZSB0aGlzIHRvIGNvcmUgZnN2ZXJpdHkuCj4gCj4g
Tm90ZSB0aGF0IGYyZnMgYW5kIGV4dDQgZnVuY3Rpb25zIGRpdmVyZ2VkIGEgYml0LCBhcyBleHQ0
IG9wZXJhdGVkIG92ZXIKPiBmb2xpb3MgYW5kIGYyZnMgb3BlcmF0ZWQgb3ZlciBwYWdlcy4gVGhl
IGNvbW1vbiBvbmUgd2lsbCBvcGVyYXRlIG92ZXIKPiBmb2xpb3MuCj4gCj4gUmV2aWV3ZWQtYnk6
IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+Cj4gUmV2aWV3ZWQtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IEFja2VkLWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdn
ZXJzQGtlcm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEFsYmVyc2h0ZXluIDxhYWxi
ZXJzaEBrZXJuZWwub3JnPgoKU2FzaGlrbyBoYXMgcmV2aWV3ZWQgdGhpcyBwYXRjaCBhbmQgZm91
bmQgbm8gaXNzdWVzLiBJdCBsb29rcyBncmVhdCEKCi0tIApTYXNoaWtvIEFJIHJldmlldyDCtyBo
dHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjEwMDIyMjM3MDUuMjE3NTU0Mi0xLWFh
bGJlcnNoQGtlcm5lbC5vcmc/cGFydD00CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
