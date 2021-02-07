Return-Path: <SRS0=fAWp=HJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6CC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F365A64E2C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F365A64E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l8pN0-0005ph-Py; Sun, 07 Feb 2021 19:05:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=665305f4c=chaitanya.kulkarni@wdc.com>)
 id 1l8pMs-0005oS-I0
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Feb 2021 19:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HL/9d7fOv5iW8y2vK9VdLQRKbrJL5iCJwA9e3y6urrw=; b=Z3OClFs2OwJ6pw8Jl6rTcp4eqO
 WmnveZu43+EFvdpxvyi36znwljO/EOW99tqbi4M4q4COIt+Vb+iVF1RETdlGSjCvvq8IKGMYolUY0
 Ff1YeMkEh2aFfzXJPSUKs9Oze+0yXfIgI1MWG+mqYBebVAfD8Ac2+oHk0He2dPYi/hhU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HL/9d7fOv5iW8y2vK9VdLQRKbrJL5iCJwA9e3y6urrw=; b=RLxWeha2pwFJQeoT0b3kaw9j4l
 qaoptkbktqIoBMpOd9R7T8iQKHyaUjSsWfdp53mXijo4xyKRrSRBU/jKl/ziShdkfrTn+FsXxPz1T
 8Xo65zcg2fcpajmrjGl4oxWWncVo/iT0GkJWUj/QfGhRHpMFj/zNWW4zFt0QcVxWStFQ=;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1l8pMg-0000ez-Ns
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Feb 2021 19:05:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612724698; x=1644260698;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jVyWOzZt5w5fhEh8o7eS7+fG7L6zzNjoN92UbyfAIKQ=;
 b=W/qkU0ADsO9DouR/yl7nAM3kMaNr1TpJ6U8suwOtUs4H18AkQWSGwk3F
 svuo0PskBiHPxkaZf6iifok2Asnro7WJ+kv6gBnxtSccNflYctDBVHLRb
 0x6WM20ULOuimQJPNErjQo82fxficvEGlp3MlDhwoMXZRcYsPBPl/YuZ4
 RuxjVBUMBToniaNpQqHueLajMR3AYMT1zitUOp2adDVbPbOOnQJiDBLVg
 mp7lHP9AYq7RYRAa43xJLMbinfGQrZsSsrYlZkZFDbLI8/YUTyw2tZq52
 exvqZQmHYaaWVOxUJg2WwdAl2Zk0C2ylzgWwiwmNy7x79g5MD7K8iAasj Q==;
IronPort-SDR: pmvLp3F1eXBMzWpV2mY1WV8+OMSEN1tKXlJp97otFx3QqekPkNNrzr10K8ioPCBy89AJfVhohr
 aGMnCGd16trQZVucLi7HdPAKm5Fer8xOI/6NEDHmsIP/3Vrjr9CY9V+Ry5PIWI2yVA8mP1WQcA
 fw/YzuSvopRYmJszU5/AyQNNBXo570tQ4uzLRv1zZVAA4q16NkNbPv2MazVZzCkiG/6osxTtCi
 zREHuO29fglBJiK0X/ddBhymwDHx1XXlJu42M72reBqrk8S6kJvltmbDvR8xwlVPZ5ScIBJsmc
 WJo=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; d="scan'208";a="269855509"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:04:49 +0800
IronPort-SDR: WCn/rHxOpfFxQmY6t0NxC/RrY+cEcBDUtYbpenHTS0vHpNWtolXX6Z9xUAJNkgZLmdki5FYckB
 sKiqUckRH+37eShQuEIptzQJB+FyJmYzkqETrs1HOtbupHVApL+zDuU3WZDlS2FHSYv/xzwW+b
 4Fzl2H8FS/m9kep3Oh+jpilQw42+ODN5Wi0xKlwsK1CL7/d6OHsDfhTMKbJtosiIdOOaQP4FOy
 /4rvTBsxh4PZu8NtXJqqm33g6hUZmE2NX3z01tkXjElKJKUGYQ3GNQn9QzU9pbBN8RBm95Jwpe
 Z5E16EKp7yaC5pdXViKUsfAP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2021 10:48:43 -0800
IronPort-SDR: kbuKIeO0AI9DEI+MIQQ6CERcLJnA/EyVGmtMpQ8f1jguskefPUd+f/2FtXU9VCEEsfvZoymzjR
 Nz9W5KtndcUDtWjZFQc7XM7vAsahBOcCZfV0oKzAfYlSOYyNK42W5Y8zjeMh6yHosSJBJfsVDk
 Kz/m/KtvRXAkvLuXXc8iKui771YFkmjT5p2omMAQY5MvQDwVKZwmINqJBiIGWIClOHouEqXGIA
 5BFwvE6EyBVjXHK4MNwakyTD988bwcqPTepzRYwxBiNZ8RfhnV32rS5saUPih3CdycmFvOw7Z+
 q8A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:04:49 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Sun,  7 Feb 2021 11:04:19 -0800
Message-Id: <20210207190425.38107-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-Headers-End: 1l8pMg-0000ez-Ns
Subject: [f2fs-dev] [RFC PATCH 2/8] brd: use memcpy_from_page() in
 copy_from_brd()
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
Cc: axboe@kernel.dk, hch@infradead.org, damien.lemoal@wdc.com, tytso@mit.edu,
 bvanassche@acm.org, chaitanya.kulkarni@wdc.com, dave.hansen@intel.com,
 johannes.thumshirn@wdc.com, ebiggers@kernel.org, clm@fb.com,
 adilger.kernel@dilger.ca, dongli.zhang@oracle.com, dsterba@suse.com,
 jaegeuk@kernel.org, ira.weiny@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/brd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index d41b7d489e9f..c1f6d768a1b3 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -220,7 +220,6 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -236,11 +235,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
 		page = brd_lookup_page(brd, sector);
-		if (page) {
-			src = kmap_atomic(page);
-			memcpy(dst, src, copy);
-			kunmap_atomic(src);
-		} else
+		if (page)
+			memcpy_from_page(dst, page, offset, copy);
+		else
 			memset(dst, 0, copy);
 	}
 }
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
