Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40238C5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:55:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rdcaE-0002Wv-T8;
	Fri, 23 Feb 2024 20:55:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rdcaD-0002Wp-C0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Feb 2024 20:55:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d6MvAWa8krcr3w/taXqtwCdQET9wq8pEdAb3QBFq3EE=; b=ZkmzQSc4D0u6JlV+rgjPHhvw7y
 gDGDVIyvs9hLntV8624Frkx0d+swY3wY9ypui1lNgORL48XVAs+/Dy6aZyU+UFh05Jaz5BxXFNcfh
 Mr2pZzY47XyIFRCiJ5OrEPwr3ImjXwM+eL3A2gLN+G6FWwsraIKF3hIvwN3ZRJlt4i9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d6MvAWa8krcr3w/taXqtwCdQET9wq8pEdAb3QBFq3EE=; b=by1vXPpKUUhMGAQI1h3jTqY+vM
 41bw2sRYaAJrsDgALoK09JvS6EX/RU/zuqA4o0E/XDwcmWfqo+NcoZnQtsWVhSZjsvWxvbrgrIOIk
 TDFwOdiRe827nyIV7ggqMcZC6jFbttTjKLvd0P74guLi5/CycZkgtbgKOcQ3P99U1xzQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rdcaD-0002pQ-0x for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Feb 2024 20:55:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3027E6179A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 23 Feb 2024 20:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8180C433C7;
 Fri, 23 Feb 2024 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708721737;
 bh=1gKonBQkHb/HxNH0cWOVYXamRfmS4ibjq2hXF1LjSXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JDztIDUMIf1uQI3wEPns47jCdJLcgDmWlGKrDDrzZPfvjYREA206ffnpHXWjr8NoN
 1E1L3M677M9HaICSVu7GqwVPSS0gBAJkgule8HcadYMs8pialTn+Oo59lqQIw+vNwt
 jlouFmp59ZghxaJN2TnlEmF9erPZoJdfJL1XuhrJta4b4DScZ/tzkwLJpZkDE6I535
 CD13j4vOBtp9MiZRkcEfbc55lmB4jw/WP7M+TGrHxTipMhogw6jCdTPeHtSXsj5Px7
 EFFF6vjgT6aRfcTQ6HtUXZSNtISV958zN2YFFGwIb9ps1emAkvT8ilyeI18ouCpGSW
 RDSSuPrZGO9AQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 23 Feb 2024 12:55:32 -0800
Message-ID: <20240223205535.307307-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rdcaD-0002pQ-0x
Subject: [f2fs-dev] [PATCH 2/5] f2fs: fix write pointers all the time
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

Even if the roll forward recovery stopped due to any error, we have to fix
the write pointers in order to mount the disk from the previous checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 +-
 fs/f2fs/super.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b3baec666afe..8bbecb5f9323 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
+	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
 		if (!err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2e41142d07c0..4d03ce1109ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4673,7 +4673,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
 	 * check zoned block devices' write pointer consistency.
 	 */
-	if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
+	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_check_write_pointer(sbi);
 		if (err)
 			goto free_meta;
-- 
2.44.0.rc0.258.g7320e95886-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
