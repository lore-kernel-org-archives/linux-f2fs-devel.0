Return-Path: <SRS0=NJ+j=NX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF8C4320A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Sep 2021 07:33:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2E361059
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Sep 2021 07:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A2E361059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mLKkZ-00065X-Ss; Wed, 01 Sep 2021 07:33:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mLKkY-00065H-2v
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Sep 2021 07:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=79qNy07G3tuuHUyU595sCqDFO5CseDJE6fuuoDW1Br8=; b=ly5gDB4IDjAvND/qpi2LXjazlm
 lJED36FmTeyUukbbY6OZ5NdH4dO0bm+l6I3PZpW0ogcejXsiHIi57SlU40IUeg1n6wGYuMr2mK5UY
 elNrEoDblGobfLkqexXDe/d5YoplruyHNq3bGyQmbJ/2MKPtEHttfflCpeybnYgI2KtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=79qNy07G3tuuHUyU595sCqDFO5CseDJE6fuuoDW1Br8=; b=S
 araPzeehJ/pGIvi9O+rDnFKE7Lg8Ovhxzzq70+en47+Oz4+U8eTf+Si667xiYpWC1Zw6N4ZjTEYlQ
 6dKKcJ7QP9JaShgM9nYRl1m65kb679tqsyPNVVJRyNbDTHl8nr5aK6F4GKWrg6z8B7JmntW9RXXHD
 S8J+pL6j+BMZN2o8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mLKkX-00A6SA-BQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Sep 2021 07:33:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9B0E61053;
 Wed,  1 Sep 2021 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630481607;
 bh=oVGW2LLKuSUoG6VqtTOQRtvJs9Oj6W5e/WXkqgv1p48=;
 h=From:To:Cc:Subject:Date:From;
 b=UByV8Mv+AkKXy8nUpooF1l85Nds35ZYIfmlkX0/FMg8NaRfaTogefjTKXmQHgXeK5
 JoBzZhB/wJEHZxgbcFy4t8iEzSY9mRcXHA22TzTzwFCYNuDAOvRUKyMgPt/ZttkL89
 h4TJ6xKWD5kB8ESndJTbT468xUmiomKGBUIsEnxkTB2092VScKhv8rqvqNW6okXqdD
 uRVvlPpUXN0D7PPMlILkPK93lMtDsk0V3zDnJEhDPXfYJOmrG0yhBlBmz/r97/Of7B
 YudtnVT+RT7CIQ+4I74718h/tBTAlAh8lYctcVoA1hTiJ9u/G5Vo6gqmxNKuZONdrQ
 Ik+EVN6je3CgQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed,  1 Sep 2021 15:32:32 +0800
Message-Id: <20210901073232.109355-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mLKkX-00A6SA-BQ
Subject: [f2fs-dev] [PATCH] f2fs: introduce excess_dirty_threshold()
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch enables f2fs_balance_fs_bg() to check all metadatas' dirty
threshold rather than just checking node block's, so that checkpoint()
from background can be triggered more frequently to avoid heaping up
too much dirty metadatas.

Threshold value by default:
race with foreground ops	single type	global
No				16MB		24MB
Yes				24MB		36MB

In addtion, let f2fs_balance_fs_bg() be aware of roll-forward sapce
as well as fsync().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  3 +++
 fs/f2fs/node.h    |  5 -----
 fs/f2fs/segment.c | 23 +++++++++++++++++++++--
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6c5e75f86da4..5ae2ca6dba96 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -562,6 +562,9 @@ enum {
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
 
+/* dirty segments threshold for triggering CP */
+#define DEFAULT_DIRTY_THRESHOLD		4
+
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index ff14a6e5ac1c..18b98cf0465b 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -138,11 +138,6 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
 	return NM_I(sbi)->nat_cnt[TOTAL_NAT] >= DEF_NAT_CACHE_THRESHOLD;
 }
 
-static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
-{
-	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
-}
-
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7358342652ec..ffd148429a9d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -535,6 +535,25 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	}
 }
 
+static inline bool excess_dirty_threshold(struct f2fs_sb_info *sbi)
+{
+	int factor = rwsem_is_locked(&sbi->cp_rwsem) ? 3 : 2;
+	unsigned int dents = get_pages(sbi, F2FS_DIRTY_DENTS);
+	unsigned int qdata = get_pages(sbi, F2FS_DIRTY_QDATA);
+	unsigned int nodes = get_pages(sbi, F2FS_DIRTY_NODES);
+	unsigned int meta = get_pages(sbi, F2FS_DIRTY_META);
+	unsigned int imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
+	unsigned int threshold = sbi->blocks_per_seg * factor *
+					DEFAULT_DIRTY_THRESHOLD;
+	unsigned int global_threshold = threshold * 3 / 2;
+
+	if (dents >= threshold || qdata >= threshold ||
+		nodes >= threshold || meta >= threshold ||
+		imeta >= threshold)
+		return true;
+	return dents + qdata + nodes + meta + imeta >  global_threshold;
+}
+
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 {
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
@@ -553,8 +572,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (excess_dirty_nats(sbi) || excess_dirty_nodes(sbi) ||
-		excess_prefree_segs(sbi))
+	if (excess_dirty_nats(sbi) || excess_dirty_threshold(sbi) ||
+		excess_prefree_segs(sbi) || f2fs_space_for_roll_forward(sbi))
 		goto do_sync;
 
 	/* there is background inflight IO or foreground operation recently */
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
