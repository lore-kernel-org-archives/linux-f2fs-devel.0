Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFC5C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KebQtDShsmBeNHjLSgiES9/G1wUEfz4qemjc84XPmJY=; b=jnIKKx9mIl70PwVyWUzUS4qEVG
	XTADOfgxYBPNFcswJUurGy0dsrhx5iGpxTeoTAM6ZJYr1yRS+q5VWeKQ9KhkNzb8boMxTlXzhY9qp
	AwQxg34Kz/JQgLi95qkPsO0GoEH73RIRPyNPxvWGP6Awpjzi8QuV749xVDKlXH0qiAQ8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0NBt-00048I-Vz;
	Sat, 29 Aug 2026 17:50:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0NBo-00045J-Pa
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lxs6re5XMINX1YAgGCNMKMyhwD4CCm+XoEwKtl4IBc4=; b=e7iEvjDlTYkV5sTxAckwa2Sfil
 srNUqmFXYX5CX0MdeEg8Pw4Ust+2LQe1lzD0w81DUh0jTGN9sKXtSVzhKsvrRQT38IsRJ+cdaNieW
 kXP0VM1+LHCcw/iRFiOlK8jJqrVcMrj8UeQPbsZuMyVLuuRuug6Mrv7QgtwBXTcjo+SM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lxs6re5XMINX1YAgGCNMKMyhwD4CCm+XoEwKtl4IBc4=; b=A0GXN/wRpewGoaUYiWP3kGF7jv
 OPWvGOsLUlzKRdrBlYb549U6mdsKRHOeXrB6pPzUJjbJV5xhUiNfz3dpbbsOkRZo7FneaJQ9yFyMn
 QnlfAb98HP2ZU0df60hpDgs7oGhnT3YOzjkC3d6YQkORgNORmzh0QyBcNM+N/dVA1Kxs=;
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0NBV-0001ET-E1 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:49:43 +0000
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so3195525a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 10:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788025774; cv=none;
 d=google.com; s=arc-20260327;
 b=UQOJd+G4BrqhqEzht09KKVpZSyyrmKgYoIHm1xnsyq5+K+6A2D3ikqzpeudAPf8NIq
 xVRHNoK3Oc0vQLENgppJtNOlijnV8wZiQl7PkcLghSblI40cAXh8ty34QIiAjNDR917I
 Gme/6x73cZd8g1FkmnH2GJVXnLeFaxJNZU0722xUbDo21tyWhNtlrwYSg7EGGOSVTU5P
 fCvXicrUsdax7etB3de0+Z/IUKYM5gQ86VOOUKgub/4I8ZZ31ojNTiddtu/5GCmgCe9y
 mBbW8v8vJBCxaNv78GN+G/ezZ/MrEY6dnPDrq0vj2fPJ7+OGIGQQXN0PtrE8nW30K5rA
 vYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=Lxs6re5XMINX1YAgGCNMKMyhwD4CCm+XoEwKtl4IBc4=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=ajAb+E1icy1BwwL9OwB+/EK1Vpd6LuBxVNnJdm4NtbbFCenynkxnK0KQuum4nQ151V
 WipRLHdAVbUcYDnk4C8b6dKbuoBUI3yLmJoAUKYCIIdVrWzGQgtWsEa2ES9QoSWMAfjF
 h/6nF/e9fQDYwnN8KRyYple1y9A1bT0M6eWLJ+eH70p+OAeDyEJs+y3S34G2mSa1DXse
 TiPIDxCuzhfRjoFZ1mAA4SZCgYWlXDmr0i2lVAMw7avjM3/rHQoKv7MLg29kFAiYMP4X
 JCVBV70qpTrENc713bIGtkDxXRcl5760sAd8D4jFSVaFLoL0dMwvaywNm/IvIBqF2zck
 QrkA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788025774; x=1788630574; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lxs6re5XMINX1YAgGCNMKMyhwD4CCm+XoEwKtl4IBc4=;
 b=gu5iI/3ToPVmPKL3vCbGoqogRm9AH6rtjyxFU0zbfrkljDDdsTOKutCHgyn5MYJY+3
 qX30WvhDrJcZtG+qfbWb7sXAcOCj14wFZEyN6f1jwipKTHhB0pGLihn9O+hDjGeuF6fg
 083LapJnaQCygqi/BBTKuh425nTAn/j1RD0SaO2VXQNKeS/tM1623ksBYZK1buJL1y06
 JUcHLOBCIcoAysRe4VqTcgcmfSFrurZ+baF/wAWsi2ZpiIvL5G6sPDkV/cyBLh5ndFWZ
 SPaa/lVdx1uULlDx3bGsAvt6rCJFcwXOoA07R/23050oExU0j6U7Ci+kVahd11bUY5AH
 cJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788025774; x=1788630574;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lxs6re5XMINX1YAgGCNMKMyhwD4CCm+XoEwKtl4IBc4=;
 b=OKvBmS/ut+HF1s2+EVebNvlnGrm/qzIfs2gO2ySJU87UR9ZiZoTB2xgl6zVcc8g1rQ
 1j+7Un49KptLUaG5VaATadnSEVXTyTDk10H/T0SDTCqlcYi6moykRKySYUEC0+xQlidu
 yuwOh/XpaYHHqRTdWpPbg4lMT6HifqAWEVHu7xm/P8QnAS/co6qYLYUQC0WZ0Dr4kwhN
 3wjFJfka4zFMEctdHuAo6x3t+FsP1yGKP9j3kw94FSbkQkdYVsj0VPYcWYjRFtrFh51u
 1uypGEt48RqscdLkhBcJcQVZ+62Wuuef1Xd9CXpXHYWuBSuwpfu6YnwGZss7hQR/oaIu
 ozvA==
X-Gm-Message-State: AFuF++m26HQwW8CkcsRyas5o4v02jO1IsACymHsZdwgCFY5Xp9jj1fck
 yF9kpLBCKYtkCX1Rm6CIOX8+ES5ZTY/vOZPkTLZu4MF9NdQfJ5Kx7ZMJTaKBDUwDzFHWq2B/PZr
 zQqMVA/1uFdc7XoSATuQAQdnsLbzhBvep1YUAok4=
X-Gm-Gg: AYBFou2MUgX9AgqcCTS3LQjqySYLjlCZqR1PYEa5TfRqUvlnHDJL70VIs3GrYXhsqZz
 jmEHMtI1VPwldC+KWnO4Neok1fHSf4BVfe6L6wuRwAaMVghxfbkTVeHlYAlMiBO6EJBIO1MObD4
 uRCX3aN0x3R8RbyhAEPqjN6AVIUZrXyMUDRLE6hu97ErR9+v3fpfcT1QV+o9cIoolFOCqA68Dhk
 vOZvu1QloriGj9Y37PZ3Gkf62CGBzdisiWZ2pFpkKVhGrTg2sC73kudgFhO/HhCKC7GE/qMZyMD
 Zetq+dd/FkTRzbJukScgKS/xXpRkPmiVrv1D+4JcC3totKCeUcWOJwa3PNu4Y8YiXBmjHxfjyvq
 5WtVQNaCU8X07pA==
X-Received: by 2002:a05:6402:24d5:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a60d3a7b8cmr7959598a12.13.1788025773849; Sat, 29 Aug 2026
 10:49:33 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:32 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:32 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
References: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
Date: Sat, 29 Aug 2026 10:49:32 -0700
X-Gm-Features: AcwNN1WvMxuhExni0UWMXGddN8jm3UA89aH7som-upGcLpEU6TAEjTgje9k8tDQ
Message-ID: <CAH=xXfFy10WpCebZSsVhoe1gyktix60bWh2a6Y_OVX9ZcdFEYg@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0NBV-0001ET-E1
Subject: [f2fs-dev] [PATCH v2 07/11] f2fs: describe xattr block layout
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
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
 fs/f2fs/inode.c         |  4 ++--
 fs/f2fs/node.c          |  2 +-
 fs/f2fs/super.c         | 17 +++++++++++++++--
 fs/f2fs/xattr.c         |  8 +++++---
 fs/f2fs/xattr.h         | 15 ++++++++++-----
 include/linux/f2fs_fs.h |  2 ++
 6 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fda9ee3bfc61..20b0561fe35d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -337,12 +337,12 @@ static bool sanity_check_inode(struct inode
*inode, struct folio *node_folio)
 	}

 	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE(inode) ||
 		(f2fs_has_inline_xattr(inode) &&
 		fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE))) {
 		f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted
i_inline_xattr_size: %d, min: %zu, max: %lu",
 			  __func__, inode->i_ino, fi->i_inline_xattr_size,
-			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE(inode));
 		return false;
 	}

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e3f594f7bcce..7dabfada1b54 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2919,7 +2919,7 @@ int f2fs_recover_xattr_data(struct inode *inode,
struct folio *folio)
 	/* 3: update and set xattr node page dirty */
 	if (folio) {
 		memcpy(F2FS_NODE(xfolio), F2FS_NODE(folio),
-				VALID_XATTR_BLOCK_SIZE);
+				VALID_XATTR_BLOCK_SIZE(inode));
 		folio_mark_dirty(xfolio);
 	}
 	f2fs_folio_put(xfolio, true);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fcaeaacaab33..3ba4df757213 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -855,9 +855,11 @@ static int f2fs_parse_param(struct fs_context
*fc, struct fs_parameter *param)
 		break;
 	case Opt_inline_xattr_size:
 		if (result.int_32 < MIN_INLINE_XATTR_SIZE ||
-			result.int_32 > MAX_INLINE_XATTR_SIZE) {
+			result.int_32 >
+			MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(F2FS_MAX_BLKSIZE)) {
 			f2fs_err(NULL, "inline xattr size is out of range: %u ~ %u",
-				 (u32)MIN_INLINE_XATTR_SIZE, (u32)MAX_INLINE_XATTR_SIZE);
+				 (u32)MIN_INLINE_XATTR_SIZE,
+				 (u32)MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(F2FS_MAX_BLKSIZE));
 			return -EINVAL;
 		}
 		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE);
@@ -1596,6 +1598,8 @@ static int f2fs_check_opt_consistency(struct
fs_context *fc,
 	}

 	if (ctx_test_opt(ctx, F2FS_MOUNT_INLINE_XATTR_SIZE)) {
+		int min_size, max_size;
+
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
 			f2fs_err(sbi, "extra_attr or flexible_inline_xattr feature is off");
@@ -1605,6 +1609,15 @@ static int f2fs_check_opt_consistency(struct
fs_context *fc,
 			f2fs_err(sbi, "inline_xattr_size option should be set with
inline_xattr option");
 			return -EINVAL;
 		}
+		min_size = MIN_INLINE_XATTR_SIZE;
+		max_size = MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(F2FS_BLKSIZE);
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
@@ -310,7 +310,8 @@ static int read_xattr_block(struct inode *inode,
void *txattr_addr)
 		return PTR_ERR(xfolio);

 	xattr_addr = folio_address(xfolio);
-	memcpy(txattr_addr + inline_size, xattr_addr, VALID_XATTR_BLOCK_SIZE);
+	memcpy(txattr_addr + inline_size, xattr_addr,
+	       VALID_XATTR_BLOCK_SIZE(inode));
 	f2fs_folio_put(xfolio, true);

 	return 0;
@@ -393,7 +394,7 @@ static int read_all_xattrs(struct inode *inode,
struct folio *ifolio,
 {
 	struct f2fs_xattr_header *header;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = VALID_XATTR_BLOCK_SIZE;
+	unsigned int size = VALID_XATTR_BLOCK_SIZE(inode);
 	unsigned int inline_size = inline_xattr_size(inode);
 	void *txattr_addr;
 	int err;
@@ -502,7 +503,8 @@ static inline int write_all_xattrs(struct inode
*inode, __u32 hsize,

 	if (inline_size)
 		memcpy(inline_addr, txattr_addr, inline_size);
-	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
+	memcpy(xattr_addr, txattr_addr + inline_size,
+	       VALID_XATTR_BLOCK_SIZE(inode));

 	if (inline_size)
 		folio_mark_dirty(ifolio ? ifolio : in_folio);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index bce3d93e4755..d9e2c65a1fc7 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -71,24 +71,29 @@ struct f2fs_xattr_entry {
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

 #define MIN_INLINE_XATTR_SIZE (sizeof(struct f2fs_xattr_header) /
sizeof(__le32))
-#define MAX_INLINE_XATTR_SIZE						\
-			(DEF_ADDRS_PER_INODE -				\
+#define MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(blocksize)			\
+			(((blocksize) - OFFSET_OF_END_OF_I_EXT -	\
+			SIZE_OF_I_NID - sizeof(struct node_footer)) /	\
+			sizeof(__le32) -				\
 			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -	\
 			DEF_INLINE_RESERVED_SIZE -			\
 			MIN_INLINE_DENTRY_SIZE / sizeof(__le32))
+#define MAX_INLINE_XATTR_SIZE(inode)					\
+			MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(i_blocksize(inode))
 #define DEFAULT_XATTR_SLAB_SIZE	(DEFAULT_INLINE_XATTR_ADDRS *		\
 				sizeof(__le32) + XATTR_PADDING_SIZE)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f339f83220f2..18a9abaa879a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -15,6 +15,8 @@
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
 #define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for
sector/blk */
+#define F2FS_MIN_LOG_BLOCKSIZE		12
+#define F2FS_MIN_BLKSIZE		4096UL
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
 #define F2FS_MAX_BLKSIZE		PAGE_SIZE
 #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
