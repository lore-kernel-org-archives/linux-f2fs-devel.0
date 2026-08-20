Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58502C5DF8E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dQs4i96YbJ57/8UNY3odyAcVOG84AiEpOmt6leST3c=; b=kie2qv370ZzWJRP/UJdkez5eiU
	JMk+jW1vYAEcfXuMgY/APoiU3Re9CFpSQo+7g3uNPi7j9qO2PvrSa28TEivxIuSTSkAWuNykLN1nT
	WElFAqHTsxk8GF9kXDGCBxKi3d3oluVyO9F/5BTLkokF8XeYemGUSB96Pkov8PdB/4V8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwtIE-0001fH-4x;
	Thu, 20 Aug 2026 03:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwtHi-0001eP-39
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qxnxP6fMgeY7kpym8WsOfbIJ/DKC186UQ/+JXmq5p2k=; b=hkVH7r7K4mVM6RzB1J6n9+XODi
 rX4a+dFcXjaKC/ZNcyYlS6lfWLofw2zqROLsbW3T2AWLdokpAMDYKNWhL/ArIbuWc/6siPXGt+Uqm
 UFbJ2K89p2K3Qq/dt1lF+hXqggAWcLZtiuCov26DA1wjLAe+XieICQFO3BTGAE2TdSRc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qxnxP6fMgeY7kpym8WsOfbIJ/DKC186UQ/+JXmq5p2k=; b=l8RNvHmU7CUmb3eJIpJ8gl7/Ri
 r6+BlzObniI4UidiFXY4KrLua+czqY250kPgr+BJQCO1V2cprNZqqUGIRdvrsDEkkfIXgp7MjAz2F
 v5vMaaaufed3eL2qsFci27/w2NyPy88xBvbMQrd98eobJ3dQdcTJRQnt+VQ5yaAyYygU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwtHi-00032p-7M for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F4286189B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36221F000E9;
 Thu, 20 Aug 2026 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787195861;
 bh=qxnxP6fMgeY7kpym8WsOfbIJ/DKC186UQ/+JXmq5p2k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LCqOVgC2rBYw9No9H7BJulttoMJU3YJ7ucHb1wozhZCUJtg4t3cw9fLggX3FYhqdn
 7FhTyNhzH5bJp6uVSmTUFvMP/RC+XRYomnsZv32vu0uSZtmPRuLaAwTYhJkzu013gh
 X1E1sG78jcFO0Z9/Y86CFFLC9nSQRFrETVr7i+B3BSF8kOFPXdZM8j0D0UAT3Di/5f
 UgjBKwivyqi/cqV6/Wm2BVB9Mrx999OIjWd36g8RqX88Qq/DrhrQBGAnDMnkLU6cjH
 1EA9UKaHHIeA124GF9mUtXEe6iLJv/4h48gZyqx6pQODbwGdBcqSn2WD+3SIWtPzis
 S2irtkLv8KzkQ==
To: jaegeuk@kernel.org
Date: Thu, 20 Aug 2026 11:17:21 +0800
Message-ID: <20260820031721.12218-13-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
In-Reply-To: <20260820031721.12218-1-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wwtHi-00032p-7M
Subject: [f2fs-dev] [PATCH v1 12/12] f2fs: cache: show per-cache usage in
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
index 12c061d28d23..dccfc90fbab1 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -39,6 +39,7 @@ enum f2fs_cache_type {
 	F2FS_META_CACHE,
 	F2FS_NODE_CACHE,
 	F2FS_COMPRESS_CACHE,
+	NR_CACHE_TYPES,
 };
 
 /* Main cache control structure (per sb_info) */
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8cd06f7ba9e7..68a9d589da8c 100644
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
index 0a749a59f386..42952dde79e0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4453,6 +4453,8 @@ struct f2fs_stat_info {
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
