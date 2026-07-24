Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62FEC53200
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBTx7UFnzqQx6KkkNRaeYtLflyvezpFCISZ/lBD2pJ8=; b=JwnJyzyXWThQtlhpo5eYfJ4y6d
	YjqLbLVx/+5h1QphT6dQ5jT6OnBPlCoc4b3J1JW5OQwusU+CjmuFrmmVpulxO+KrW3ficV9npj/vj
	L5VXCvQz7VofP5DgSXbG5WJxxo1yfx7nfMaTnPy6/vdkSEW3IO/WJ8rbFevOC/fqXKqQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIDE-0005jE-68;
	Fri, 24 Jul 2026 15:53:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wnIDD-0005j8-9c
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:53:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RRXClAmA0LIjcN+2FQWdyezY6NtMo/f08Qt0QpELKMw=; b=SEla1kZWzfyFNLdxhGQH3nVBW9
 /nyzVEQH7RGSMcOFW6uBeo9ask1F9FJy4xslTBq9s02ijJ68fl/djlYDuDkz6TqSc4ORy9QusSkwz
 qANBC5TDlOTzm4kpQNpCv2JEqJmmsyq2URtcLIoFBKaGlGvJuTxBC79XjgbomrIVuPfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RRXClAmA0LIjcN+2FQWdyezY6NtMo/f08Qt0QpELKMw=; b=Oe9SgLs6TP/K5zISXhh9KH79SK
 g4hEDnwi6RXyLtIGdKWfq8r+OACGHBQ051qkJazMiWuEBilUDl2o8ELZ3dAHttmKwBYghkMFy0IEA
 G+v8kHUTiSoO3IkJP8xmkaFZYhPFbRiCgkqkBlkXxqvmHKLm3U4BSuD4z4chJcWlf3FA=;
Received: from mail-vk1-f171.google.com ([209.85.221.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIDB-0005Fd-Jx for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:53:20 +0000
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c276bfce7eso394132e0c.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784908392; x=1785513192; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RRXClAmA0LIjcN+2FQWdyezY6NtMo/f08Qt0QpELKMw=;
 b=TQ+RQn08tGYXNf1xqwJHqtuc5PE5At0jaw3y3+tN+8BLv92C7rXTL9Ww7pYd3ID2gn
 ex+iX4O+fu2KwUN3A8g5h2weUs3O15EQKo+sTPF7ZZY57mB31PHiRZw7ci4QWJYLKw7q
 a5fdGHUN6yBti+z3oe8XEs7Wp7NXRoNFGlSC8DhOw3rFAHDwGouPXg2ScwrRW38SmcUM
 KoDr56Kvi5cVYjp6k52arUUjsLTL/ZtoIvhH3Ivbkmw3kikpXIYAAk2/feQfQHmWb87O
 GqD0S8bAhHEna0XPcBi3IztOsIMRrO4plMHbwmz4sjcFOoLZx9n4pzgUgUJbPg4pnuAc
 fonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908392; x=1785513192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RRXClAmA0LIjcN+2FQWdyezY6NtMo/f08Qt0QpELKMw=;
 b=nr9/lbKk7cK/yXwy7fULf4U6QCbDzi3wHiKkGTH8StQrvVMBMI2cWJAHoPgIGRpMI+
 vT8zy1QSe+bZsnWJQo3dDVAKXR3aWt+6/ijErB8w4tn+i8GFwthWOafqZLYTQPW0+PUq
 mz9jMd7CYIx2vwGPhUiaCOHjq+0wvKb5S259IFZPS34KVyZZK/Cg+w2W3C/t7MHPwBrX
 dbCM+PEGt4gsC362idey138DtO9lLz07sWOe7KifG8EM0hlbu8+l4A0a/S8PUFZsGPO3
 T9G/jLhihkvEhdRHrLnlOCQE4v4FVrqUBud7AMHgNWKSJxGtatcExvko9CUmCPQC1ePX
 WJWw==
X-Gm-Message-State: AOJu0Yz2RvQnFC3+jcpBmZr52KpaLHZfUWsegZ4NO+jZpPYOOglHvf9F
 lheKvD4uU3aGs40jhnL3eIhwGKjkRm+KCcIBvjO7OArW8dD0CEis3wK7xQPxbA==
X-Gm-Gg: AR+sD13zlT/2M9zB9uq1lebOxqat7BQTshLRGyhGvQxyg0//9IlXnSvaDdeWMT9typm
 eHX6NixoOv8QCc5lCKhPVT6eYa2BgkZz6fgVCyv0rGWrZALnPV9xg1oAlu03F0K8rw1k5EQGFJv
 YOMpiD3p8rxAkPG4/m37vF/JFmoGe5PQyKv8+KJg2I9jmB8ELXV5EINXaN0R+Xu1qt42L8xUnZR
 mhQkOpBjes7ehrUfWkOGz2j2tloBgd8nbepB1sKy5GvdUPdHINAVqqeRMdZzerlhsI6Hk+KAftz
 FuVY9S/gEJt2rqpMJb4aecE6rWXi4Qui0S59PcbNoZOC1NT4vxki7r2EKGUV1aUZuzU8FA/9XE0
 +oKroMuMza/3f3H5YzPHdkI+fVK9zkWU6TYy+E57tICJGGWpFunxqhRbUGHAX9XwkvvWdPFaX5V
 ljgwMX5qvWNGjbXJXy5lpK1HfWipA5otJYixIs8C6yvdSTH/+yjy7pK7BMQzU=
X-Received: by 2002:a05:6830:498d:b0:7e6:f083:130e with SMTP id
 46e09a7af769-7ee43e426d8mr4554732a34.4.1784898016148; 
 Fri, 24 Jul 2026 06:00:16 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a0ad03asm6069433a34.22.2026.07.24.06.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:15 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 24 Jul 2026 20:59:58 +0800
Message-ID: <20260724125958.3929130-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724125958.3929130-2-yangyongpeng.storage@gmail.com>
References: <20260724125958.3929130-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wnIDB-0005Fd-Jx
Subject: [f2fs-dev] [RFC PATCH v3 1/2] fsck.f2fs: adapt to inline extent
 inode layout
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

The kernel inline extent feature has been designed to place the inline
extent area after struct f2fs_inode->i_extra_end, inside the
i_extra_isize region. f2fs-tools only needs to track the inode layout
change and keep the inline extent consistent with the largest cached
extent.

Adapt to the new on-disk inode layout:

- Split struct f2fs_inode->i_compr_blocks (was __le64) into
  __le32 i_compr_blocks + __le32 i_inline_ext_capacity, matching the
  kernel change. i_inline_ext_capacity records the number of inline
  extent entries reserved in the inode.
- Add struct f2fs_iext_header, the header of the inline extent area
  located right after i_extra_end[].
- Update all i_compr_blocks accesses (fsck.c, inject.c, mount.c,
  segment.c) to use le32 helpers.

Keep the inline extent consistent with the largest extent:

- Add f2fs_invalidate_inline_extent(), which resets the inline extent
  entry count to 0.
- The inline extent shares its lifetime with the largest extent cache:
  whenever i_ext is dropped or truncated (in fsck_chk_inode_blk() and
  update_data_blkaddr()), invalidate the inline extent as well so a
  stale mapping is never left behind.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fsck/fsck.c       |  9 ++++++---
 fsck/inject.c     |  6 +++---
 fsck/mount.c      |  3 ++-
 fsck/segment.c    |  2 +-
 include/f2fs_fs.h | 22 +++++++++++++++++++++-
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 497cca0..9b8f34c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -919,7 +919,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u32 i_flags = le32_to_cpu(node_blk->i.i_flags);
 	bool compressed = i_flags & F2FS_COMPR_FL;
 	bool compr_rel = node_blk->i.i_inline & F2FS_COMPRESS_RELEASED;
-	u64 i_compr_blocks = le64_to_cpu(node_blk->i.i_compr_blocks);
+	u64 i_compr_blocks = le32_to_cpu(node_blk->i.i_compr_blocks);
 	nid_t i_xattr_nid = le32_to_cpu(node_blk->i.i_xattr_nid);
 	int ofs;
 	char *en;
@@ -1204,6 +1204,7 @@ check_next:
 					qf_last_blkofs[cur_qtype] = child.pgofs;
 			} else if (c.fix_on) {
 				node_blk->i.i_ext.len = cpu_to_le32(idx);
+				f2fs_invalidate_inline_extent(&node_blk->i);
 				need_fix = 1;
 				break;
 			}
@@ -1332,7 +1333,7 @@ check:
 
 	if (compressed && i_compr_blocks != cbc->cnt) {
 		if (c.fix_on) {
-			node_blk->i.i_compr_blocks = cpu_to_le64(cbc->cnt);
+			node_blk->i.i_compr_blocks = cpu_to_le32(cbc->cnt);
 			need_fix = 1;
 			FIX_MSG("[0x%x] i_compr_blocks=0x%08"PRIx64" -> 0x%x",
 					nid, i_compr_blocks, cbc->cnt);
@@ -1476,8 +1477,10 @@ skip_dot_fix:
 	}
 
 	/* drop extent information to avoid potential wrong access */
-	if (need_fix && f2fs_dev_is_writable() && !is_aliasing)
+	if (need_fix && f2fs_dev_is_writable() && !is_aliasing) {
 		node_blk->i.i_ext.len = 0;
+		f2fs_invalidate_inline_extent(&node_blk->i);
+	}
 
 	if ((c.feature & F2FS_FEATURE_INODE_CHKSUM) &&
 				f2fs_has_extra_isize(&node_blk->i)) {
diff --git a/fsck/inject.c b/fsck/inject.c
index 60a2d20..fa09f1e 100644
--- a/fsck/inject.c
+++ b/fsck/inject.c
@@ -1088,9 +1088,9 @@ static int inject_inode(struct f2fs_sb_info *sbi, struct f2fs_node *node,
 		inode->i_inode_checksum = cpu_to_le32((u32)opt->val);
 	} else if (!strcmp(opt->mb, "i_compr_blocks")) {
 		MSG(0, "Info: inject inode i_compr_blocks of nid %u: "
-		    "%"PRIu64" -> %"PRIu64"\n", opt->nid,
-		    le64_to_cpu(inode->i_compr_blocks), (u64)opt->val);
-		inode->i_compr_blocks = cpu_to_le64((u64)opt->val);
+		    "%u -> %u\n", opt->nid,
+		    le32_to_cpu(inode->i_compr_blocks), (u32)opt->val);
+		inode->i_compr_blocks = cpu_to_le32((u32)opt->val);
 	} else if (!strcmp(opt->mb, "i_addr")) {
 		/* do not care if it is inline data */
 		if (opt->idx >= DEF_ADDRS_PER_INODE) {
diff --git a/fsck/mount.c b/fsck/mount.c
index f7985dc..8c14c97 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -344,7 +344,7 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 			DISP_u32(inode, i_crtime_nsec);
 		}
 		if (c.feature & F2FS_FEATURE_COMPRESSION) {
-			DISP_u64(inode, i_compr_blocks);
+			DISP_u32(inode, i_compr_blocks);
 			DISP_u8(inode, i_compress_algorithm);
 			DISP_u8(inode, i_log_cluster_size);
 			DISP_u16(inode, i_compress_flag);
@@ -2574,6 +2574,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 	endaddr = startaddr + le32_to_cpu(node_blk->i.i_ext.len);
 	if (oldaddr >= startaddr && oldaddr < endaddr) {
 		node_blk->i.i_ext.len = 0;
+		f2fs_invalidate_inline_extent(&node_blk->i);
 
 		/* update inode block */
 		if (node_blk_alloced)
diff --git a/fsck/segment.c b/fsck/segment.c
index 96de22a..2222b6e 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -725,7 +725,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
 		/* update inode meta */
 		node_blk->i.i_size = cpu_to_le64(off);
 		if (!c.compress.readonly) {
-			node_blk->i.i_compr_blocks = cpu_to_le64(cblocks);
+			node_blk->i.i_compr_blocks = cpu_to_le32(cblocks);
 			node_blk->i.i_blocks += cpu_to_le64(cblocks);
 		}
 		ASSERT(update_inode(sbi, node_blk, &ni.blk_addr) >= 0);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1b24a3c..a06defb 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -929,6 +929,15 @@ struct f2fs_extent {
 
 static_assert(sizeof(struct f2fs_extent) == 12, "");
 
+/*
+ * f2fs_iext_header: header for inline extent area in i_extra_attr region.
+ * Placed right after i_extra_end[0], before the extent array.
+ */
+struct f2fs_iext_header {
+	__le32 cnt;		/* current # of valid extents */
+	struct f2fs_extent exts[];
+} __attribute__((packed));
+
 #define F2FS_NAME_LEN		255
 
 /* max output length of pretty_print_filename() including null terminator */
@@ -1079,7 +1088,8 @@ struct f2fs_inode {
 			__le32 i_inode_checksum;/* inode meta checksum */
 			__le64 i_crtime;	/* creation time */
 			__le32 i_crtime_nsec;	/* creation time in nano scale */
-			__le64 i_compr_blocks;	/* # of compressed blocks */
+			__le32 i_compr_blocks;	/* # of compressed blocks */
+			__le32 i_inline_ext_capacity;	/* # of inline extent entries */
 			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
 			__le16 i_compress_flag;		/* compress flag */
@@ -1730,6 +1740,16 @@ static inline bool f2fs_has_extra_isize(struct f2fs_inode *inode)
 	return (inode->i_inline & F2FS_EXTRA_ATTR);
 }
 
+static inline void f2fs_invalidate_inline_extent(struct f2fs_inode *inode)
+{
+	if (f2fs_has_extra_isize(inode) &&
+	    le32_to_cpu(inode->i_inline_ext_capacity) > 0) {
+		struct f2fs_iext_header *eh =
+			(struct f2fs_iext_header *)inode->i_extra_end;
+		eh->cnt = 0;
+	}
+}
+
 static inline int __get_extra_isize(struct f2fs_inode *inode)
 {
 	if (f2fs_has_extra_isize(inode))
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
