Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9584CC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Mar 2022 09:18:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nUmGt-0003cy-HN; Thu, 17 Mar 2022 09:18:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nUmGr-0003cr-F8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Mar 2022 09:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dti14al2d5zI0IE0wmpsF1JnT03gxOSmLxc1MNySPTA=; b=LelQqhvEJ5ZUyEZOxlMapFXTXu
 xuDncLckAF0ktLOE5lThawEikIOjmf6bjY5r+AHXDnYN1mKjnQ7QO7VcPPeXRvP6RcRqs0+yUj2V1
 caeAcbZiip64P6botqzxSCkytqgVZMPwIMGfl9Mh3Y3C+nXuUcquvXguoxL92AwbG3O4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dti14al2d5zI0IE0wmpsF1JnT03gxOSmLxc1MNySPTA=; b=O
 kTmvftigQ6UO62j7Hyq4L7G/tEK9id6SbMUCCj2TWfPeKFAb0trSAf87ysfq3Fms1aMll0PCG4DvS
 RmGz8yA75XOnavwCcWCDG+ZI6/2z3+jQFSDSs0Ojnr4/J57Nn6EbUqPNxJz67PWEvBjU7U4KZkZSf
 MuIBDavci9nkOHs4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nUmFt-0007sI-3F
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Mar 2022 09:17:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BDF1761682;
 Thu, 17 Mar 2022 09:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09065C340E9;
 Thu, 17 Mar 2022 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647507999;
 bh=ycwRVWQvLfkuIJKDYUhPaC89I0gRNUO7LUP6RS/4T/I=;
 h=From:To:Cc:Subject:Date:From;
 b=fg5KhWdxJH08Bll6b/dfxCr5XjuKyHASMuGVajuWmQH2l3odPWb7mXYZp3rXRn5OM
 vq2WDDJx6/tYJEjl5ILEeV1n2QzWkWEuHVFq40yYGOHvqlGxcw+51yzump3QY7MyuG
 cm9rdAADmr++EuFWLCdORsiqh0sqm2ofIdGsfhvMIRqIkpgZmUyTFbItrLucIv3z0A
 E7nMuh7QjlGWeQst+4MqV+bR4/+ekZImNRJznIWaPCDKfyIU9bxGVlp4eikuwH/12w
 Jb+Eg+tAWpHFA66kTsMhGI1ZZYvD2H3pMut43M3rM0gzwxgpB3S+kdMYrmulV9r1pr
 WV1QMmWeq1DHw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 17 Mar 2022 17:06:34 +0800
Message-Id: <20220317090634.27354-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1nUmFt-0007sI-3F
Subject: [f2fs-dev] [PATCH] f2fs: use aggressive GC policy during
 f2fs_disable_checkpoint()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use more aggressive GC policy as below to improve performance of GC
during f2fs_disable_checkpoint():
- use GC_URGENT_HIGH mode to enable greedy algorithm and SSR allocator;
- use asynchronous GC and in-batch write to imporve possibility of IO
merge.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3016b6354a68..e00b3993e2be 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -589,6 +589,9 @@ enum {
 /* dirty segments threshold for triggering CP */
 #define DEFAULT_DIRTY_THRESHOLD		4
 
+/* count of section which will be written in-batch during disabling checkpoint */
+#define INBATCH_WRITE_SECTION_COUNT	8
+
 /* for in-memory extent cache entry */
 #define F2FS_MIN_EXTENT_LEN	64	/* minimum extent length */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9176597fdf94..08f384b0bd0d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2080,9 +2080,11 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int s_flags = sbi->sb->s_flags;
 	struct cp_control cpc;
+	unsigned int gc_mode;
 	int err = 0;
 	int ret;
 	block_t unusable;
+	int inbatch_cnt = 0;
 
 	if (s_flags & SB_RDONLY) {
 		f2fs_err(sbi, "checkpoint=disable on readonly fs");
@@ -2092,15 +2094,23 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	f2fs_update_time(sbi, DISABLE_TIME);
 
+	gc_mode = sbi->gc_mode;
+	sbi->gc_mode = GC_URGENT_HIGH;
+
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		f2fs_down_write(&sbi->gc_lock);
-		err = f2fs_gc(sbi, true, false, false, NULL_SEGNO);
+		err = f2fs_gc(sbi, false, false, false, NULL_SEGNO);
 		if (err == -ENODATA) {
 			err = 0;
 			break;
 		}
 		if (err && err != -EAGAIN)
 			break;
+
+		if (++inbatch_cnt == INBATCH_WRITE_SECTION_COUNT) {
+			writeback_inodes_sb(sbi->sb, WB_REASON_SYNC);
+			inbatch_cnt = 0;
+		}
 	}
 
 	ret = sync_filesystem(sbi->sb);
@@ -2129,6 +2139,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 out_unlock:
 	f2fs_up_write(&sbi->gc_lock);
 restore_flag:
+	sbi->gc_mode = gc_mode;
 	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
 	return err;
 }
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
