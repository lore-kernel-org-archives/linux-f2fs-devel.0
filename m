Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBCBC61DE8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+ScV4VfX36FrP3pm1q9uHOFaJNlc+vMhiNy2cVpLo4=; b=jY+G0ekktaNAmMREknSxyLvTlm
	UcvnpKKhloW8F79xDc4AzaU1IIxMKKzCs8NzN0wKjH1Dqiy/pnHAW007DAsz5qVmkx0riv1diirXK
	epnZ8QWbYJR432qbK7OJAnA2BioRG50XQl8yBjbnXm6CqCxUSl+EngokXyIBdi2X8PLk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0udz-0001lu-WB;
	Mon, 31 Aug 2026 05:33:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0udy-0001ln-Ml
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=; b=Juh+a5OfNW+oaQpsGcT7JgmkA1
 kg/JTFyl4WlpHBq2hbfXC4zzPOrEWXMrjSYO/w0VR25P2fyp5uWy2ZA7rLC40ErI87vDnDXZ7Mecc
 PqgFUDqtPzbHyMY1ZtSRc2101aJacC21ZX2j1/KiDruyb8eEhbxqv1ykc6DX6fuG2KKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=; b=ZzZyr4wx1u+m88942Ulq8nARVa
 QTLijqcZ+OCe3XiMP4lcJvozYy6BQ1rVEAjVtPESzgAn/TE5mCy+6GlVEN0VsDe5EEM17VAOvfpMz
 WyzL+hGFXWjXUZsckFS9iMzpuSBbme1L0Ro86wUrW3yzumAx/YgSQVjPgzOCrx3rlyGc=;
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0udx-0008AG-R8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:19 +0000
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a63667b78aso2091001a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 22:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788154391; cv=none;
 d=google.com; s=arc-20260327;
 b=ecXOGfP0sL0jFIhT0gsbcYQLnk2GH/igrTsYeqPuclYXVIwA2doXUR73AZgnomKOeC
 P4M/h7+OGDeYF/dzpsFhoEq7YTliIx9YNt8eVSTyv4NL9xxRLDPfQDqtlIM1riIF9Kjq
 BixI2u2tietM2kiNRB7K/FZKgAoNC0Og/JRzXYSn1FK9CJTtRLohhkz0M6/vYdvJnrKu
 epfTxwheTgK1wr1+cRDsgMhpkkFPbHIBY/BJ3bdkirVXTRJRMQAgDpS/FBo+JFRwUkJM
 WW31Nnawk9HGL2nAKSAvC53ekviZZz76XqA+m0S/BapV+Yi0Spdhxt/E92/jPQDLn15Q
 ecow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=CHIYi5fP3jX45UyQ0zhzR+Zpftn/90efafmrpt1W26Fb5DToZa+DhCr3mzcqQdJ3dv
 j5ODRbOvgz1SFcSFDVCCPpzpN8rf40eNcpdx9DHGu764ljVWZ5a5CO2sTXsIlbRHygXv
 QiFmuEMCr/gVimEe/cJcmR4CXzWE6HmENCXT8t2C/eZboo9rwIaCPVMxWEJMHCpiChxk
 7ZXIewZEGeeVHC1gO2duBG8YbaG3i4bGGvPna9xxRdn37rbavKRRSYgh9c6s7Z0L3z4K
 BsyLi5AuRxfCcmGD6DanViU4ZXh1VFiR+j1IoZVxvnIlBuE7GUTMeNUC9UFKp1lcG38q
 CteQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788154391; x=1788759191; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=;
 b=FvQhr5caLIsW2G81K0HYkRjZANp+Asi+HN14X7GYvuXRVdLiB18Td8w1eR7Ho/2oCp
 TtztzHc7n0WrFggDrDSE7bLC1B9t4PcBsGm2y0RajVVjgi/c/BxFN5ltKaKULIww8bPa
 UBAEocizVjupeOWPzsef/VUg9GuU8fe28P/fuIvRVlTx4zi3ddrdQso59U020+tt6a9N
 ieo+ifoatcPnA/+8O441sNYJXijVzjBQJwFDudV9k5MRkXGLBg35A6WKHrTcNC82+E7b
 BSFau+UQdnYdsbQs1NE0ulT3Pi4M7tNpAp8efCGxQaBK3/+6TzPRI6Xz14NRcHQ9lWh0
 Icqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788154391; x=1788759191;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=;
 b=KQY4AN3tEG8DK25CGBzDjEArIpKq9q/5aKb8Q+m35vKhb5ToC4oMQZH6ebnID+1gjt
 EfpZoDJzl7NtLXfkyCs/uBQtCCau/qnztgjT3AdPkpjrEL3BYypMXy3Pxs/ef3JvqkIE
 gOuHVs0imx9QiQW06xTb7IYATvys5Uc2MAYgelkLlK7xPyBkmik2n76xMbE1GNSPEkZV
 FyjabMwW785Z3zssy2pQKkp59p1Up9TGUQpNblVMjqWm1rPknlyqhV58p54sI8AsuugH
 bIzF179l775fN1hH5T2JsjezbCOtBpLCQLljLofyqVVnqErBAobqutdZlSgQ83XpumxQ
 Vhdg==
X-Gm-Message-State: AFuF++lSBedVswWHNObpZwQ1t2J4eF/oJNf7PgwF/RW6lHnf/q1ycWpJ
 UuVMl2rYZfCw+DuvKcLWjaxAa0L5UCXU0JVQrwMCLz8IwwwhX3kJwRNq1TLu2W3RSQmb6C3PWab
 uAXu6kgV2uyoP16ibKUMXi/CWRR+WY+xWpqU/k8c=
X-Gm-Gg: AYBFou1ozPYYlTlLW1D9NmZd0wK/AKGnH+z4UuQAp266LABiD/U3t2xKckJA/mppOF3
 JMehmSHm1BO8F4PQrKbHaGKej1TFPNCTmfGZyQk4zi37p0Oodsb1eiFXyOu2nBlkC8KXiLUKTCV
 EeQw0ep12VWkw1Wz1yK2cZ194GYNaYphwkeZ2432rnzKU5x3sGY33kyEGRZe/tyTZ1M1LwjQctC
 y2h0Ce9rFoRh3kgagymnMyGXKCN26f6hNaQ/+aSIucInTcpyCe37Pbmv/kLL60dsinZb+FPSG7B
 hfQPtdCJHUtN4Zmp9lUGvEoLQqZ8bmj2MLHYomZ7wgDYBCsf8HPJizDN0sgrDlInaJBgiE4yaFu
 hLg==
X-Received: by 2002:a05:6402:4516:b0:6a5:f815:b15c with SMTP id
 4fb4d7f45d1cf-6a60d35b3a7mr13632777a12.8.1788154390963; Sun, 30 Aug 2026
 22:33:10 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:33:10 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:33:10 +0200
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
Date: Mon, 31 Aug 2026 07:33:10 +0200
X-Gm-Features: AcwNN1Uo2oI1NwLHCU4M6vU3nL9b7_WJhuDJVf5BIQ9FwbURqYY8LcyVVocFuGE
Message-ID: <CAH=xXfGz3raKSq2WPcDO-qN=pPXbxT7KhGG7=DDB-Qo=n+aK7g@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0udx-0008AG-R8
Subject: [f2fs-dev] [PATCH v3 07/11] f2fs: describe xattr block layout
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
index 3d0fe2c78e12..d4151970ae86 100644
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
