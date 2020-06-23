Return-Path: <SRS0=bwqY=AE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81504C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:27:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E88F2072E;
	Tue, 23 Jun 2020 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="FLYvL0As";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QGfExcwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E88F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jnjtm-00025o-9i; Tue, 23 Jun 2020 14:27:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangqilong3@huawei.com>) id 1jnjtj-00025f-Lv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Jun 2020 14:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eLsbAZxoA5tJFogdIEsu39ddfwtLT6lryzb2/FAB1Ss=; b=FLYvL0Asm35QwRIsEIP+O4EZBJ
 i6SWxKeAOxiAHdPUir6Mm/H/WlPCl02D9QkqlQWdIs0o2ygLNBe8U74qibjXmenNlox57e2yR+kYD
 wC4eaqEYcDaM4TwdFKTK+oEYRioEvj2kigL6wpgF7NdIt2KhWsGYzqtF6u0COIAkIakM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eLsbAZxoA5tJFogdIEsu39ddfwtLT6lryzb2/FAB1Ss=; b=Q
 GfExcwKU1psFE6dw/PaPEpGNIeO7nZdi+QKHyWN4Q/yWe/1WbJuNbqExiZjF73D3jZKvIhRiS8R8j
 ya7SwLY8Zlj0LvaIjRGOnSNkG5Tzqs3vtVcaUtj2AiBw8h55u53YlxA1X0qr+BDzeAJy4qI3xrzyf
 L1oVDRg2ixiY0bvU=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jnjtd-00FLAz-Lc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Jun 2020 14:27:39 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A4C0B7EE7D83138FDE36;
 Tue, 23 Jun 2020 22:27:16 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 22:27:07 +0800
From: Qilong Zhang <zhangqilong3@huawei.com>
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Date: Tue, 23 Jun 2020 22:34:07 +0800
Message-ID: <20200623143407.78400-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Headers-End: 1jnjtd-00FLAz-Lc
Subject: [f2fs-dev] [PATCH v1] f2fs: add f2fs_gc exception handle in
 f2fs_ioc_gc_range
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
Cc: zhangqilong3@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When f2fs_ioc_gc_range performs multiple segments gc ops, the return
value of f2fs_ioc_gc_range is determined by the last segment gc ops.
If its ops failed, the f2fs_ioc_gc_range will be considered to be failed
despite some of previous segments gc ops succeeded. Therefore, so we
fix: only all of segments gc ops are finished will return success. In
particular, 1).if target has no valid blopcks, it will go on. 2).if
target sectoion has valid blocks, but it is current segment, we will
reminder the caller.

Signed-off-by: Qilong Zhang <zhangqilong3@huawei.com>
---
v1:
- handle the -ENODATA exceptions of f2fs_gc.
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3268f8dd59bb..64415bd72ac4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2527,6 +2527,18 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	}
 
 	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
+	if (ret) {
+		if (ret == -ENODATA) {
+			if (IS_CURSEG(sbi, range.start)) {
+				/* it is opened, could try later*/
+				ret = -EBUSY;
+				goto out;
+			}
+		} else {
+			ret = -EAGAIN;
+			goto out;
+		}
+	}
 	range.start += BLKS_PER_SEC(sbi);
 	if (range.start <= end)
 		goto do_more;
-- 
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
