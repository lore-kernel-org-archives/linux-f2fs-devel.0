Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219A606A691
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZfJUhYoF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=icEvjEPL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F1JXFqG3;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfXjBjhp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X9rrnpYiii8P3QhwIllRq/b7kyMwawSUxyksf7DnI88=; b=ZfJUhYoFpl15f2CDggkpREuiBb
	ypzt+D6a0KwqzGGIATQ5ERcW5znxw4siZrfAY2CJKTI5PJcp1tz5M/LAAtyRNwp49K4CIOcSFFscU
	+OkyVLt6SXdJmg9bW/PvWGp4UBN1JU4ocmXv158i25Jq7hQp5DK8FbhcNPZWrcrEAwPI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWtd2-000000006WV-2eY2;
	Fri, 27 Nov 2026 10:56:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xWtd1-000000006WJ-3cUM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i3dVGIDEFMQ4QWIPW3txAjldYA5a7I1PUoZWQj/99WU=; b=icEvjEPLEYkpoAHfeBNnMmMWwX
 6QewU0+6vFFWSGwQWoxTdzrjnwyRoQUa77Xmfg0+Q3F+9Ooa9wxr3718m4WcJ+luHrEMHZKNB3Srd
 W9EbaowPWAZdlniRE1iaXd60YO8/DRDA32vgePIZ76xmqFNgTNHzxBog5+segWKiuzz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i3dVGIDEFMQ4QWIPW3txAjldYA5a7I1PUoZWQj/99WU=; b=F1JXFqG3RtqMpFzzIgHWbSTFBJ
 CCnqbBsYY7dCOuwe03EbKZYQd2tsaXrXZsU6Lj8iR179qqUpONczZBMlgvDYiVnVmtABjlA8x32iU
 cYOxOQzNVhgwsfGbXdvLk8EXwH8r02FscGraWbMU4dHIiHQdiOnlHyVDlwJbM6j0ZlLM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWtd0-000000006AN-1AF9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 018A141620
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 10:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014BE1F0092A;
 Fri, 27 Nov 2026 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795776984;
 bh=i3dVGIDEFMQ4QWIPW3txAjldYA5a7I1PUoZWQj/99WU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jfXjBjhpeR8q51ETOb4XcZSEtB1pRbb4GhcGsLoSyJgCSLAdL3UjmzbIceMl1PX1R
 b8Po9NFAdliuTgVHQ/SFclpG/B/rndbVrJYiaJQMMDIotUgUzmVPIAIjlQBAlDShYL
 VeyORWUji39RD0WD436loU1WuFNj1aLjXQRWobT0Uo/Cq3eDGK0a6NviKLl+HEOSAw
 pAPgnsWiKMv+vN+4XGxgYrc0gkKAuUD0Qnb+1Vr5/OOwnAXNFe2j3F4p1AcKrxTyMv
 Lr46PN+kFL8VSSpYV/aY7vm7BcJtsc85gQ/AppalRS4I1iHRF5iV/zVAbC4V6WvKlW
 tlAnOhOc7cA0A==
To: jaegeuk@kernel.org
Date: Fri, 27 Nov 2026 10:56:14 +0000
Message-ID: <20261127105608.537148-14-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWtd0-000000006AN-1AF9
Subject: [f2fs-dev] [PATCH v2 7/7] f2fs: cache: fix to initialize
 f2fs_writeback info at mount time
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

f2fs_start_cache_wb_thread() initializes cache_wb_wq and f2fs_writeback
tunables every time f2fs_writeback thread is started, e.g. in remount,
which causes below race conditions:

1. cache_wb_interval, cache_wb_dirty_threshold and
   cache_wb_total_threshold configured via sysfs will be reset to
   default value after remount.

2. remount will reinitialize cache_wb_wq, which may be used by another
   thread, e.g. f2fs_wake_up_cache_wb(), concurrently.

Let's introduce f2fs_init_cache_wb_info() to initialize them only once
in f2fs_fill_super(), then f2fs_start_cache_wb_thread() only needs to
reset cache_wb_throttled, and READ_ONCE()/WRITE_ONCE() is enough for
cache_wb_task.

Cc: stable@vger.kernel.org
Fixes: f45afeabd5df ("f2fs: cache: introduce writeback thread")
Fixes: eeadc4807c95 ("f2fs: cache: wake up f2fs_writeback when exceeding threshold")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/cache.c | 23 ++++++++++++++---------
 fs/f2fs/cache.h |  1 +
 fs/f2fs/super.c |  1 +
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index ddf94b5791e7..6cac7662fc1a 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -844,8 +844,7 @@ void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
 
-	/* pairs with smp_store_release() in f2fs_start_cache_wb_thread() */
-	if (!smp_load_acquire(&cache_thread->cache_wb_task))
+	if (!READ_ONCE(cache_thread->cache_wb_task))
 		return;
 
 	if (!f2fs_should_wake_up_cache_wb(sbi))
@@ -855,6 +854,17 @@ void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi)
 		wake_up(&cache_thread->cache_wb_wq);
 }
 
+void f2fs_init_cache_wb_info(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+
+	init_waitqueue_head(&cache_thread->cache_wb_wq);
+	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
+	cache_thread->cache_wb_dirty_threshold = DEF_CACHE_WB_DIRTY_THRESH;
+	cache_thread->cache_wb_total_threshold = 0;
+	cache_thread->cache_wb_throttled = false;
+}
+
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
@@ -865,11 +875,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 	if (cache_thread->cache_wb_task)
 		return 0;
 
-	init_waitqueue_head(&cache_thread->cache_wb_wq);
-	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
-	cache_thread->cache_wb_dirty_threshold = DEF_CACHE_WB_DIRTY_THRESH;
-	cache_thread->cache_wb_total_threshold = 0;
-	cache_thread->cache_wb_throttled = false;
+	WRITE_ONCE(cache_thread->cache_wb_throttled, false);
 	snprintf(name, sizeof(name), "f2fs_writeback-%u:%u",
 			MAJOR(dev), MINOR(dev));
 
@@ -877,8 +883,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 
-	/* pairs with smp_load_acquire() in f2fs_wake_up_cache_wb() */
-	smp_store_release(&cache_thread->cache_wb_task, task);
+	WRITE_ONCE(cache_thread->cache_wb_task, task);
 	return 0;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 5408727dd321..cd017c1b188f 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -245,6 +245,7 @@ struct f2fs_cache_kthread {
 	bool cache_wb_throttled;	/* last round made no progress */
 };
 
+void f2fs_init_cache_wb_info(struct f2fs_sb_info *sbi);
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 43ef7a4ac219..3fd8a18ac482 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5449,6 +5449,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
 	f2fs_init_cache(sbi, NODE_CACHE(sbi), F2FS_NODE_CACHE);
 	f2fs_init_cache(sbi, COMPRESS_CACHE(sbi), F2FS_COMPRESS_CACHE);
+	f2fs_init_cache_wb_info(sbi);
 
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
