Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A733C88E4D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJGSzw8ex+Nb4MkD6J7m0azd7WnYlQ32VDsw+hXwYeE=; b=ms6xM99cFXMjZjK0Yzqzc1AEvp
	SO/baAL7q7xERKcsalXHi7z2kjXjiU/zkKP+188rjm8FuJWD1NnQQ8eDxGTR0yGaSlo+u4lExHxHJ
	oXDsAaX4LAQPXdJFlCh8XiJB5lBLZU3geiP/1JHfr7QDmkUDhM1ynktFCZ7x8WVv7PWU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5Ad5-0000YZ-TL;
	Fri, 11 Sep 2026 23:25:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x5AcW-0000Ut-0V
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OgQazA9zNz6iwqVAc6Q5Mh7H/5A+J00LljQ2qLc0+To=; b=HMus1CvUCnhm3CuyiblTEDM1cZ
 2KkrzvRoMZ0P3D0AlN8EvYRzhOjPe/UXTn/Cm6/co8l8BLjHuAzHU0uVHbcxEWvo5Qd+ENAs605v6
 1vJfu6ZV7Q/B5UBFc10cek11RaQPMFBmaCjXsDmOBNrfsMkSJhYM8jjeSlyZHHTHI3/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OgQazA9zNz6iwqVAc6Q5Mh7H/5A+J00LljQ2qLc0+To=; b=OrNzbzZ1rJ+ju6VsRcKWYyeKfW
 fTrFQhXpY4PeNiemeRu8W+K26S9rpWbIHOGQpMapHORkG/c5O7zoygUERyB+7m7+B/JgTWVoygl4D
 d3j/tgpDsgzBAyD57vLni7i3aAJSXRxaSDClT8hbH8v9JVkIr4Ug/dsFVEZdJPYWKaRw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5AcV-0005VY-1g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:25:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 779C7600AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 23:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FD41F0089A;
 Fri, 11 Sep 2026 23:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789169117;
 bh=OgQazA9zNz6iwqVAc6Q5Mh7H/5A+J00LljQ2qLc0+To=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BbzHL/2tQE3bWtGnCsU3CCE6V37fveqzOlyRPTvsFEhtMQ6evXj6WJO8oUz71760X
 WmQA+Bu4Vp474eqYLITl+IlLwEn3S067ELQurzttti5a1Plw+JB1L0AxsKNO8Afki9
 DSffLKB6lFDGqAe4dB2PC18YEkzCtwe1Xr6zx1KslYrBSoKu0ywU4tJKxHajfTV7MQ
 uB3kd9CsARI5sYFJJW7137I7CHDhN7qc3Sje6yxklEh/qzUW8ntgxVrNqbWAANti3A
 OLarB5vKDBKzFW0w5OT7VKstYOx6kcxj0U9rPsJxj1MukUgiO4eY7qJ9toebRtJCjZ
 1JQMBPHtGeXPg==
To: jaegeuk@kernel.org
Date: Sat, 12 Sep 2026 07:25:10 +0800
Message-ID: <20260911232510.1816298-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260911232510.1816298-1-chao@kernel.org>
References: <20260911232510.1816298-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x5AcV-0005VY-1g
Subject: [f2fs-dev] [PATCH 2/2] f2fs: rename nr_pages_to_skip with
 nr_caches_to_skip
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

The skipped count does not indicate the number of pages anymore.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  2 +-
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.h    | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1ff9f241085a..a898258f6308 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -591,7 +591,7 @@ void f2fs_write_meta_caches(struct f2fs_sb_info *sbi)
 
 	/* collect a number of dirty meta caches and write together */
 	if (get_nr_caches(sbi, F2FS_DIRTY_META) <
-			nr_pages_to_skip(sbi, META))
+	    nr_caches_to_skip(sbi, META))
 		return;
 
 	/* if locked failed, cp will flush dirty caches instead */
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 49fe48ae823d..fe7138797a61 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3797,7 +3797,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 
 	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
 			wbc->sync_mode == WB_SYNC_NONE &&
-			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
+			get_dirty_pages(inode) < nr_caches_to_skip(sbi, DATA) &&
 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a185b794b7b5..1f023522474a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2270,7 +2270,7 @@ int f2fs_write_node_caches(struct f2fs_sb_info *sbi)
 
 	/* collect a number of dirty node caches and write together */
 	if (get_nr_caches(sbi, F2FS_DIRTY_NODES) <
-					nr_pages_to_skip(sbi, NODE))
+					nr_caches_to_skip(sbi, NODE))
 		return -EAGAIN;
 
 	if (atomic_read(&sbi->wb_sync_req[NODE])) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b77fc79907f8..526764ba31ae 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -977,13 +977,13 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
 }
 
 /*
- * It is very important to gather dirty pages and write at once, so that we can
+ * It is very important to gather dirty blocks and write at once, so that we can
  * submit a big bio without interfering other data writes.
- * By default, 512 pages for directory data,
- * 512 pages (2MB) * 8 for nodes, and
- * 256 pages * 8 for meta are set.
+ * By default, 512 blocks for directory data,
+ * 512 blocks (2MB) * 8 for nodes, and
+ * 256 blocks * 8 for meta are set.
  */
-static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
+static inline int nr_caches_to_skip(struct f2fs_sb_info *sbi, int type)
 {
 	if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 		return 0;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
