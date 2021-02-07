Return-Path: <SRS0=fAWp=HJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C844EC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA2464E2A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Feb 2021 19:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA2464E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l8pN5-0004rU-Qv; Sun, 07 Feb 2021 19:05:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=665305f4c=chaitanya.kulkarni@wdc.com>)
 id 1l8pN0-0004rE-Pu
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Feb 2021 19:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZsH3dO8TeRAP6GlZa9jMwuG4oDbaRdPa2/GLPgfJj/0=; b=O8jAjaa5Evmq69KuymH/g1LZtH
 McBg3GJlXhYhxAmy4nD4HHg3bA4R3coNUsN05VoeJa0M2HEIbK0fTiJB3erNV0+cyssIrGTgEr2SS
 O5UM+Om8XkubAYziN43nkEivtKF4AF1kaWOxRvmk55FC3yoSXbur6OOcfkUyrkD1tZsM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZsH3dO8TeRAP6GlZa9jMwuG4oDbaRdPa2/GLPgfJj/0=; b=mXWQ4n4cA6MnDGKrDiHjLBoYRt
 pY6xXkZ/DwAyZocL9KdB8Aqq63j6tCcWzULUot4gw+jvY2WFZek15KsP7zI0GY2oX7CSzGq0WK7b8
 Rv+ACZyf02kn8rFsquGC3SpA/CsfP1IifPmoVF/w+1kPTN1QZTG9D4Bs+BWFcJmHLRQU=;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1l8pMo-0000f8-EN
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Feb 2021 19:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612724706; x=1644260706;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bUHJh7WdO4b/toeg0AHLw0ztouu30XNNBjvj4mVAqXU=;
 b=MtUxG7yKjZdKJxBYQPtXOCQig9b+sZ6LabJGu0Ml/mi234OE7M5feH/l
 kcwHidkcU6RNAy6j0Btrern1+LKCnBAB9lweDbK16w0IAffHnM9x7sN5u
 4eNUp11G+4BMFhmguo5r+vrrxlDrTlJmqHKzj4W6dxg42/sTyGBivU+9z
 +gfnscHWA3I9ITszqrikBhhNQF1npzHJ5Enq41v1SwUhlNmZmJt5fS5+c
 XJrPlj8Tme8OyNQfhbW8QyzTivcC5td5mE8lcQa4LWP3nRJsYA+AsRh47
 QhoOJgfDo0Wg6MIz/X7udmkfKtZdY307dsMdjntkWYesWOxsU8EyTWThE w==;
IronPort-SDR: hXEYF4Nd2F9d7Wlv26kWSGewGMtOb0O+zzBTkh41aZsUgqGnH2oaxgWMsHp+HVnDEtVaPcDgEg
 tDxcpQRqohuoiof4TUq+mW6Twc4oyOvFfgzqmqhD3DYMCKcRfywG1M5MHhTcpQfTYU7J1QgBP5
 g9Fr161Q+5jGonC8vLvGL/BenW5tAg1twmXM+/axvwscSgT3MxwnX6wNyHKHjtICXLDkJWcLhJ
 STK52xjfeFBFjRBmC9q+Ag4E4bHgm0WUBxjo09KLrfhIJYMVnTbDlE0RvxymlopTnOG7R6V7nM
 BgU=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; d="scan'208";a="163856617"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:05:01 +0800
IronPort-SDR: v0Mjq7oAp2SuADo+jdAGVxtUtV7RzgmJmDJMa3dD8B6Jspwh7kvoPItEYmU/o3YuWb+7QGr6Dt
 DDKEL8Q7TQ/4eY3P4N4BamSIOQBEQLCqOG2iOlAc7QZ7Xfg/zQ6K1D6C+ujQbbbQrv+WdtjyTA
 sHhssS5jvag9Lvmlwk/Yq1UCCtY5305kwreNVkCQ3Cic+dB8lvMqu7EGb/BZpud+70DUeM63T/
 T/j4AkDUy8e26sNxgSo4TMgfPM+DRyko2+WC3oDKBJJTj8b8+8SNmA3MjpYxAsg2ppww5XI02n
 q1Gs7cO1S/2fOsg9b8FmuK02
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2021 10:48:54 -0800
IronPort-SDR: TvntBeAolPC47uEpAHveeRKqEAmQL1bLDsoSWx9UpeX47q4cyQVQy0/0wIpmXUs9xAT7lHssFB
 L57BvqnFnKJXULcHqEPvzUOsd8dD+lK3twgfLVgzhBoeVPuQ4CwxXf6ijN+9cS23SbxJwwC1ca
 OiM7KkSy/vLyrwoKEiE0ZKxRIxUziNbioNV1M/OyOdDwMEiYT1CCLSrTb6O8b05Bfrul78hTkm
 1+OzN7Zu9sty6jW/ftaKVNTes1sB5dbW9tkCcjLxoqLUiryAVTdKBf9m197WEQaorT4hlklXpH
 B3I=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:05:01 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Sun,  7 Feb 2021 11:04:20 -0800
Message-Id: <20210207190425.38107-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-Headers-End: 1l8pMo-0000f8-EN
Subject: [f2fs-dev] [RFC PATCH 3/8] null_blk: use memcpy_page() in
 copy_to_nullb()
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
 drivers/block/null_blk/main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..c9b6db82b07c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1010,7 +1010,6 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 	size_t temp, count = 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
-	void *dst, *src;
 
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
@@ -1024,11 +1023,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 		if (!t_page)
 			return -ENOSPC;
 
-		src = kmap_atomic(source);
-		dst = kmap_atomic(t_page->page);
-		memcpy(dst + offset, src + off + count, temp);
-		kunmap_atomic(dst);
-		kunmap_atomic(src);
+		memcpy_page(t_page->page, offset, source, off + count, temp);
 
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
 
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
