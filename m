Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8008C77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 May 2023 10:02:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pusGw-0006d9-ER;
	Fri, 05 May 2023 10:02:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pusGu-0006d2-Re
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 10:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QAlLXmyPGXS4i4+lrCKBZVlQU5pxGZ9Tqil/9eGDbhM=; b=Dx6zD81yYcEz0g/YOr/OVatS8V
 aKDTXLI4hxpPQV0E8BVpcQ0ScCxJexeH7qcF7XbT9YTkMrPQb0p8axkYi7UiEewANb2hnm/jlQPaX
 ezSYHM8L588ay2sU/d8xEPC4i9ZMbNJxytysC7KdAW/vbIJk1u7MsX3Pm7dvkhwKgkW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QAlLXmyPGXS4i4+lrCKBZVlQU5pxGZ9Tqil/9eGDbhM=; b=PfLzgIrgKtwubPasa51gLYK7WE
 Mzb032nTt9Ujl0eocNj8qsIu9rgSdReaSh1SMPllYL955L+Mm2UnLz0YtWER8bHK4mtnJ6Z7S+yzM
 PQH6qh9/VsTao0faVX7Q5ilEr/qZEw+cuI2gs3jIOohJcKNulvLn9XAi72mHVt/npVsA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pusGn-00F8LB-CN for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 10:02:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 000E263D07
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 10:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6983BC4339C;
 Fri,  5 May 2023 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683280947;
 bh=OljGVEJ85emXYstDa5DeLRblnvW4bDVk2devzBiCgxc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TUbvkKhmzEhWnYAS7CTHxkdnbhQLabDx6BtIQYe+zZdsHlS2JxTeDkxM18RSYTiib
 TaMjg5XmNHAtt5OkkXkVLT4rbWE4dQ7yXfwReA/EdoRF/yGcs25jYwBMwfqTnyaPOx
 yEHTxlZB3UOetUJsuNufy1vn8okO5UW43IsiDNVNQ3a0ECjPjr0lqtgpK8bNNDPj63
 UehJPQo7S/XkSnuqwPhC2rkUtzxRhzOLXMONX5nlXWAYp4bzVaOu/UYd/fonHh2xtg
 RADeZJkd8D7P68jmuqQkk+aoaQd7IiIWsVvPiab3/GBGpAi1HjL822GhurRs15kiOM
 zY8/c+rWQWyzg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri,  5 May 2023 18:02:02 +0800
Message-Id: <20230505100205.1921708-3-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230505100205.1921708-1-chao@kernel.org>
References: <20230505100205.1921708-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pusGn-00F8LB-CN
Subject: [f2fs-dev] [PATCH 3/6] f2fs-tools: fix typo in f2fs_inode structure
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

:%s/i_compress_algrithm/i_compress_algorithm/g

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/mount.c       | 2 +-
 fsck/segment.c     | 2 +-
 include/f2fs_fs.h  | 2 +-
 mkfs/f2fs_format.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 2e1634f..b314756 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -302,7 +302,7 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 		}
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_COMPRESSION)) {
 			DISP_u64(inode, i_compr_blocks);
-			DISP_u32(inode, i_compress_algrithm);
+			DISP_u32(inode, i_compress_algorithm);
 			DISP_u32(inode, i_log_cluster_size);
 			DISP_u32(inode, i_compress_flag);
 		}
diff --git a/fsck/segment.c b/fsck/segment.c
index 0307bdd..0ca8b5a 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -633,7 +633,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 		get_node_info(sbi, de->ino, &ni);
 		ASSERT(dev_read_block(node_blk, ni.blk_addr) >= 0);
 		/* update inode meta */
-		node_blk->i.i_compress_algrithm = c.compress.alg;
+		node_blk->i.i_compress_algorithm = c.compress.alg;
 		node_blk->i.i_log_cluster_size =
 				c.compress.cc.log_cluster_size;
 		node_blk->i.i_flags = cpu_to_le32(F2FS_COMPR_FL);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 7ad1c40..dca4cd8 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1074,7 +1074,7 @@ struct f2fs_inode {
 			__le64 i_crtime;	/* creation time */
 			__le32 i_crtime_nsec;	/* creation time in nano scale */
 			__le64 i_compr_blocks;	/* # of compressed blocks */
-			__u8 i_compress_algrithm;	/* compress algrithm */
+			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
 			__le16 i_compress_flag;		/* compress flag */
 						/* 0 bit: chksum flag
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 11804eb..e8c9675 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1287,7 +1287,7 @@ static int f2fs_write_root_inode(void)
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_COMPRESSION)) {
-		raw_node->i.i_compress_algrithm = 0;
+		raw_node->i.i_compress_algorithm = 0;
 		raw_node->i.i_log_cluster_size = 0;
 		raw_node->i.i_compress_flag = 0;
 	}
@@ -1609,7 +1609,7 @@ static int f2fs_write_lpf_inode(void)
 	}
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_COMPRESSION)) {
-		raw_node->i.i_compress_algrithm = 0;
+		raw_node->i.i_compress_algorithm = 0;
 		raw_node->i.i_log_cluster_size = 0;
 		raw_node->i.i_compress_flag = 0;
 	}
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
