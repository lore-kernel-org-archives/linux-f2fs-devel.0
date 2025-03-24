Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81E2C36002
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Mar 2025 11:52:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1twgM7-000641-Si;
	Mon, 24 Mar 2025 11:52:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1twgM5-00063u-K7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Mar 2025 11:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JiFVc12NnkpKf1CpOYEYfObjaOrqBbDLfQXXabhYPUQ=; b=KW5Lld6nfRFup36xlqqcD8XggX
 FoEMr2F3tPnO+Y+G+6roY/ICgoVHj7uk8kDAD/8Q9LopHvpFyTebubuS5727CKnRwARH3k85siYZ0
 lBHHu0goiqu6r7Na38xmoqvdPEtpL4AME6fpZsYAR0IT/NSv9QB+RvXaC8KWzVsUB4gs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JiFVc12NnkpKf1CpOYEYfObjaOrqBbDLfQXXabhYPUQ=; b=Z
 /GhK3pYHPGIRz04Zo8HYkDTQniKApcogBjR3SQXLUgsfnrYvJOp3cNHrgg0LGHr5DCYv5w+lGIt7W
 iXlUpzhT3pgBPZ9RfczyLg3tJ85eqgev34FMh1Ru1s1zYKmUOc27TGxhKsPVegL88T3uw7RLBLlsD
 YSpZGIMFIpW7NqnM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1twgM0-0006Qw-FR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Mar 2025 11:52:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D10B3436A8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Mar 2025 11:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2736FC4CEDD;
 Mon, 24 Mar 2025 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742817138;
 bh=h79RsWXA9VyEPromkK1/XFMwRbPLcntCFq54WISoilI=;
 h=From:To:Cc:Subject:Date:From;
 b=QDne/Tr6eyXTuCXmOsYVbDDlRZA87pFQNod/FjH+FXvxza4ROtZX+unKfNPnJC13L
 uR8Se9pqbnNDC//bO3/egaOGz0ZG4vezKVZCUFWm/ojp2GDfbFocQZj+ple+ujM6T7
 FsetpJwH1RTIeQHzpHwUGZ4K1S+/kBz0KzCCuOLQyrAffOLBb00JGXXDJgicBDv8CV
 jZvanTdOKKFj74RvFtTC2C9IL2Fr2YWPnYelAKuMhUGRIml4fv0YgB74C/AVfB/nI0
 qMZ+Mfiwn05GNvmCm5lxll/kQx7Hz1zPwALp+b5aw5fGXao1RXYQkCMfys2NILqUNj
 ddvaClMlnS6hA==
To: jaegeuk@kernel.org
Date: Mon, 24 Mar 2025 19:52:11 +0800
Message-ID: <20250324115211.3088698-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
MIME-Version: 1.0
X-Headers-End: 1twgM0-0006Qw-FR
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: fix to update compact summary's
 footer correctly
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It missed to set compact summary's footer correctly, fix it.

There is no consistent issue, as initial entry_type in footer is zero
that the value is equal to SUM_TYPE_DATA we will fix to update to.

Fixes: 724ca0883658 ("mkfs.f2fs: refactor format flow for cleanup")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 mkfs/f2fs_format.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c28ebb0..2680bd3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1012,10 +1012,9 @@ static int f2fs_write_check_point_pack(void)
 	memcpy(sum_compact_p, &journal->n_sits, SUM_JOURNAL_SIZE);
 	sum_compact_p += SUM_JOURNAL_SIZE;
 
-	/* hot data summary */
-	memset(sum, 0, F2FS_BLKSIZE);
-	SET_SUM_TYPE(sum, SUM_TYPE_DATA);
+	SET_SUM_TYPE((struct f2fs_summary_block *)sum_compact, SUM_TYPE_DATA);
 
+	/* hot data summary */
 	sum_entry = (struct f2fs_summary *)sum_compact_p;
 	memcpy(sum_entry, c.sum[CURSEG_HOT_DATA],
 			sizeof(struct f2fs_summary) * MAX_CACHE_SUMS);
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
