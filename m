Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C50EC7EE24
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jun 2023 06:18:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6Q1b-0002OS-Se;
	Tue, 06 Jun 2023 06:18:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q6Q1b-0002OM-F6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 06:18:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k6Qx/xMPr+kzYD1hOe4hVls9Kjx8yW51XQY3FeFSJVY=; b=FPsQjg4Npl0jjxgPq8kB2rzGZG
 o6R2EoXKOla7mqxmxlc0H67S4YiyCpRbp2XJez6Yn/cI9AC+ZSVP8eWX5kltnNLvNxU/dZsmqhAcn
 VYtcNMMKnVZK+CTOFepI9wQKskagxkVsSuvejf/qI43U8PyynTmLSstOGiGzuVMLPpR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k6Qx/xMPr+kzYD1hOe4hVls9Kjx8yW51XQY3FeFSJVY=; b=F
 EMOB9eBfZe6LHu7r9ESb23z4quaAATKq0LxfLkR/nXe+BxHp6zP/5jcXbhFTFFblvJTqeCOD5kiUL
 Cs6JwZfkhaWV3f6qlZ7GHCTXmja36as7AVhdwEndDFqamddkYxfDXDr6Xm8c3utzGz9VRYySZ0smf
 TRb/k+RhIOouciJo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6Q1a-0001Qs-7J for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 06:18:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 90E1A62362
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Jun 2023 06:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE80C433EF;
 Tue,  6 Jun 2023 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686032308;
 bh=CAju/ke6dt0cBKQdvWsNhZJ0D4UzuH6zEahi6D9GmtI=;
 h=From:To:Cc:Subject:Date:From;
 b=EiVnNsPFHFRKQftqEpwmVzgJ8nZeLuoduHTiLIABkpRdCIwY4wWMrnLWpwuMXUTIf
 v1c9yWo2Lrus9JoNN7XOL6Nab9JmR/8/SUGZ+eSq1wOdk698nL0DSKgVA6ob0FH8iD
 kTsC35KqwnBrP9nSKF5wSYEdqU+uObW18F2f4OsFl3rsnmzRpjI2pp9SsdC8DV3sw6
 R7MoB102bJbpGuKKY9ip87gPSk+lTc2PGtEE/03O7JvElEE+m2dypXdaPQYxKeyyGZ
 XO6bD6dLpK7/dtd1sZemwU4trEk/6+wSpsb1EIL9yS2xrPmb5zUlRlgBr1I88nyOr3
 cTSuqipWPiE1g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue,  6 Jun 2023 14:18:22 +0800
Message-Id: <20230606061822.1179551-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q6Q1a-0001Qs-7J
Subject: [f2fs-dev] [PATCH] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for cleanup
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

This patch adds F2FS_QUOTA_DEFAULT_FL to include two default flags:
F2FS_NOATIME_FL and F2FS_IMMUTABLE_FL, and use it to clean up codes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 ++
 fs/f2fs/super.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 35ea9165801e..525381bb6050 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2967,6 +2967,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 
+#define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
+
 /* Flags that should be inherited by new inodes from their parent. */
 #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
 			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6861b255a9a6..5f3e3f328f10 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2782,7 +2782,7 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 {
 	struct inode *qf_inode;
 	unsigned long qf_inum;
-	unsigned long qf_flag = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	unsigned long qf_flag = F2FS_QUOTA_DEFAULT_FL;
 	int err;
 
 	BUG_ON(!f2fs_sb_has_quota_ino(F2FS_SB(sb)));
@@ -2959,7 +2959,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 		return err;
 
 	inode_lock(inode);
-	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	F2FS_I(inode)->i_flags |= F2FS_QUOTA_DEFAULT_FL;
 	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
@@ -2984,7 +2984,7 @@ static int __f2fs_quota_off(struct super_block *sb, int type)
 		goto out_put;
 
 	inode_lock(inode);
-	F2FS_I(inode)->i_flags &= ~(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
+	F2FS_I(inode)->i_flags &= ~F2FS_QUOTA_DEFAULT_FL;
 	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
