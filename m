Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AEBC3DA42
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:58:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sU0UL-0001bz-MQ;
	Wed, 17 Jul 2024 08:58:18 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sU0UK-0001br-PK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jul 2024 08:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=99eHYmnjq0seIhQvBsUxmPM/OnYYNdnB/TzpmHJycAw=; b=kGSAGNvqhbSrFvM33wbvhtZjKf
 wieIUazSrcS97j4ZROSinQkT2ky5BUJG41RMkTobgRxj6GJ90XmmeDN8V6CAEFK2tsBCycESVc2/a
 TXIAoDdzzaC/n/5cycnq7yiPMfBq6pSEGH/PuA9fOuNcVC/7Yl5JOkDHZbdxCOJ2D3F8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=99eHYmnjq0seIhQvBsUxmPM/OnYYNdnB/TzpmHJycAw=; b=F
 C19W5xliXUMQqQxkg2tbXjj5G7uEgzj6xD7XImZAzgZmaB7yh2x6wXC664ypjbJ7h0U+1NVmKHqjZ
 OXhz91wXApf+ci01hI3oVNDjeVYvEy+U5W0Je+fpORA95fB6VDnCBHxzYO4Mdk80TQSsfO1Jzelgc
 OXD4EEYUJrOxSKGc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sU0UL-0007Vw-FP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jul 2024 08:58:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 59D6B6132F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jul 2024 08:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115C3C32782;
 Wed, 17 Jul 2024 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721206686;
 bh=XSnmKJetw0OG6MWS1hBVcILXW4qUNwhlCiArL8rjXa8=;
 h=From:To:Cc:Subject:Date:From;
 b=iRePZ2Qh1oBESmUcYa6ctpzf8bkpFrztDj8t+0JS9rXfzY7TRz3welNDrAbNfF8O3
 QCCoayYcJkwzlqdv71F6yfs8TEp1DYfdOdulobr/k2B54bLfyGxBvr7mLVSHGR4TmA
 mRBNjOlAtsTuLT06Q1h7YeC//rHRMgrexZAufmp0d0FlvNlJ1N84PUR0VBMl2AJFSX
 iwFZa/+A4+Xvzl8zBTEfoUvvYF+ueAGplIKt7yqZsHp2xOFkdFGhuErVHQ2NFFVAi0
 abtj3I3Vq/hHNNpfQvF1lMbzStO3VFbhcJi/zMHkj2hCIez1InkInEL/reWraYm/JH
 1sIGlhW3rAvkA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 17 Jul 2024 16:58:01 +0800
Message-Id: <20240717085801.2154568-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sU0UL-0007Vw-FP
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix to add missing
 le32_to_cpu()/cpu_to_le32()
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

This patch fixes some cases in where we missed to consider
endianness when we access/update inode.i_flags.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/fsck.c        |  9 +++++----
 fsck/node.c        |  2 +-
 include/f2fs_fs.h  | 12 ++++--------
 mkfs/f2fs_format.c |  2 +-
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 7400dcf..d9e5359 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -924,14 +924,14 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		 * the node tree.  Thus, it must be fixed unconditionally
 		 * in the memory (node_blk).
 		 */
-		node_blk->i.i_flags &= ~cpu_to_le32(F2FS_COMPR_FL);
+		i_flags &= ~F2FS_COMPR_FL;
 		compressed = false;
 		if (c.fix_on) {
 			need_fix = 1;
 			FIX_MSG("[0x%x] i_flags=0x%x -> 0x%x",
-					nid, i_flags, node_blk->i.i_flags);
+					nid, node_blk->i.i_flags, i_flags);
 		}
-		i_flags &= ~F2FS_COMPR_FL;
+		node_blk->i.i_flags = cpu_to_le32(i_flags);
 	}
 check_next:
 	memset(&child, 0, sizeof(child));
@@ -1057,7 +1057,8 @@ check_next:
 		ASSERT_MSG("[0x%x] unexpected casefold flag", nid);
 		if (c.fix_on) {
 			FIX_MSG("ino[0x%x] clear casefold flag", nid);
-			node_blk->i.i_flags &= ~cpu_to_le32(F2FS_CASEFOLD_FL);
+			i_flags &= ~F2FS_CASEFOLD_FL;
+			node_blk->i.i_flags = cpu_to_le32(i_flags);
 			need_fix = 1;
 		}
 	}
diff --git a/fsck/node.c b/fsck/node.c
index 7ee29ac..632151a 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -62,7 +62,7 @@ int f2fs_rebuild_qf_inode(struct f2fs_sb_info *sbi, int qtype)
 
 	raw_node->i.i_size = cpu_to_le64(1024 * 6);
 	raw_node->i.i_blocks = cpu_to_le64(1);
-	raw_node->i.i_flags = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	raw_node->i.i_flags = cpu_to_le32(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
 
 	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 870a6e4..75cbf22 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -659,9 +659,11 @@ enum {
 /*
  * On-disk inode flags (f2fs_inode::i_flags)
  */
+#define F2FS_COMPR_FL			0x00000004 /* Compress file */
+#define F2FS_NODUMP_FL			0x00000040 /* do not dump file */
 #define F2FS_IMMUTABLE_FL		0x00000010 /* Immutable file */
 #define F2FS_NOATIME_FL			0x00000080 /* do not update atime */
-
+#define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 
 #define F2FS_ENC_UTF8_12_1	1
 #define F2FS_ENC_STRICT_MODE_FL	(1 << 0)
@@ -984,9 +986,7 @@ static_assert(sizeof(struct node_footer) == 24, "");
 
 #define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
 #define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
-
-#define F2FS_CASEFOLD_FL	0x40000000 /* Casefolded file */
-#define IS_CASEFOLDED(dir)     ((dir)->i_flags & F2FS_CASEFOLD_FL)
+#define IS_CASEFOLDED(dir)     ((dir)->i_flags & cpu_to_le32(F2FS_CASEFOLD_FL))
 
 /*
  * fsck i_compr_blocks counting helper
@@ -1003,10 +1003,6 @@ struct f2fs_compr_blk_cnt {
 };
 #define CHEADER_PGOFS_NONE ((u32)-(1 << MAX_COMPRESS_LOG_SIZE))
 
-/*
- * inode flags
- */
-#define F2FS_COMPR_FL		0x00000004 /* Compress file */
 /*
  * On disk layout is
  * struct f2fs_inode
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c9d335a..39d2d3e 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1414,7 +1414,7 @@ static int f2fs_write_qf_inode(int qtype)
 
 	raw_node->i.i_size = cpu_to_le64(1024 * 6);
 	raw_node->i.i_blocks = cpu_to_le64(1 + QUOTA_DATA);
-	raw_node->i.i_flags = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	raw_node->i.i_flags = cpu_to_le32(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
 
 	node_blkaddr = alloc_next_free_block(CURSEG_HOT_NODE);
 	F2FS_NODE_FOOTER(raw_node)->next_blkaddr = cpu_to_le32(node_blkaddr + 1);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
