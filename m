Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159E1CA5FE8
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBRnV+LBOK+RkpFMO5n+TCKwFT6G88LF6XHi+wllaE4=; b=J1ixjZQIuYDxGTEeY07Q9Dgxt7
	5A7cMz5tcPwi2xE0XVkdD5xRxPIr2JC+f2N95U6ItZSV0FvpBLrbbOyKWLHA9hYQFxmnFCkezoPo7
	tywGYvUXckZTdEqDNmp1jLnMja7CYfqOWnJ/P3GhTxvHirakGKSLmUPcTc0NU7bSFZsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCody-0003hx-Ao;
	Sat, 03 Oct 2026 01:34:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashiko-bot@kernel.org>) id 1xCodw-0003hi-ON
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ghqta4Z3F6FeYVak6MRt6oJJ5X6zqAtFSLozmoDw3lo=; b=dLAqEXp6MCpa8tG3dsgyHC7Q/X
 DfIRcipEEO42+PIV3522jM+SQOBSl4MI7U25sQofwb7EpK26X3lhz0N3hzIqznh5kcbpc8esjYpu6
 RO3gXhVavTdXM65TyBhwfg1Mm39CZa38/3k/epobCUnTIoc9aF9kKbJzEEYaePvoMn60=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Cc:To:Reply-To:Subject:From:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ghqta4Z3F6FeYVak6MRt6oJJ5X6zqAtFSLozmoDw3lo=; b=fus4YeOc6NeFvGWRpVDT5UxGhk
 l7W2TF0L64jamYjdAJFCGImeib9nAYLspeIyCYwtmLv051ANj2hmCncSh8pmj2vAoDDluU9OzzWAx
 Hu4F+5aAl0YehXt8l9So3+yypjjmG+xI5IQqcfrnGlKihgVSTZL9hQRbN631RfvK99C4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCodt-0001jn-O5 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 01:34:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 752FD43A57;
 Sat,  3 Oct 2026 01:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179AE1F00893;
 Sat,  3 Oct 2026 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991260;
 bh=ghqta4Z3F6FeYVak6MRt6oJJ5X6zqAtFSLozmoDw3lo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ago9RM6wsl8MS5VMmevuj7Ob47QqzOiU1bk7uoRiLoj6lJYAa5v7zo5VEEAno3vQB
 /dbWQMgErMvgRNHCbVLP0UH1XHVZWm3F2iw/ocpRqKhVHEV01sJQUmzz7QCzd3jAiF
 J0wVvXhRKHG/6QoHHfXSMwO3gXTnj5ehpdjENhNSsHktITfFOOx1gSPLgdQ+d+ngm4
 HYkFyAW7mIxBXHtmqRvIFIr1gpPcdzqUXjEuWo3As13O6j6FgBk9URdATt1/5zOXK4
 FAl+L5HjzOD+NcDLpy2lBa0Z2/muNZkqZGGiFylSeuuEZzG1/RvIgoNLa4l9ygaYqr
 IBKCxRa7+z5wQ==
To: "Andrey Albershteyn via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261002223705.2175542-18-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-18-aalbersh@kernel.org>
Date: Sat, 03 Oct 2026 01:34:19 +0000
Message-Id: <20261003013420.179AE1F00893@smtp.kernel.org>
X-Headers-End: 1xCodt-0001jn-O5
Subject: Re: [f2fs-dev] [PATCH v17 17/21] xfs: add fs-verity ioctls
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

PiBBZGQgZnMtdmVyaXR5IGlvY3RscyB0byBlbmFibGUsIGR1bXAgbWV0YWRhdGEgKGRlc2NyaXB0
b3IgYW5kIE1lcmtsZQo+IHRyZWUgcGFnZXMpIGFuZCBvYnRhaW4gZmlsZSdzIGRpZ2VzdC4KPiAK
PiBbZGp3b25nOiByZW1vdmUgdW5uZWNlc3NhcnkgY2FzdGluZ10KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPgo+IFJldmlld2VkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgQWxiZXJz
aHRleW4gPGFhbGJlcnNoQGtlcm5lbC5vcmc+CgpTYXNoaWtvIGhhcyByZXZpZXdlZCB0aGlzIHBh
dGNoIGFuZCBmb3VuZCBubyBpc3N1ZXMuIEl0IGxvb2tzIGdyZWF0IQoKLS0gClNhc2hpa28gQUkg
cmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTAwMjIyMzcwNS4y
MTc1NTQyLTEtYWFsYmVyc2hAa2VybmVsLm9yZz9wYXJ0PTE3CgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
