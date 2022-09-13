Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0112BC6FA82
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Sep 2022 07:48:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oY0ed-0000xp-Fi;
	Tue, 13 Sep 2022 07:48:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oY0eb-0000xd-Lo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 07:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y44CpGCdnIWmGhQpnzVyKVN6TVeD/FhPI6sDgDRDfJg=; b=CznKx4veE8EbPPtmIPpV//IV+k
 Lq6vM5BMwagOlg6XhGSuwuPTkEUp+W6TFHuQT4RsdG70QOht6Rbgf/fYhWoqHix25rBp6EgP+6SWR
 axiLLloJTI82DwVk3+xF5MLf+I3ASdZ/AZqeQXjDyGhCCJgexkXGIXkoUr/vO0nKYetM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y44CpGCdnIWmGhQpnzVyKVN6TVeD/FhPI6sDgDRDfJg=; b=O
 o0loQT/zrM576Toq/wJ3t1xveI7gfeKs95XyY/mNkgLdxcrma6f/s8/xR+FSi+UlETlXmma7/S/YU
 CX6CCrWjTsdlz7EoytAjOUM4syro2AHpF1fL34Vj5NKsCsOLrOxDk2niV0Hk/tY/V+Z+iyU0uX4z5
 sOAwqvKCTJNNOyjs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oY0ej-0008D0-UC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 07:48:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D3E6AB80E25
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Sep 2022 07:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FE0C433C1;
 Tue, 13 Sep 2022 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663055297;
 bh=Of/zRCi4LPBlW8V1x2NpTuzZS4rJePo9idcJOEnYoAI=;
 h=From:To:Cc:Subject:Date:From;
 b=k1awtXj5VWUA7HRjnaeNKOernHCW4kLVx01QqRuCW220YsLBxeBVmzEnV4DPx54Fv
 uroA8Q1achGI2lJHwbSR4RgXa2DJ0RX+Gi0A5TvCXjIBmHC7ybBE5JGfU8HSgjFfWZ
 Jmosnzg/L7YlkwtqLF8Hw/t8+UarGTHrg2NwN8aNkxheKx0J3g3MBtUjCsKGYMf1o1
 NPt3TVLWoF8T1DkmN802WNmIREaU1r8xt+Fg8RurBbSYJ4FWUrvR9aOw9cg+t+W6+B
 FFGJBdvHVrGqPRJgBkqfPseERRxVv12qWob9k53huWnW4BqIJOthsw5DVXL2FvJ1Hh
 krdAL5vLXXd9A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 13 Sep 2022 15:48:12 +0800
Message-Id: <20220913074812.2300528-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oY0ej-0008D0-UC
Subject: [f2fs-dev] [PATCH v3] f2fs: fix to detect corrupted meta ino
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

It is possible that ino of dirent or orphan inode is corrupted in a
fuzzed image, occasionally, if corrupted ino is equal to meta ino:
meta_ino, node_ino or compress_ino, caller of f2fs_iget() from below
call paths will get meta inode directly, it's not allowed, let's
add sanity check to detect such cases.

case #1
- recover_dentry
 - __f2fs_find_entry
 - f2fs_iget_retry

case #2
- recover_orphan_inode
 - f2fs_iget_retry

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- update commit title/message
- change logic inside f2fs_iget() rather than its caller
 fs/f2fs/inode.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cde0a3dc80c3..1baac6056733 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -487,6 +487,12 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
+static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
+{
+	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
+		ino == F2FS_COMPRESS_INO(sbi);
+}
+
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -497,17 +503,22 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_meta_ino(sbi, ino)) {
+		if (!(inode->i_state & I_NEW)) {
+			f2fs_err(sbi, "detect corrupted inode no:%lu, run fsck to repair", ino);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			ret = -EFSCORRUPTED;
+			trace_f2fs_iget_exit(inode, ret);
+			iput(inode);
+			return ERR_PTR(ret);
+		}
+		goto make_now;
+	}
+
 	if (!(inode->i_state & I_NEW)) {
 		trace_f2fs_iget(inode);
 		return inode;
 	}
-	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
-		goto make_now;
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (ino == F2FS_COMPRESS_INO(sbi))
-		goto make_now;
-#endif
 
 	ret = do_read_inode(inode);
 	if (ret)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
