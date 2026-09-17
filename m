Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB0FC982D5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DeR0GhNMnrtLI83PkpktVzRgR8gRour/RQxXgfesUtg=; b=U2Me/4EhxkZzQf9q0QoMNZJ7Or
	maFsirXDrW2s8UuRVDWGQjP5DfWx8BEkivL/Y61EyAL3xo85hpdxuyNSgdrIhiORIxjItMfiuJxqC
	e6/WfwhVvUjskD7Xo72KiCYWPJ/bJQaPFAZij8nXfN86La6p5z62qAp0ODmX94icUMqk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x76dM-0008Po-Tu;
	Thu, 17 Sep 2026 07:34:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x76dJ-0008Ox-25
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qtfHmrcOx7l5K33QLc+DsrrUsVePTJC1rQbR0BHrku8=; b=l5Aezkj8wYmtKFpdEhqy6EhdlQ
 VQxaibBYlf1eN/OkVJDs2cM32pxkq7VFSZCsFl4AS+EEjG+pmUURSSBdE7/VNbH/BQwosw1vFx2H7
 n//tXgnKsJB2cRiIBib0dvbAZvXgNNPBlaKvFRsUX+Duuxhkf0Vwj40aEp7ShR8lptv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qtfHmrcOx7l5K33QLc+DsrrUsVePTJC1rQbR0BHrku8=; b=Q+WroqGt0xFU/fYf3tWG8eGn+P
 jh+AHQCPTzP1box1A6sFRVcU39ftvfvjWeis7lMxS7wOJ7rmtWgPlby+05T8XwNFGZDVhk5W4pAyc
 MVqYDHKwEKUjU+T+Q17ZxwppCwQA2o6lyuy+EfSCTIx3t+DQg6sweTrd12J2fao9Wv00=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x76dF-0007NX-2t for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:34:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5E97447E8;
 Thu, 17 Sep 2026 07:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28251F00898;
 Thu, 17 Sep 2026 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630443;
 bh=qtfHmrcOx7l5K33QLc+DsrrUsVePTJC1rQbR0BHrku8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gxQbkeTK86qMEXFWGkD8Pp+i+vIw8QXEhkx3s0C+y/iJvdqQrEA/2t8/3FLB5TYFC
 m1k0vDsZZUElwFwZ+Rr3lUWrvQlQ2BsbIy5rea/T1RJgPiMJz1nXP6UQNythP4Zcjn
 rlZIdgHlf6kCyt+o7QZOdWdJBxQjM2JT+8LRye/6oiynm5BkSlVP0jDdDB+Z4uvfA2
 t2CMD1Ca7FQblfwY+xbYJ7zF+dLpYf4Ym3q9vAtDiSWqAvvdnW1ubSuf6wWfRKUsQ7
 j65nK5GkDuT1wjdI5oOjyIpvJE6we81HKqnYPq0NuFBWhyA+CgpuVw7YZWihk2oInQ
 j2ejyaAeck+YA==
To: jaegeuk@kernel.org
Date: Thu, 17 Sep 2026 15:33:43 +0800
Message-ID: <20260917073343.2823157-13-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260917073343.2823157-1-chao@kernel.org>
References: <20260917073343.2823157-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x76dF-0007NX-2t
Subject: [f2fs-dev] [PATCH v9 12/12] f2fs: cache: show per-cache usage in
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
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

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.h |  1 +
 fs/f2fs/debug.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h  |  2 ++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index e50b9ad6fdae..6c4db910d767 100644
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
index 69690b061236..34878d99a2f0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4525,6 +4525,8 @@ struct f2fs_stat_info {
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
