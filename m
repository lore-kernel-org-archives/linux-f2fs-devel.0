Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74265606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gSmbxWZg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NtYyt766;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e87K6vrY;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kj16Mgas
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GaByXZe67ful/xSnNiBYiK1QT23nk9LlgFB7yY25Pk8=; b=gSmbxWZgkZDzVb+THrMAyQRJ/k
	vpHnkjm/zmBQGpCqc+TeUWvBqAMJDf9gRxwHocYY1+fSyv7xAtAq3h4g442QR5ZdH7o7mPCdqbIGc
	yXbFSadYYkqp7PLnRFnmcHdEKAjczXTSz8DkIG3MsIGAXaLm48BekBj16NMHJD1ykkSw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsID-000000006Mm-0nBB;
	Thu, 22 Oct 2026 12:53:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsIB-000000006MX-2PrR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f3425FFwqY4+ykygrz2W1w/JyuCVFU9bZFNGhlsY4u4=; b=NtYyt766yXM59qoXsp46Aa4acS
 YwGA+me140eIWLgFHufslHEaQ6P5+xpmv+xB2ZMuV9sCUAYcbfZlcjNGKHTSeUUin4hnTtkQZ8To4
 oDaix8oDVWgXC5MAAbO6QlPf9xHfzd77ANydRcUKBA85xloyGbVnAS4I76InWto+5kbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f3425FFwqY4+ykygrz2W1w/JyuCVFU9bZFNGhlsY4u4=; b=e87K6vrYnlkgApA3u+UG+9P9et
 P7phbBgwFXaAO8I9+qvFBJsh2g2GkiKl13JS4ncrAEVUbaXxo02nPbIT1bNl/AQ5F2URlUUMfAVzd
 I8bUfJRTTwGZJuJl0y250xiCqhIESAYF04aMsP5Wy8pODa6FW0d31EnCt/ypx0TL3jg4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsIA-000000006rR-49Xq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A053B415CF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DC51F000C2;
 Thu, 22 Oct 2026 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673585;
 bh=f3425FFwqY4+ykygrz2W1w/JyuCVFU9bZFNGhlsY4u4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kj16MgasWVl8hOMHuDqyew0FxWjoNWqjQtGJiRUni2hZnZA+2gejVwlEndYitzM8A
 1kGal2hP8cykmGouQK6FwBYDg+25sqPu+L5pnarOzg7ikigoRfVPJaztMXC955hkhO
 bzXP/aRRnAoU7PLLziY8CtPSrW3OIpCIgMYvm7fQTx9TAs5s0GLQck6LTSqigPxZnq
 RtRhSoRtUmYiqYkGRjDam9lfAM6/l4+aUdfkFvTho0st7ZWHs3PzA1tqmibwe0wcd/
 al1ISjek0Cxz68Ijr8EW/jl4Bns7+pbzXh5tQEeg1t9d89Ut2YrrCFP/wYC/CZ+TzF
 7kndehlPHlzvA==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:44 +0000
Message-ID: <20261022125244.2205275-7-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125244.2205275-1-chao@kernel.org>
References: <20261022125244.2205275-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsIA-000000006rR-49Xq
Subject: [f2fs-dev] [PATCH 7/7] f2fs: cache: fix to initialize
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
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

Cc: stable@kernel.org
Fixes: f45afeabd5df ("f2fs: cache: introduce writeback thread")
Fixes: eeadc4807c95 ("f2fs: cache: wake up f2fs_writeback when exceeding threshold")
Signed-off-by: Chao Yu <chao@kernel.org>
---
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
index ba2ec6123251..12a051ba51ac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5356,6 +5356,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
