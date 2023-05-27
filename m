Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDC8C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 May 2023 00:15:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q2hb7-0003O6-Sq;
	Sat, 27 May 2023 00:15:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q2hb6-0003O0-Tf
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 May 2023 00:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gv4eDg/T7j2OUXptiiVfiHxORGKRf3vrwJXM0hz8kf4=; b=YABh3a7M/Tuai/kSUN9lnnMIKi
 vxsppN/gg8s1KAdyHzLLO2PLOzfphmDj7TumXHkd7TL8pbjNlk8LzombJSplSX0Lzv8kPz1TkTZ0C
 i0UOfG8LsDMG3w85tYSonjkNsHA0QwiCYtqrCpdHi6SnT8Tf3TrCWUEdXxL6tSwY9Bcg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Gv4eDg/T7j2OUXptiiVfiHxORGKRf3vrwJXM0hz8kf4=; b=E
 hg/Kefo7yW2W0AxaWh5rOS9uIkjNqkmYcLNMMMm6s79TYW6x9yFCVZGSZLZ2wB/K2EOYBqjN+Ta24
 +68WhL7XvwRDvHUdjU/zS8Y2Y4iIkd+jpA8l8vsAH2AI6P+pkLp/3D4C1mam6GqHEWUsMzOneSHJM
 YwqbEvL9YAUkVq2s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q2hb6-003j1v-LT for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 May 2023 00:15:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 45121616B3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 27 May 2023 00:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BCAC433EF;
 Sat, 27 May 2023 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685146546;
 bh=nXYxH681t7TjkG0u6GW5KrdxO7omwjQ0Ovq3C6thr3o=;
 h=From:To:Cc:Subject:Date:From;
 b=nwxA6WUJ0K4VI3RTizZduy9tfa8DiyultCuBcuFgDUNdIMmDshCVqRCMPGmySpeBi
 Ld/n9f6qhWWquEa5YaKAcVvcd88ClDOXkbwJXghDVTcDVPlQLRXs5FQkI12jW22WV0
 cFnBcTmThtUdSYcnKxuw2vPe/+7nABCnDejDr+XkBQ2MvBkKXVsWhhAq/R7bWwsRUp
 5brQXXF4DmhbYBZ92IBxEiehsUQIwKvAIi/16D/RxQnHDhQZZwnGtnKDtpph3RfbOo
 5ZPey+Od7aDsrI/bPF9khHqq3NokKtmq7nNinirF95qWH9Kl8xqoEMEpLEIBlmpaWt
 18hJmF2C4Uc2Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sat, 27 May 2023 08:15:39 +0800
Message-Id: <20230527001539.3608665-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q2hb6-003j1v-LT
Subject: [f2fs-dev] [PATCH v3] f2fs: fix to set noatime and immutable flag
 for quota file
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

We should set noatime bit for quota files, since no one cares about
atime of quota file, and we should set immutalbe bit as well, due to
nobody should write to the file through exported interfaces.

Meanwhile this patch use inode_lock to avoid race condition during
inode->i_flags, f2fs_inode->i_flags update.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- simply check condition suggested by Jaegeuk.
 fs/f2fs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..8eb17cc73941 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2748,6 +2748,7 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 {
 	struct inode *qf_inode;
 	unsigned long qf_inum;
+	unsigned long qf_flag = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
 	int err;
 
 	BUG_ON(!f2fs_sb_has_quota_ino(F2FS_SB(sb)));
@@ -2763,7 +2764,15 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 	}
 
 	/* Don't account quota for quota files to avoid recursion */
+	inode_lock(qf_inode);
 	qf_inode->i_flags |= S_NOQUOTA;
+
+	if ((F2FS_I(qf_inode)->i_flags & qf_flag) != qf_flag) {
+		F2FS_I(qf_inode)->i_flags |= qf_flag;
+		f2fs_set_inode_flags(qf_inode);
+	}
+	inode_unlock(qf_inode);
+
 	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
 	iput(qf_inode);
 	return err;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
