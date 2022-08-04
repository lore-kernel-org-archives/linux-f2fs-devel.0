Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B06C00144
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Aug 2022 03:42:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJRkR-0004M3-2l; Thu, 04 Aug 2022 03:42:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1oJRkQ-0004Lx-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 03:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GiOyjfSp2HgfNLOy7osefeeSYulrbMZc2/kJxjQ4/N4=; b=CiAEjh2eUuRd0WO0/ilBfLY7OI
 5fVYpYW7Xen6+vskcbgJ1aCEeEwi1vRw843RjDUcIAQGVE2jlg8jlAYhWvmVwZhEK08j3Jf7Zg07d
 1CroVVRKYGIIHKEQE3jrvm6zT+mwIwAemPY7bMOz6ptItvTyjy9vMsjMOZRPrhHomsp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GiOyjfSp2HgfNLOy7osefeeSYulrbMZc2/kJxjQ4/N4=; b=S
 yF7P3q5t+FZQOwokFKlZ+auU7RIaA7T/pAGo3SKrYVY4jeOlVg7/jmFTzhrJJPEMOYX5BRsgQ60Q/
 T5vNm+GsN+Hze30NPYiCaRVObqKXZa8WeOGcHUVU2cFaBR8+FYUs8E/Rw1Aat4YAZIo3clQFhTKkL
 zqQZqZE8KxvW/mg0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJRkI-002jqd-DX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 03:42:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5044AB82471
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  4 Aug 2022 03:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFBEC433D6;
 Thu,  4 Aug 2022 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659584510;
 bh=S8s5z1x3ID9OVqTTN45HZoXxESI7Zk4SGH+wg8AEPjA=;
 h=From:To:Cc:Subject:Date:From;
 b=ZiqwPPMwnfQ7aY1aeRE5SKLlWmnmo9H9WVkOuDp50PiPuD1JQ03kf44hA8pdYGTZH
 MRebCDpy2rwtSrz3LhwzUaLRRNRB1lnd8TS3A8BrnNGzZjYHyYlxgXED4Fmfcy0ddI
 ywR3AXGw+BdB19oS5DKZksVKiWqP14WSx8uvy7B//HU+oebmTeOH/z/hpXfQnYeC/5
 HAd+lbFIVuJFiN0wHgzJKM3rL6UvVRSL9FZy8oIy/ZwoBsmk21zDoNFcBMfpQarSLM
 QdGngn9ibV5HW7Vs4b5wHYT0OZVsSywK6EODUFlkUkDyZCiV+hrv1g6jKR5s2h9A3U
 5/0v41w5XxVMw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed,  3 Aug 2022 20:41:46 -0700
Message-Id: <20220804034146.3357114-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
X-Headers-End: 1oJRkI-002jqd-DX
Subject: [f2fs-dev] [PATCH] f2fs: do not set compression bit if kernel
 doesn't support
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

If kernel doesn't have CONFIG_F2FS_FS_COMPRESSION, a file having FS_COMPR_FL via
ioctl(FS_IOC_SETFLAGS) is unaccessible due to f2fs_is_compress_backend_ready().
Let's avoid it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 7 ++++++-
 fs/f2fs/file.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4e274c91360b..2f3c4eef89c2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4295,8 +4295,9 @@ static inline void f2fs_update_extent_tree_range_compressed(struct inode *inode,
 				unsigned int c_len) { }
 #endif
 
-static inline void set_compress_context(struct inode *inode)
+static inline int set_compress_context(struct inode *inode)
 {
+#ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	F2FS_I(inode)->i_compress_algorithm =
@@ -4319,6 +4320,10 @@ static inline void set_compress_context(struct inode *inode)
 	stat_inc_compr_inode(inode);
 	inc_compr_inode_stat(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static inline bool f2fs_disable_compressed_file(struct inode *inode)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d2159d6880d6..67e5a6cd25e8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1878,8 +1878,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 				return -EINVAL;
 			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
 				return -EINVAL;
-
-			set_compress_context(inode);
+			if (set_compress_context(inode))
+				return -EOPNOTSUPP;
 		}
 	}
 
-- 
2.37.1.455.g008518b4e5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
