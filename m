Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95570C79FBF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9zjL9WSl5XKn6dOIiz1MGTB80FAPrvYNazI9XtCs64=; b=F3jl1i7k2aHuFKF0tR0TQn0hlu
	csoVWUpmElUdsodG1r0BBl2GOD2bRSQ9gHoTUD35THlwReD/VwpXX2Wphhfsi2uvvc8UhJT+mbApU
	yBSFJUsf8uQaR20mtxpLIEmr44IGF7xnQ6Rk63Ld9QMaXcCCEA3GH5RNUB5yF3gi8KbU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47FJ-0007RT-Pj;
	Wed, 09 Sep 2026 01:37:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47FD-0007Q7-TO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tZlyTWHYBuDjKHC1ECD3e148/g6aN4ehhQpiqfvzaKU=; b=LmFOgW47ySNXZWDUDUPV9GO7C8
 nFtxYimhpBp5AfSoouyFwJir/nUfeSwWZauoUvbzytVvGckxaklwnR0Wy6MdoqQytn/bHUOVyRsIy
 rV9a9DEZxoAwyWRfvsqAG/ZA32zCwWjk0TXm1vkK3PP3E67SQl3/HFqllm0Qxhl1Sov0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tZlyTWHYBuDjKHC1ECD3e148/g6aN4ehhQpiqfvzaKU=; b=AI6IEyg4XXSTdVVWBuWMbUd5m8
 CDsVG2fQOaEckzB0zxd/ZbV69qXjtTX3Fww9/WBSY5q4R8G13QyYLSbm2FQ0cnRkAtHaSIrlfsWDF
 XMwf/EzVVN59Z8RaZzApWgNwV4vijvndKDutIDnNkQr+gk1cFyOpP3rvfNhLOAi1iXuk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47F0-0006xQ-7y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:36:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 130FA6022C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 01:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F981F00A3D;
 Wed,  9 Sep 2026 01:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788917805;
 bh=tZlyTWHYBuDjKHC1ECD3e148/g6aN4ehhQpiqfvzaKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BzjRUNM+y0kFALx6pM0uE+PIS3MY9ofyaMT6HxCzjzpsfOiccBlZtqv0XcJWHxDju
 FvKN7Bexno36XcEM0iE8zEyvm1H9YTKAfk+kAzBzbRf+99sLNyJjuXv/oXWUuaq44n
 KpA2WarvkaPUWNtbFA2Czb0+sP1iJoSE8aKGdsdQ3wHPWK9C+rHEF6YfW7EWIkg4Vs
 xzM4aIc0XhUgQBgw+hN2dy9Q1hSwzBq5EL+Fir/8l4PJlZCh23tTy3DkG8KZVbjz73
 fkk2DZNkrPIyP317hZbkkoSXaauh6MoMNUzvirmGlTIvgrti1t8p+ocD3TgacVcpjT
 PdRXdk1pNYxMA==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 09:36:11 +0800
Message-ID: <20260909013611.3418568-13-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260909013611.3418568-1-chao@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x47F0-0006xQ-7y
Subject: [f2fs-dev] [PATCH v6 12/12] f2fs: cache: show per-cache usage in
 debugfs
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This patch exposes per-cache memory usage (entry struct memory vs.
cached block buffer memory) for meta, node, and compress caches under
the memory section in debugfs:
  - meta entry: xxx KB, meta cache: xxx KB
  - node entry: xxx KB, node cache: xxx KB
  - compress entry: xxx KB, compress cache: xxx KB

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.h |  1 +
 fs/f2fs/debug.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h  |  2 ++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index a81524755dad..86aa5f09ad03 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -38,6 +38,7 @@ enum f2fs_cache_type {
 	F2FS_META_CACHE,
 	F2FS_NODE_CACHE,
 	F2FS_COMPRESS_CACHE,
+	NR_CACHE_TYPES,
 };
 
 /* Main cache control structure (per sb_info) */
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 4ed5c271dba3..8c0cffde2457 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -380,17 +380,36 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 		si->cache_mem += si->ext_mem[i];
 	}
 
-	si->page_mem = 0;
-	si->page_mem += (unsigned long long)META_CACHE(sbi)->num_entries << PAGE_SHIFT;
-	si->cache_mem += META_CACHE(sbi)->num_entries * sizeof(struct f2fs_cached_block);
-	si->page_mem += (unsigned long long)NODE_CACHE(sbi)->num_entries << PAGE_SHIFT;
-	si->cache_mem += NODE_CACHE(sbi)->num_entries * sizeof(struct f2fs_cached_block);
+	si->cache_entry_mem[F2FS_META_CACHE] =
+		(unsigned long long)META_CACHE(sbi)->num_entries *
+		sizeof(struct f2fs_cached_block);
+	si->cache_data_mem[F2FS_META_CACHE] =
+		(unsigned long long)META_CACHE(sbi)->num_entries * sbi->blocksize;
+
+	si->cache_entry_mem[F2FS_NODE_CACHE] =
+		(unsigned long long)NODE_CACHE(sbi)->num_entries *
+		sizeof(struct f2fs_cached_block);
+	si->cache_data_mem[F2FS_NODE_CACHE] =
+		(unsigned long long)NODE_CACHE(sbi)->num_entries * sbi->blocksize;
+
+	si->cache_mem += si->cache_entry_mem[F2FS_META_CACHE] +
+			 si->cache_entry_mem[F2FS_NODE_CACHE];
+	si->page_mem = si->cache_data_mem[F2FS_META_CACHE] +
+			si->cache_data_mem[F2FS_NODE_CACHE];
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (test_opt(sbi, COMPRESS_CACHE)) {
-		unsigned long npages = COMPRESS_CACHE(sbi)->num_entries;
-
-		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
-		si->cache_mem += npages * sizeof(struct f2fs_cached_block);
+		si->cache_entry_mem[F2FS_COMPRESS_CACHE] =
+			(unsigned long long)COMPRESS_CACHE(sbi)->num_entries *
+			sizeof(struct f2fs_cached_block);
+		si->cache_data_mem[F2FS_COMPRESS_CACHE] =
+			(unsigned long long)COMPRESS_CACHE(sbi)->num_entries *
+			sbi->blocksize;
+
+		si->cache_mem += si->cache_entry_mem[F2FS_COMPRESS_CACHE];
+		si->page_mem += si->cache_data_mem[F2FS_COMPRESS_CACHE];
+	} else {
+		si->cache_entry_mem[F2FS_COMPRESS_CACHE] = 0;
+		si->cache_data_mem[F2FS_COMPRESS_CACHE] = 0;
 	}
 #endif
 }
@@ -749,6 +768,18 @@ static int stat_show(struct seq_file *s, void *v)
 				si->ext_mem[EX_READ] >> 10);
 		seq_printf(s, "  - block age extent cache: %llu KB\n",
 				si->ext_mem[EX_BLOCK_AGE] >> 10);
+		seq_printf(s, "  - meta entry: %llu KB, meta cache: %llu KB\n",
+				si->cache_entry_mem[F2FS_META_CACHE] >> 10,
+				si->cache_data_mem[F2FS_META_CACHE] >> 10);
+		seq_printf(s, "  - node entry: %llu KB, node cache: %llu KB\n",
+				si->cache_entry_mem[F2FS_NODE_CACHE] >> 10,
+				si->cache_data_mem[F2FS_NODE_CACHE] >> 10);
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+		if (test_opt(sbi, COMPRESS_CACHE))
+			seq_printf(s, "  - compress entry: %llu KB, compress cache: %llu KB\n",
+					si->cache_entry_mem[F2FS_COMPRESS_CACHE] >> 10,
+					si->cache_data_mem[F2FS_COMPRESS_CACHE] >> 10);
+#endif
 		seq_printf(s, "  - paged : %llu KB\n",
 				si->page_mem >> 10);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e27d24029f0..fd694e6d9553 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4524,6 +4524,8 @@ struct f2fs_stat_info {
 	unsigned int block_count[2];
 	unsigned int inplace_count;
 	unsigned long long base_mem, cache_mem, page_mem;
+	unsigned long long cache_entry_mem[NR_CACHE_TYPES];
+	unsigned long long cache_data_mem[NR_CACHE_TYPES];
 	struct f2fs_dev_stats *dev_stats;
 };
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
