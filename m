Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61339C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Nov 2022 11:47:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ox5H3-00039U-K7;
	Mon, 21 Nov 2022 11:47:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3Sl97YwYKABk5A723G5DD5A3.1DB@flex--glider.bounces.google.com>)
 id 1ox5H2-00039O-5M for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 11:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iseMGXVhmQtR+5DQv6vAmctq3FLXZ3Zx0bYYW0I3bps=; b=kagDN1LLqf9AvpqzZZUW65XB74
 GqlSGZni3BH+566/t1Fol0ks8zYTztIhRbuTIvYd34jdTEJg+MW0I19pe5/cpVSfwfk/+8nToA1Au
 xgCeepHPJA5SR5zpI3TrxAHTFeOqSv2x944JQrGD9lwGLs0Klvr3wgewbuOGj1+fzRpw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iseMGXVhmQtR+5DQv6vAmctq3FLXZ3Zx0bYYW0I3bps=; b=aHbtSz8oGi86h0Ql47WxiEEWR+
 Ouo4Ui65v/GpTo/CWog4kU9y5TOZUh6JPyDQ7ehnDrRYKJt2YJ/sAWxnt71f7rGi3OFMUIqYB7wwP
 qwuqyY3oQrLKdrtEfNUyAjOQReI3W3WAKL3KNHsJOazVgPS2IrPGgZEIdaomFosJev7s=;
Received: from mail-lf1-f74.google.com ([209.85.167.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ox5H1-0006tz-KQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 11:47:40 +0000
Received: by mail-lf1-f74.google.com with SMTP id
 w2-20020ac24422000000b004a299d12364so4282822lfl.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Nov 2022 03:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=iseMGXVhmQtR+5DQv6vAmctq3FLXZ3Zx0bYYW0I3bps=;
 b=fvoRIPmpwjc9kwZJjlC8SWhtwYdajteuU8MNnEWUMvn5GkD+yGWYPUsDcdndaw8YjK
 fa13YD7A3DdjmU3EhEj99KaM6rOjUxJKB/d/QJYdnY6fqKOJgZkPoO8RrrWJe1U4umr+
 hiUfjkhq3hMpxwynNBwHUtYJWY9QJy0HLcUfde1YnzFDialtNBgsAL/Lpaq6bDXTMM62
 N5V2k9a1D0kusoUoO9/V+NmAYKbT5IpfYNf/E/G22Vwu5YTvASjATJcEIMrdADAeDQc2
 MVVCkuX8C8EJypjMeMPM03N72UYeZDw46ri4QQG9SKF+2INt3aYRQ+JZ/H1xOpAorNwU
 0etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iseMGXVhmQtR+5DQv6vAmctq3FLXZ3Zx0bYYW0I3bps=;
 b=ImWEpbJjV/18Pou3nEOqETjAZ5OwKl95c2Ytq0Xdq4U3TEWYyBbcWTa7UL/vdylk9s
 TmcA2J6t+Fk+4OqrE+Aysry0wKkIvO/VVV8Ryjepp01U2opEdEvClju1rXQpQIhKselm
 Sgs/6z7RIQ4SFg6RP8LqAmMihux1UZpGPztpOBvPcX16/bzvjRaLUcfqTqK4whuH40/n
 OOmsroKFy4pnxIK7DWR+oGlSiLa4QBBAwbHFQVH8OBNx5U2N0zLnCLbsVQl1NuNFP0b3
 RrqkTYdmYUQkkH2lLKqTpWV1xhmHzvpqRcds/ziQ00+t1mWNRoHecMQ3TtW7waQ0G0/v
 1uFA==
X-Gm-Message-State: ANoB5pk2f1ByY3TSxTIQpWmRSQXR3z0HnIgd10yoTam/9ulDkj2oO9ZJ
 6N4E0JQ/bXxUvbRR3HWeGGN18AcmeGI=
X-Google-Smtp-Source: AA0mqf5//ubCLbRHw5k5ojH75x8ASFqsHvPLZaawkowyC5ynCgNspfsSIAS8NxDclO+KSFJJIsbTDrSav0k=
X-Received: from glider.muc.corp.google.com
 ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:a17:907:8b13:b0:781:541:6599 with SMTP id
 sz19-20020a1709078b1300b0078105416599mr3206798ejc.45.1669029706445; Mon, 21
 Nov 2022 03:21:46 -0800 (PST)
Date: Mon, 21 Nov 2022 12:21:33 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-4-glider@google.com>
To: glider@google.com
X-Headers-End: 1ox5H1-0006tz-KQ
Subject: [f2fs-dev] [PATCH 4/5] fs: hfs: initialize fsdata in
 hfs_file_truncate()
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
From: Alexander Potapenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Alexander Potapenko <glider@google.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/hfs/extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 3f7e9bef98743..6d1878b99b305 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -486,7 +486,7 @@ void hfs_file_truncate(struct inode *inode)
 		inode->i_size);
 	if (inode->i_size > HFS_I(inode)->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
-		void *fsdata;
+		void *fsdata = NULL;
 		struct page *page;
 
 		/* XXX: Can use generic_cont_expand? */
-- 
2.38.1.584.g0f3c55d4c2-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
