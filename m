Return-Path: <SRS0=D49P=65=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91184C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2020 02:16:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5775220671;
	Fri, 15 May 2020 02:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MyOyES64";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WfDTonQO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4YIhfDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5775220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jZPtU-0002vP-Cy; Fri, 15 May 2020 02:16:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jZPtS-0002vE-IA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 02:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=351WezkUTFEoTBunSyAYj6XZcqivW/zMsRsQdzyRBqQ=; b=MyOyES64SgIO6cXunHfQxqy9C3
 LrLXa6MMQChgehzDfMIVYgOpIIMYjO5qMEx/evZxrfB4pGKrC4LIw0NmIUQfLJi9XlWOtetO8AoM5
 9Rl2NdQTlUx9W9EjfvsUr4yenTzNHvmcjmBoVYZQGqt88/3OUBhvY/5bzx7nQsERx2YM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=351WezkUTFEoTBunSyAYj6XZcqivW/zMsRsQdzyRBqQ=; b=W
 fDTonQOd4A4UOT6bMRn6JfGYCAOGwFQc/QkaMWA0JNMHnt7+1J+H2ONJDIgev2AtZuQOV/JxiiPDz
 ERuSNBfADiQhIK3fu+dBj3/nMJyujFgNiNhRj5AWa6z79XQ0OZNKWDVnw1oG6cZfdgMizQScKtoK/
 bT5++wzWtK7HVlMQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jZPtO-00AzPQ-8q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 02:16:10 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD68D20671;
 Fri, 15 May 2020 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589508956;
 bh=L9+TTBBOKheIWuMPzBAUV5fbpWKbO78Ws7uOfGtM91U=;
 h=From:To:Cc:Subject:Date:From;
 b=R4YIhfDdLDZQrkzG86difRUEi0nJs0K06eGeJBj3DCbc12JXuQXcl1LmlYzeyLTG8
 Xs02DWrNtjheyiub5zZIQ+hhMePNJ8kAdd1lPHF8G77ol0smqi7ZjovaMtlpXEtekz
 r6WF7wECD7wYI4QiSIsa4wliw/CM3hgSEzyeYJjI=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 14 May 2020 19:15:54 -0700
Message-Id: <20200515021554.226835-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
X-Headers-End: 1jZPtO-00AzPQ-8q
Subject: [f2fs-dev] [PATCH] f2fs: flush dirty meta pages when flushing them
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's guarantee flusing dirty meta pages to avoid infinite loop.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 620a386d82c1a..9a7f695d5adb3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1266,6 +1266,9 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 		if (unlikely(f2fs_cp_error(sbi)))
 			break;
 
+		if (type == F2FS_DIRTY_META)
+			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
+							FS_CP_META_IO);
 		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
@@ -1493,8 +1496,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
-	/* Here, we have one bio having CP pack except cp pack 2 page */
-	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 	/* Wait for all dirty meta pages to be submitted for IO */
 	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
 
-- 
2.26.2.761.g0e0b3e54be-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
