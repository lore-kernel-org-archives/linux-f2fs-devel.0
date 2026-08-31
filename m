Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFBDC624D1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+ScV4VfX36FrP3pm1q9uHOFaJNlc+vMhiNy2cVpLo4=; b=dE7FmYbk2JWaW2soCGbsK/rPT3
	VP6qpvFs1IzJ+u1xCmyRyHMaP8p6pklN1XaIC0ezVBFIZ+J0DM2KBDI0iYuu7ELHvmF7Mlblj+OVi
	G6DqEqOOF0tu67ygWyFLvXYLnmFbCy1G80O1hHxPoQ6h7Q1mjean2aEOIEEL1sTb0fJE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Ov-0004c3-Qc;
	Mon, 31 Aug 2026 17:02:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Ot-0004bb-MQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=; b=f4PBBld7c1xvqHS9ASPfDKHoai
 Vtk2UanCQOYBT6OwHSM0M/PZQfVt3/wcjYB9xGgKm0F+swgEqiylu83YbQq7QsjK3g0T8LmjpMKCv
 uEQ74I6QrGEtkA9uDYQRf5G3f8k/IY5CAWKvbIohzKiPpc4WqKFLnknQ03cy9AEp6BHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=; b=lL/0Hkf4UEhhGLmO6lumKG/Gkr
 LK488mjpmOmpS/thIwRHz90jQZRQ71JSjrfOG7fOadAlZmzk8g13C3QCkwm6Aes7kAZKfq5VR4phC
 lPTwH1Tgw2vsYVmgn4Hyqm6uekqK304y9yWqUxrop24CuryUTt5YfI1a6Blgx27q9bSI=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Or-0001P4-TX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:28 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a5e971c970so146705a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195739; cv=none;
 d=google.com; s=arc-20260327;
 b=kBcMTd8C9B9Qjd2YUedlD40ljnrrAEYVEBAWmos8Gy0UdusvhG06y93nbyRlX/C7VE
 CE5loCAfFRS2VcYtwWJinfXoyAczNB5g5bjnTfPvG8G3YbJGDF2QrqzlwGW7PQIb4u7O
 FzKaa9XDZe7nj4Ds67F2vXgmJN8HvxKeYIMVu09JPiL2odj94WMxEP7AW/hTtmXvUxv4
 ZLudu6AgIyPrXvKc5c6YYNjrZptApbdK/ty0MoT+z2fWx02bwxMhsKyFHQ9OS0EXLadt
 u5HazEcnK01gF2wDpyqAvUSmx04SuPZWGsCZ9j99X1Xufth9ggoyoMBrt65MsyZy0ksv
 FPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=KYHZbGkUwB0o2YDGxHOE+nEIteYnPBG18Z8RT/xatkohOwH9rV4+ifsdnLXHrfQZvW
 xFdlofSnOnyZUHX/KyDLwqbi/6ico/pyLqKFUArCicFJ6O/KWApCDEoRsmewTiCHxDNf
 AgGC9Dz7nEizJPIh4oIu4oYiubxoAz3IKSjbBtmzCAO2VPFnRnW2fDDRqFSPS7XJKz1M
 4d3PrIw45oAq02tJJYZILUMF70p/wt9eqyCIZNPED+CyG2U9nANbSHAD4S2qABgerNuQ
 Hd+25bs/DpoTAbVawv1vGUa9pv1Z8sYgtOBUGYPxI47TuequRzLTiVdJSqOSF7na0vrY
 ANyg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195739; x=1788800539; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=;
 b=YdDfq+dqOZzFvyog9SRgc5N4h5vUEemRMgIoBtLZmNyGIkJt9y/nikI4cI9b/ZE4pm
 K9aC7E2XTdeeuDZF1kL8YApmjwHgejamfG97paCVQeJbcUPJFi6btTAhaNBWafDYds3V
 64WsMPyWeeNnyx42cbV3O9sJ3EonfIHHhGDq61Vc+gHgtbMOvqfaRnwZCmU3GdNAMo4T
 pj1BRKNnRsWYe38zPX/fVqKgyvMC/qWkJqPIe1mgGCOjBDAwmx8rirQU2b+oA8EQiTeb
 RiEAmcM757d7SreX+kR9cNM0R0UFyqVveMTqcBh4R2JxTQgs98GdPLeJdeoThOt98ydT
 v8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195739; x=1788800539;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jwk6B4YYUYIOqVo5qZvx9IbKKge2giW/CtwxPziGTg4=;
 b=j1Gup1JmQQjIMMNrGxRv9eLakobN2LMmtwv+VBb+HwQjBH8tU+wpdASLQyXcIxQh+V
 lsdfxCx/sin+k6My/nZR7w0DKCtKhtajS7lrXNylt/UcueBldBCbfbiADS6yOW1bFpai
 5xD5TPuDRDLGkMN1tD6XNlZ8C4kW15qvF2e/82Vd++aBOQRyRRLqWVFjm5HpTZmyO2DD
 VN7abVzbF0K1n1bUsQE6Z4zoyan4h3PEbr4YGccLDeCwydK0lTCCdvmdoL+N6h7Bf+pE
 Yu/A/sccJJ8D3uPQbO6VskQMK3ufFYvySFEBRQs8MiU9tDc/Qs+LOWEcjSF6CIn5YFUa
 dKsQ==
X-Gm-Message-State: AFuF++mh9p6NOMBim5H/p5ku9Oa0jQXzvUETtD7PecEUqEX1Y94Nc9iz
 WNaKfkFfwfgOFS3t6CZDTV5dNMdJTItwuJqMjl+BsHsbTJfmppnOYoxhGkH8RZm+gyOjWCVeSSG
 W7x8mUPOS9Pje64e0j54QI1iT9XQnObDgJgGHKig=
X-Gm-Gg: AYBFou2aXe2OlI6Gw/9czZQlBbvjeM0UBb0BaV/xAL2RRt0GvtDhScI9cwuRtGL97Wk
 UYhJ5hmXXRv4ntAUBQI8SxZShnorEzDI09hCq9h2foxMXFcoBALMNLjSa5dDQmxta/SyCDrS+VD
 dC6CO7YFSBL/1qXonoDqOHmoD2+uS0akcFOfQAQ6mvDAY/PKSdmv8bxr2fKEBvqoPsp1tuSC1U5
 AvKeafBS9AMGPZFj7uPCCYFqgy3F7OtmhR0xzqBNnmkHkd+9n40vR51IPIlOTVRu+/t+YS89AbY
 WLNKLcYFFsmL/SVpcKHuYZbG4O3iydwRwwHeCKuGCh+mOWHzj3QIj0XEjwFRd5NAIcuZp6ji2bE
 YVmJn5mar8qpa
X-Received: by 2002:a05:6402:208e:10b0:6a6:42af:e267 with SMTP id
 4fb4d7f45d1cf-6a6476c3d3fmr4229916a12.4.1788195738918; Mon, 31 Aug 2026
 10:02:18 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 17:02:18 +0000
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 17:02:18 +0000
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
References: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 17:02:18 +0000
X-Gm-Features: AcwNN1VXCt7JAycE5Eb09H9YWziWpb0Dqr0EyzswaSPSvbnqVD98OHRW-c4VFxY
Message-ID: <CAH=xXfFfGM6UrR9EOVGaMcFVrXNm7JSYHCBWidrXj7xkt21dPw@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Or-0001P4-TX
Subject: [f2fs-dev] [PATCH v4 07/11] f2fs: describe xattr block layout
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
