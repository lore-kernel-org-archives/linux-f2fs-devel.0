Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EDDC77B6C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 19:51:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkVds-0002T3-RZ;
	Thu, 06 Apr 2023 19:51:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pkVdr-0002Sx-I5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 19:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hkaXgsIKs/jFo8TH8Q7ZWPVUqbq2tm3gb5uN6r7ZyII=; b=fTeRkDmaUif3xbrVWdRGnKAGIn
 RfvdLMCgx1bu5IGb3iio9ny5EKgUQLHZU/XC4stgqdMkFdWJ6MxVN5kD8Xlgb09Zn5/DWXHwwEayQ
 Gxxf/+9ubUN+erggJXi/hrcC3yjgz0UakCvLNSCKikJThnIjSjmVinv9p5zpNZXnsFf8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hkaXgsIKs/jFo8TH8Q7ZWPVUqbq2tm3gb5uN6r7ZyII=; b=a
 wf0js//z+Wip0Xvfj/Kti3yNrMZC5D+wksPjFSiDRDGBiN7WsxoKHQWyNL9a5ruJQjKoS/c8kQA+x
 KyBn59kgWLWblZSeANwrST333WqMXUXONLI5xiq7h2NjNegrzpbqeVXYG9D68aqcF1PCqqbrvWi2f
 taJ2zWvye/JMxGp0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkVdr-00H7jw-UO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 19:51:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8B81F62CFA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Apr 2023 19:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E4C433EF;
 Thu,  6 Apr 2023 19:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680810686;
 bh=/s7giKfeSIqZNbsqf9X75JHxU9L9jKT2SkAOoZXyTxQ=;
 h=From:To:Cc:Subject:Date:From;
 b=WdcEZbDAhSV3qRTsIEn4xieYPuVjP7x/zfXStn2g84Ui9Hb+mQ2TKHHiNOXoII8e8
 Xo2Xl4XziPGlcqjZMkUvovCw1JnOFz8qvw/svxGiTFv2T/plKwUoQmnCCvlfDiBkss
 PhT4R54hIuXu98K8F1N5fMtLRufzm6YN5e1LksLgTHryki8HxeBE2oflAcHJna6Kea
 E0o48/Hs5A3jrw7YdkPKpFf1s6LRqOSKz5+yq3ego/ms6u+XPzNXn4ROo1crbD/jGz
 il6Aey9VwcJNQYnmctWT4R5E60KdNz+GODVw4W5LbqKSwai9TwKTdMdzNWxYQsu2um
 9mH5Gbtn0AsyA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  6 Apr 2023 12:51:22 -0700
Message-Id: <20230406195122.3917650-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
X-Headers-End: 1pkVdr-00H7jw-UO
Subject: [f2fs-dev] [PATCH] f2fs: fix potential corruption when moving a
 directory
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS has the same issue in ext4_rename causing crash revealed by
xfstests/generic/707.

See also commit 0813299c586b ("ext4: Fix possible corruption when moving a directory")

CC: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ad597b417fea..77a71276ecb1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -995,12 +995,20 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto out;
 	}
 
+	/*
+	 * Copied from ext4_rename: we need to protect against old.inode
+	 * directory getting converted from inline directory format into
+	 * a normal one.
+	 */
+	if (S_ISDIR(old_inode->i_mode))
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
+
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out;
+		goto out_unlock_old;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1108,6 +1116,9 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	f2fs_unlock_op(sbi);
 
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
+
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1122,6 +1133,9 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
+out_unlock_old:
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
 out:
 	iput(whiteout);
 	return err;
-- 
2.40.0.577.gac1e443424-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
