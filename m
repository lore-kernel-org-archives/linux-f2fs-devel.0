Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB546C48260
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:32:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rb6kk-0003jx-70;
	Fri, 16 Feb 2024 22:32:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rb6ki-0003jq-R2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 22:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eogWWGunrScH2e0BmYG++mqTWh/RhliOG8kce8lceb0=; b=gzTVBKTuMSJlxXQHaUNJI78hBX
 DJyXx0vfCCvgkaKu16l+KZKlocxW5V/m7mnCoUXFiIKwSyYTsJUTCR3AuL8BKI9O9nMtQg2SCVn8B
 Sg9eZvTNNHcv5SP4KcY0ABqx009uvAwQYg7sA6cOokGBkq4eShN37Uzt41+yXAETnPZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eogWWGunrScH2e0BmYG++mqTWh/RhliOG8kce8lceb0=; b=X
 3KZ/v8OT9gnsWnDGz7HzW7qi53v98UMCIM6EmJJ2jvlEjXXuzpTSes8Pe1nRm0tpXfnD6PK6ugcWx
 kXL7nPFTd76/FWRISKKmAGizSg1tJcqJpHKcGLlDRSNUSxJWtVNWEUgb/Mfmc4/ITwwdVUOOj4/Um
 xZW1UbeDAIKs33gc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rb6kg-0001Ay-T3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 22:32:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CD7D46207C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Feb 2024 22:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C419C433F1;
 Fri, 16 Feb 2024 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708122730;
 bh=c6HKSK2nlZ4KsJ8exupjfyksGkk+o2n/wAUv5WGdAgM=;
 h=From:To:Cc:Subject:Date:From;
 b=PC+NeT1+C/iDjvmSSQ8T/upGHRveFsAL4W0Ln+vG+fY4WJOP/cyHmpENFfnkFFTxq
 fAqpHVEfOZaywCIDmTxU+q8FXksga+fPeW9U8Xby6hiWhIDR5RAmVt1PYFa3HWm6Pv
 DtsKv69LdufuklA6u+jHz5A7vhoA3lAURB8Ok8tQYYjf45iBOGckyW8YbDDu/hU5I7
 nVy3uofx5NQsip3qd782f82+5LTvzPRjEJF6ih21lo4LrOryuEVdeyqbfVAY6MreYC
 pqShMEdzI9xtW7ZorrVGpAd7/z7lzMzhaUAX8KWYu2fDy5vjLNUysQFelgHdHJU3HN
 F2VKUS5kDQlFw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 16 Feb 2024 14:32:07 -0800
Message-ID: <20240216223208.443024-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
X-Headers-End: 1rb6kg-0001Ay-T3
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix write pointers all the time
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
index 0b3b18715bec..a2b7a5c448b5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4656,7 +4656,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
