Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ECDC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Mar 2022 10:20:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nUQdc-0000X2-RP; Wed, 16 Mar 2022 10:20:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nUQdc-0000Ww-0p
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Mar 2022 10:20:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XGr49ptncj/lazavgMoufDJQLHhuybF1t0Z0WtSFbAQ=; b=XhSCWHJGz048NxW48DslWJhD6z
 1Ybn1yjNJEuAnn8DUrWCuUfL1jOosGnHNrfPRUoZb7pRIkGGE0EydQ9iVmGQAVU/5iAjQS60H8mUb
 MnZCPG563RczoHEweKGTVqp56alMua0BJ+4Qs2GWMgJSQE2OGAkIQkhRkVHJwL4Q4D/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XGr49ptncj/lazavgMoufDJQLHhuybF1t0Z0WtSFbAQ=; b=W
 1ClNNWXo2jOhl7aJRGy92sz4XokUQULjH9DiUsu5Fo0jCMi5u8n8gxnz9qoawWNRcOiVJ9CoXKdjR
 AAJ8mAuNmDqPyFWQoU9/DQ6yo3PdvMwzU3ANIt5yvPE15EhN47TeUZvrBwUehrxgzsHXwnY6b74P6
 gu06sn3+IIq/AhP0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nUQlP-000qRl-Vh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Mar 2022 10:20:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C74436164F;
 Wed, 16 Mar 2022 10:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5630C340E9;
 Wed, 16 Mar 2022 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647426009;
 bh=/O1Nhrg2OVtXL/SSKJRs6a8jMBlhRF0EgxSsjcaNu0Y=;
 h=From:To:Cc:Subject:Date:From;
 b=S+isYU66SstsukJ6kfyz5DNuehqto6YJ82XjSjYa1hOR1/vGmQhj7T7t0+HHCzKv9
 4anjJIqogV0DqfF/UCRNamOcXgywYRWuvWy/6mGjzbYK2SpkwAIyiLB3exSIPVzhz+
 tR0rgegTTn4RtH6YaY8dySNLPMd408f55Yj45gujmlvVBZw/m+HHSeYzLCCH3yFh5p
 wfBGowmca9mL8au3jSn8J76ES2j6corrdOoFaCLMDnhictoT3RHtf1xkh0tfw6lY8q
 X1jlPn6HAj37pJmoPrMvxImMpc3TMC+RbFkr9d83PxNsQfKjUe/symF5+mzYwj147J
 PwnS2/Tmnxscg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 16 Mar 2022 18:20:00 +0800
Message-Id: <20220316102000.3727130-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1nUQlP-000qRl-Vh
Subject: [f2fs-dev] [PATCH] f2fs: compress: fix to print raw data size in
 error path of lz4 decompression
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In lz4_decompress_pages(), if size of decompressed data is not equal to
expected one, we should print the size rather than size of target buffer
for decompressed data, fix it.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/compress.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 67bac2792e57..11e99bf6286c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -314,10 +314,9 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid rlen:%zu, "
+		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid ret:%d, "
 					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
-					dic->rlen,
+					F2FS_I_SB(dic->inode)->sb->s_id, ret,
 					PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
