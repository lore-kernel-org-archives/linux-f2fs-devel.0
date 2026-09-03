Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB98C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LRCBQvR2JUj++tLaTvrXeVSiHJkevkbRgH9IZYAaK0=; b=jlGpDYkI9OiUT6NvlhAkKCBc01
	dir7n2TTY73K6yen+qiazQ4kWGTI+LhPy2rFffLmYF2J6sS9kTl7yPwrXnkpbMR6bz0i9cQT8GTWF
	WPm4J+o7AKhKTrRyaGID3jdddHM8Ao+pyQb08FD/spBTFAuMR+yMtnpqbp9wsvqhTYME=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2HIr-0004DB-OZ;
	Thu, 03 Sep 2026 23:57:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2HIU-0004BP-4t
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j1HQbrF7PkJ6PeWLX/CZqb0BIOhOO4tfnaywHDSdkZ0=; b=NSJTnd/jj5W4bpWpyRUFncj0z8
 9msAuhPgcflR75a5i3uvMLb68BwaxIV+shOLChtb69nixlZMd+Tvf+WuSpJukG4z2eHZPsrIootVx
 VgBAe/sQD9ORIibhonlyc8sN1kXWJg1REDQaADcPPYMNQTW27FdpdNjiZo7iJZ2Pljo8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j1HQbrF7PkJ6PeWLX/CZqb0BIOhOO4tfnaywHDSdkZ0=; b=P6E6XCeNDtuykFMbBb6DHQv2KY
 Lwpsak1tie5qtC3hg9Gyrub+c04HaXpEvwDHjSjQEnGwcnokoJAk5fu5u4v2obxXYi3UNtzJ/Nqbt
 a6ofYAxQ2NQXYmZ5TixDna1sHnVFHmyhb2gXXXA8W0EE9fei7XGXwvW5dTrORfECaFoM=;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2HIN-0008TW-6E for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:39 +0000
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cf452def93so15167735ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788479793; x=1789084593; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j1HQbrF7PkJ6PeWLX/CZqb0BIOhOO4tfnaywHDSdkZ0=;
 b=BV5Iz0K7AK6iDGFuCNUdExbDN/Bh1qOnzQK68ikzeuK33ZGDZlHgNXBRNaJL60GitQ
 sKxqIl9QmNLLJKHsFhQSct4EoNmRIHqXYq1Wc0IpaMvdNw/FKYhzFaEiOCPJ1iG9ONfz
 YfaYEY7MfzeavEQUGeJGSiF9gibJI+h8H/Tanl1xaZJxrVRgDCv3Vr6zaIAWGX+xqh3/
 OsDJ3ly9g1tS3lrM4lDdKcpaKkSmVMVeQ64gOQS4PJTFBMEIkKKtILlnlbmlYqwTt2uK
 xid11ExkZGCGML52qnuEH1HagdpDAqG4vApV7mz2G0IAtHUJwHy6RkI+7PiuplLlDlfU
 NSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788479793; x=1789084593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j1HQbrF7PkJ6PeWLX/CZqb0BIOhOO4tfnaywHDSdkZ0=;
 b=RMBroHXRts6ZzYFbGfEzv7NzyM1GpqammbKAgDHo6+qd6sYqMRka7In9XpvAdCf53o
 edU+HsGF3mBy9JOmdgutu8uYjl42KOhRMphq8VlE47PTGU4fRKzOy1B1IEz5r5nl55c2
 rWcvmUs5sm4SdB7w1XfBJK+ZKpox1WxrxOgSYEGHCBtsn3HxYlf4Is7iNykZigO4bGF7
 zn/JWI1OYw7ng0Q2vf33vkribtXN7n7+iOwGOff2k+13lEtI0Ts2+n24nPkVlhlgFT2u
 rsTBz6wNxVvgsdRzFBUsQCzqrO+gCJp/5zAsEA3QtJnDb9g0qk7A9bCjmnIfljvdm4P1
 ltwQ==
X-Gm-Message-State: AFuF++mtRZhInG1rHv/fGOMq5qxU0gojIPknbeShmC3jxyinI8A+yt9x
 dSVpxeRNt5qqpefGaB11/Ak6bkU12MKB44coRW1t/QUd4q+1Qhf0btMXExSq++J1SE0=
X-Gm-Gg: AYBFou3YR0NLxARovpd53NEhJveh0oRk9TDpbZ+Po4aWVGqo4zaMrew1qmUIDkVfjZf
 el1xWNfczMOoJebGbQ+VeZzwCXHv38khf59HblZj3yzF5XGkeDY3/uCGMSr48JozWGOSm/MGJkC
 5Vb9Ou+Cfqs03Qr8wXLWaNZAXGXj/TgR9hlX/5M8ZxxWof6yfiN01F2KjhIInkcK4LH/yprMRBq
 Kt9uLL10geLMWDbZJgAH5G9NGW/qvNtU6Zc61kIJQOzSSQbM1WNTHFFlx0VjWDHP2G7LIks/tmj
 bOxmM2V40yXoDL5rkSt8rbSSWCBF8VjJd0OYBW/quNzDz+ssnopq7rpRd2A61DocIRank5HTtTL
 r6WQ9ybCi1H4sly6LPl7fzbEy5O+/QTe6pRxYx1eE8pcsYEKWg/559OnkRBmYhui+9p7CK232rS
 jDLDMUU/1sHHgo5Wk6n2SPQbsu7M93WgkayIGM8ZZJZqoBEVzhTaQlB+uUMV1shz2+Pw==
X-Received: by 2002:a17:90a:e183:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39b07f305admr9839298a91.5.1788479793441; 
 Thu, 03 Sep 2026 16:56:33 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm3077063eec.15.2026.09.03.16.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:56:33 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:56:19 -0700
Message-ID: <c7005ebefcad46d6a0bf3b0653fbd3692b86a360.1788479509.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788479509.git.zhangxp1998@gmail.com>
References: <cover.1788479509.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2HIN-0008TW-6E
Subject: [f2fs-dev] [PATCH v9 07/11] f2fs: describe xattr block layout
 dynamically
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The usable capacity of dedicated on-disk extended attribute blocks and
inline xattr regions scales with the filesystem block size.

Parameterize VALID_XATTR_BLOCK_SIZE and MAX_INLINE_XATTR_SIZE to
calculate usable xattr limits dynamically from sbi->blocksize rather than
hardcoding PAGE_SIZE or DEF_ADDRS_PER_INODE.

Update mount option consistency validation for inline_xattr_size to
evaluate allowed boundaries dynamically against the runtime block size.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/inode.c         |  7 ++++---
 fs/f2fs/node.c          |  2 +-
 fs/f2fs/super.c         | 17 +++++++++++++++--
 fs/f2fs/xattr.c         |  8 +++++---
 fs/f2fs/xattr.h         | 11 ++++++-----
 include/linux/f2fs_fs.h |  3 +++
 6 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fda9ee3bfc61..79c0a1301996 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -337,12 +337,13 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 	}
 
 	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE(i_blocksize(inode)) ||
 		(f2fs_has_inline_xattr(inode) &&
 		fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE))) {
-		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %lu",
+		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %zu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
-			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+			  MIN_INLINE_XATTR_SIZE,
+			  (size_t)MAX_INLINE_XATTR_SIZE(i_blocksize(inode)));
 		return false;
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e3f594f7bcce..7dabfada1b54 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2919,7 +2919,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct folio *folio)
 	/* 3: update and set xattr node page dirty */
 	if (folio) {
 		memcpy(F2FS_NODE(xfolio), F2FS_NODE(folio),
-				VALID_XATTR_BLOCK_SIZE);
+				VALID_XATTR_BLOCK_SIZE(inode));
 		folio_mark_dirty(xfolio);
 	}
 	f2fs_folio_put(xfolio, true);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c1d76674ab7c..4c95229ac3f1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -855,9 +855,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_inline_xattr_size:
 		if (result.int_32 < MIN_INLINE_XATTR_SIZE ||
-			result.int_32 > MAX_INLINE_XATTR_SIZE) {
+			result.int_32 >
+			MAX_INLINE_XATTR_SIZE(F2FS_MAX_BLKSIZE)) {
 			f2fs_err(NULL, "inline xattr size is out of range: %u ~ %u",
-				 (u32)MIN_INLINE_XATTR_SIZE, (u32)MAX_INLINE_XATTR_SIZE);
+				 (u32)MIN_INLINE_XATTR_SIZE,
+				 (u32)MAX_INLINE_XATTR_SIZE(F2FS_MAX_BLKSIZE));
 			return -EINVAL;
 		}
 		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
@@ -1596,6 +1598,8 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE)) {
+		int min_size, max_size;
+
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
 			f2fs_err(sbi, "extra_attr or flexible_inline_xattr feature is off");
@@ -1605,6 +1609,15 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 			f2fs_err(sbi, "inline_xattr_size option should be set with inline_xattr option");
 			return -EINVAL;
 		}
+		min_size = MIN_INLINE_XATTR_SIZE;
+		max_size = MAX_INLINE_XATTR_SIZE(sbi->blocksize);
+
+		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
+				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
+			f2fs_err(sbi, "inline xattr size is out of range: %d ~ %d",
+				 min_size, max_size);
+			return -EINVAL;
+		}
 	}
 
 	if (ctx_test_opt(ctx, F2FS_MOUNT_ATGC) &&
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 6728d1488cad..99c863513725 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -310,7 +310,8 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 		return PTR_ERR(xfolio);
 
 	xattr_addr = folio_address(xfolio);
-	memcpy(txattr_addr + inline_size, xattr_addr, VALID_XATTR_BLOCK_SIZE);
+	memcpy(txattr_addr + inline_size, xattr_addr,
+	       VALID_XATTR_BLOCK_SIZE(inode));
 	f2fs_folio_put(xfolio, true);
 
 	return 0;
@@ -393,7 +394,7 @@ static int read_all_xattrs(struct inode *inode, struct folio *ifolio,
 {
 	struct f2fs_xattr_header *header;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = VALID_XATTR_BLOCK_SIZE;
+	unsigned int size = VALID_XATTR_BLOCK_SIZE(inode);
 	unsigned int inline_size = inline_xattr_size(inode);
 	void *txattr_addr;
 	int err;
@@ -502,7 +503,8 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 	if (inline_size)
 		memcpy(inline_addr, txattr_addr, inline_size);
-	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
+	memcpy(xattr_addr, txattr_addr + inline_size,
+	       VALID_XATTR_BLOCK_SIZE(inode));
 
 	if (inline_size)
 		folio_mark_dirty(ifolio ? ifolio : in_folio);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 7cd7ce58334b..75beab2d1ee3 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -71,21 +71,22 @@ struct f2fs_xattr_entry {
 		for (entry = XATTR_FIRST_ENTRY(addr);\
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
-#define VALID_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
+#define VALID_XATTR_BLOCK_SIZE(i)	(i_blocksize(i) - \
+					sizeof(struct node_footer))
 #define XATTR_PADDING_SIZE	(sizeof(__u32))
 #define XATTR_SIZE(i)		((F2FS_I(i)->i_xattr_nid ?		\
-					VALID_XATTR_BLOCK_SIZE : 0) +	\
+					VALID_XATTR_BLOCK_SIZE(i) : 0) +	\
 						(inline_xattr_size(i)))
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
-						VALID_XATTR_BLOCK_SIZE)
+						VALID_XATTR_BLOCK_SIZE(i))
 
 #define MAX_VALUE_LEN(i)	(MIN_OFFSET(i) -			\
 				sizeof(struct f2fs_xattr_header) -	\
 				sizeof(struct f2fs_xattr_entry))
 
 #define MIN_INLINE_XATTR_SIZE (sizeof(struct f2fs_xattr_header) / sizeof(__le32))
-#define MAX_INLINE_XATTR_SIZE						\
-			(F2FS_DEF_ADDRS_PER_INODE(F2FS_BLKSIZE) -	\
+#define MAX_INLINE_XATTR_SIZE(blocksize)				\
+			(F2FS_DEF_ADDRS_PER_INODE(blocksize) -		\
 			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
 			DEF_INLINE_RESERVED_SIZE -			\
 			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bec31591b398..e98bff846b23 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -15,7 +15,10 @@
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
 #define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for sector/blk */
+#define F2FS_MIN_LOG_BLOCKSIZE		12
+#define F2FS_MIN_BLKSIZE		4096UL
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
+#define F2FS_MAX_BLKSIZE		PAGE_SIZE
 #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
