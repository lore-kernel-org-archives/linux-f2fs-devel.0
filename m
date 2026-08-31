Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDCEC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESQPfazKtjii/SKVSK6tBy2ZoGNCG1rUv9+UKayHatY=; b=SI3N96q4/Fp4arn5oLCQA+sjrC
	Nb8TwTdTk7AqmfxgIT8+LbaiaN9lSaM1HdhuM1Scy3jlE+vMmpm0sd3bORstmrHRwZHMt8y8pb5Km
	GMoV2JWYDiesBDrjPtGZT8PAR8YWNuEkyVS6ddJoTocHl3JVOtijqX7apqSyeDbSJkKE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0ue5-0000sd-NP;
	Mon, 31 Aug 2026 05:33:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0ue4-0000sL-2n
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+xPiXuwsOTRL3JNx7wAokgncqkI7ZPy08oFiV3kG4YI=; b=Myi9dZ1z4rqL6r7nFl+3rBm1vB
 6Tp+D9McXooSCuzt7+LsrOpOoHzRUOFKnhBwI6aG5kwDj10g8363PngDWTqTLFNkJtAhssRZGCnI/
 DuOhqlruFyUoNGHTnJY3MXuQ7ZsyaIhZYQgtamu0P4nkkhC1M645NL1IbgQqrpK+TL5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+xPiXuwsOTRL3JNx7wAokgncqkI7ZPy08oFiV3kG4YI=; b=KZKt/35k83+BluMKHg4dYcttyq
 1CITNtq4rfE6HrZXIdQFzxTtNJmvdofghIxK3jnbd0xiM+mk+08DNVaWRd2TysBwV37++3LSj99t4
 u66JnjtFYyRBsKtdpbBtHu3NLZrnzhk4zCHA4VqeBT9H4MSsGGWf8aEp2quUKQf8GSt8=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0ue3-0008AT-7z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:24 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so4711299a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 22:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788154397; cv=none;
 d=google.com; s=arc-20260327;
 b=lNyM6iYLZYpUyFbg2Xf71mbiX8gm3lGiVOe/BEa0WJd9KWJ45pDNap4UBV+2SapZO2
 3x8iTVlkB3DIu3dZYN1aQrJhUVb5JQ7SqzM+HGKBdDZu7G40Vg5sXG4NsVs6ghNCtOmU
 f5Hx+ERLh4+zaxwv/NzJaFVHqR6B2PmgAMW2gcpuAVLhb80ReM3OJQoAR8kgrurGIMqX
 i6+R+DRSEhfgXq13gKvSMMT0wS+JQLdjRk+YlTCOZcbiehzogMRpBioWUBiT8e6Yf6Q2
 1Sa7y8fw/8CiB24rSYK/dGuG/m7dHEarZbsQ0/DNfEGYWsQrIvf6LxtysBnKrrNw8haB
 XLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=+xPiXuwsOTRL3JNx7wAokgncqkI7ZPy08oFiV3kG4YI=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=GSjxg5V+SfcNk3mpAq5ZGDZInsI6WckklvBli2ZjO6k2R2LnfD7LeoVAYhm5+WSh10
 O7xgt7SCx6i3PJvw+mtyDZQkVK8JmSJyFNZz/Vx4+IagZCT2PFymSw5pMOLnMyXxXsmV
 HKm9O6VjyumiD7EfG4I1x3oCO/sqGeFRkc04urydtOLpjCbaaVLo8enjKdkunWfWn92/
 VV9AuNiZkxBbrevhyNfODTpJSkbH+J1/D3xOtNofJCUeCEiiQFR0fllZTx8rJ9zViQ7G
 zfSjky0GjDempNu6/5YjxqSYQI7WMhFS1wIP+N000YF1rW+FP40eFX/A2lu1Dh4ZmEFr
 Ctcg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788154397; x=1788759197; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+xPiXuwsOTRL3JNx7wAokgncqkI7ZPy08oFiV3kG4YI=;
 b=aPoIYOEPPumkW4P+MVUjB3WWEQ7s+Z3PQh/xAtMIDLlLvW0FowndXUqH1dbKssCTPF
 wO4RhNIBalDxMBg/ZLeWaSMFz6lPustyWSVTl4wzaPNZQDuLyfSTQJr7gKVjfoWbE6DY
 cqxj5q9a8MEfNBOpQh2aZpQQEjWiX6uTkCh0zKFXnDp/Yx+K6SPeTqA4kiSnCSIB+ema
 d3SFiCQN6T2fHsbT4E5jcp5Idxk3KgPecclnB6lR4SeKtMUXfvhCRxLAyyNC6y7dLNL+
 y4md90pRMs9vYCRhoJC/+1U92J9fB0VXAIBS1etEkKORw5kBnRRYuSj7qgrba8twCE6z
 saOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788154397; x=1788759197;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+xPiXuwsOTRL3JNx7wAokgncqkI7ZPy08oFiV3kG4YI=;
 b=o6LlASrMzxJZ5T8OE0kZbEZwn19ZjovI+0D3nTmK3y2i6rDKarEZkzM0FPSruwb5QE
 9vWtiTT8OYbj3dFJS58PkNjntsOg74c7oZDsgBSvaGEtKCIFLBL7o5B8yhOnCjFqLNjl
 fCMnblvEDKc5jfJt4GABj5lwVNv3V8uZEoA4FDfjVzeBrKmgKoOBrxC4AKdynSa7oMJW
 FiOIZzZkJByDswq8EHiGb53OYS5JW/BeUATr2VV4kLiWMUDdT+haYRNG7R6VHID8Z6eM
 QWdCj4+KqA2jjuTZrQDZqmL+0ELvvyvDsJIhoaxNioEM+Yj2TQweirTG3k9qmbcaBxfM
 bLyA==
X-Gm-Message-State: AFuF++llALEfgH8VxOkxCrq7N2mw3D7R/vz4lPDlr9LGKvxtEQ4FxLC0
 wickWP4wm5riPdahM8eQy95GW87kwYgLIxMQLiAfORtaKPZfMQ095+uLpK217i47dQyX95quCcS
 3fZ4sBZcvpeH4Kc5ULOU0JdUa7F2YFH7CnkALyhI=
X-Gm-Gg: AYBFou0dTbFuj7LjFn+j1FKcU2rq+LdiBYnJfAYVR7wdSaDFcyzLbzHaPL0rTq4Oiu8
 oMqbbWUpoR3AggqiWhCuhtpDzXtlPm18Tn6ikLVWB9yAB0oy07ZGKXjWQlY3NMOp7EBAFPnI2xD
 MEHFcIVMhSyYJ0J3QI4yLDP6Bx7rB64zszICCdxLgcBfZD3suNxh5XuxBOaTfsnNiocoDKWVVNw
 e/MY8DT769RFUfQRRo1MeHlUlfezkfC1guwuw/8vhmtjszbrSZxdSEbXUavTPbIyIvvyq99R0ib
 BlB6yPvYjgt5HKGblpM1Ju8/7O2STz9C0jOp8kP2wEZlBc5u7Mgmajeh2hc7sk14+nrol5XVTGq
 Miw==
X-Received: by 2002:a05:6402:4014:b0:6a0:a4f5:f4eb with SMTP id
 4fb4d7f45d1cf-6a60d30c331mr15872158a12.4.1788154396469; Sun, 30 Aug 2026
 22:33:16 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:33:15 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:33:15 +0200
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
Date: Mon, 31 Aug 2026 07:33:15 +0200
X-Gm-Features: AcwNN1Xi69TmvUKHw4RqclQkOgl3ljPrxWH_zJOy2uEx04fHBpPpttoQwpAYPKo
Message-ID: <CAH=xXfGGb7bZo71GgyZrjdx0zssbYNztuPNAQn3jhNHpLcMndg@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0ue3-0008AT-7z
Subject: [f2fs-dev] [PATCH v3 09/11] f2fs: parameterize byte and block
 conversion macros
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

Byte-to-block and block-to-byte conversion helpers previously relied on
global PAGE_SIZE, PAGE_SHIFT, or F2FS_BLKSIZE_BITS.

Parameterize F2FS_BYTES_TO_BLK, F2FS_BLK_TO_BYTES, F2FS_BLK_END_BYTES,
F2FS_BLK_ALIGN, and max_file_blocks with struct f2fs_sb_info *sbi using
sbi->log_blocksize.

Update all call sites across data mapping, file operations, fiemap queries,
fsverity checks, NAT bitmap allocations, and truncate paths.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    |  2 +-
 fs/f2fs/data.c          | 58 +++++++++++++++++++++++------------------
 fs/f2fs/debug.c         |  2 +-
 fs/f2fs/f2fs.h          |  7 ++---
 fs/f2fs/file.c          | 54 +++++++++++++++++++++-----------------
 fs/f2fs/node.c          |  7 ++---
 fs/f2fs/recovery.c      |  4 +--
 fs/f2fs/segment.c       |  9 ++++---
 fs/f2fs/super.c         |  9 ++++---
 fs/f2fs/verity.c        |  6 +++--
 include/linux/f2fs_fs.h | 12 ++++++---
 11 files changed, 96 insertions(+), 74 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 37a72b693545..d0dcc918422e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1866,7 +1866,7 @@ static int do_checkpoint(struct f2fs_sb_info
*sbi, struct cp_control *cpc)
 		blk = start_blk + BLKS_PER_SEG(sbi) - nm_i->nat_bits_blocks;
 		for (i = 0; i < nm_i->nat_bits_blocks; i++)
 			f2fs_update_meta_page(sbi, nm_i->nat_bits +
-					F2FS_BLK_TO_BYTES(i), blk + i);
+					F2FS_BLK_TO_BYTES(sbi, i), blk + i);
 	}

 	/* write out checkpoint buffer at block 0 */
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 44e1ae43565e..6ee4440c17dd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1977,12 +1977,12 @@ static bool __f2fs_overwrite_io(struct inode
*inode, loff_t pos, size_t len,
 	if (pos + len > i_size_read(inode))
 		return false;

-	map.m_lblk = F2FS_BYTES_TO_BLK(pos);
+	map.m_lblk = F2FS_BYTES_TO_BLK(F2FS_I_SB(inode), pos);
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = NULL;
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
-	last_lblk = F2FS_BLK_ALIGN(pos + len);
+	last_lblk = F2FS_BLK_ALIGN(F2FS_I_SB(inode), pos + len);

 	while (map.m_lblk < last_lblk) {
 		map.m_len = last_lblk - map.m_lblk;
@@ -2025,7 +2025,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}

-		phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
+		phys = F2FS_BLK_TO_BYTES(sbi, ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
 					sizeof(__le32) * (DEF_ADDRS_PER_INODE_SBI(sbi) -
 					get_inline_xattr_addrs(inode));
@@ -2059,7 +2059,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}

-		phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
+		phys = F2FS_BLK_TO_BYTES(sbi, ni.blk_addr);
 		len = inode->i_sb->s_blocksize;

 		f2fs_folio_put(folio, true);
@@ -2078,6 +2078,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_map_blocks map;
 	sector_t start_blk, last_blk, blk_len, max_len;
 	pgoff_t next_pgofs;
@@ -2101,7 +2102,7 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,

 	inode_lock_shared(inode);

-	maxbytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+	maxbytes = F2FS_BLK_TO_BYTES(sbi, max_file_blocks(sbi, inode));
 	if (start > maxbytes) {
 		ret = -EFBIG;
 		goto out;
@@ -2121,10 +2122,10 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,
 			goto out;
 	}

-	start_blk = F2FS_BYTES_TO_BLK(start);
-	last_blk = F2FS_BYTES_TO_BLK(start + len - 1);
+	start_blk = F2FS_BYTES_TO_BLK(sbi, start);
+	last_blk = F2FS_BYTES_TO_BLK(sbi, start + len - 1);
 	blk_len = last_blk - start_blk + 1;
-	max_len = F2FS_BYTES_TO_BLK(maxbytes) - start_blk;
+	max_len = F2FS_BYTES_TO_BLK(sbi, maxbytes) - start_blk;

 next:
 	memset(&map, 0, sizeof(map));
@@ -2146,7 +2147,7 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,
 	if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
 		start_blk = next_pgofs;

-		if (F2FS_BLK_TO_BYTES(start_blk) < maxbytes)
+		if (F2FS_BLK_TO_BYTES(sbi, start_blk) < maxbytes)
 			goto prep_next;

 		flags |= FIEMAP_EXTENT_LAST;
@@ -2194,14 +2195,14 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,
 	} else if (compr_appended) {
 		unsigned int appended_blks = cluster_size -
 						count_in_cluster + 1;
-		size += F2FS_BLK_TO_BYTES(appended_blks);
+		size += F2FS_BLK_TO_BYTES(sbi, appended_blks);
 		start_blk += appended_blks;
 		compr_cluster = false;
 	} else {
-		logical = F2FS_BLK_TO_BYTES(start_blk);
+		logical = F2FS_BLK_TO_BYTES(sbi, start_blk);
 		phys = __is_valid_data_blkaddr(map.m_pblk) ?
-			F2FS_BLK_TO_BYTES(map.m_pblk) : 0;
-		size = F2FS_BLK_TO_BYTES(map.m_len);
+			F2FS_BLK_TO_BYTES(sbi, map.m_pblk) : 0;
+		size = F2FS_BLK_TO_BYTES(sbi, map.m_len);
 		flags = 0;

 		if (compr_cluster) {
@@ -2215,7 +2216,7 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,
 			flags = FIEMAP_EXTENT_UNWRITTEN;
 		}

-		start_blk += F2FS_BYTES_TO_BLK(size);
+		start_blk += F2FS_BYTES_TO_BLK(sbi, size);
 	}

 prep_next:
@@ -2235,7 +2236,8 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,
 static inline loff_t f2fs_readpage_limit(struct inode *inode)
 {
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
-		return F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+		return F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
+				max_file_blocks(F2FS_I_SB(inode), inode));

 	return i_size_read(inode);
 }
@@ -2263,7 +2265,8 @@ static int f2fs_read_single_page(struct inode
*inode, struct fsverity_info *vi,

 	block_in_file = (sector_t)index;
 	last_block = block_in_file + nr_pages;
-	last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
+	last_block_in_file = F2FS_BYTES_TO_BLK(F2FS_I_SB(inode),
+				f2fs_readpage_limit(inode) +
 							blocksize - 1);
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
@@ -2374,7 +2377,8 @@ int f2fs_read_multi_pages(struct compress_ctx
*cc, struct bio **bio_ret,

 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));

-	last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
+	last_block_in_file = F2FS_BYTES_TO_BLK(sbi,
+				f2fs_readpage_limit(inode) +
 							blocksize - 1);

 	/* get rid of pages beyond EOF */
@@ -4236,7 +4240,7 @@ static sector_t f2fs_bmap(struct address_space
*mapping, sector_t block)
 		filemap_write_and_wait(mapping);

 	/* Block number less than F2FS MAX BLOCKS */
-	if (unlikely(block >= max_file_blocks(inode)))
+	if (unlikely(block >= max_file_blocks(F2FS_I_SB(inode), inode)))
 		goto out;

 	if (f2fs_compressed_file(inode)) {
@@ -4352,7 +4356,7 @@ static int check_swap_activate(struct
swap_info_struct *sis,
 	 * to be very smart.
 	 */
 	cur_lblock = 0;
-	last_lblock = F2FS_BYTES_TO_BLK(i_size_read(inode));
+	last_lblock = F2FS_BYTES_TO_BLK(sbi, i_size_read(inode));

 	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
@@ -4607,12 +4611,14 @@ static int f2fs_iomap_begin(struct inode
*inode, loff_t offset, loff_t length,
 			    unsigned int flags, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_map_blocks map = { NULL, };
 	pgoff_t next_pgofs = 0;
 	int err;

-	map.m_lblk = F2FS_BYTES_TO_BLK(offset);
-	map.m_len = F2FS_BYTES_TO_BLK(offset + length - 1) - map.m_lblk + 1;
+	map.m_lblk = F2FS_BYTES_TO_BLK(sbi, offset);
+	map.m_len = F2FS_BYTES_TO_BLK(sbi, offset + length - 1) -
+							map.m_lblk + 1;
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
@@ -4633,7 +4639,7 @@ static int f2fs_iomap_begin(struct inode *inode,
loff_t offset, loff_t length,
 	if (err)
 		return err;

-	iomap->offset = F2FS_BLK_TO_BYTES(map.m_lblk);
+	iomap->offset = F2FS_BLK_TO_BYTES(sbi, map.m_lblk);

 	/*
 	 * When inline encryption is enabled, sometimes I/O to an encrypted file
@@ -4653,11 +4659,11 @@ static int f2fs_iomap_begin(struct inode
*inode, loff_t offset, loff_t length,
 		if (WARN_ON_ONCE(map.m_pblk == NEW_ADDR))
 			return -EINVAL;

-		iomap->length = F2FS_BLK_TO_BYTES(map.m_len);
+		iomap->length = F2FS_BLK_TO_BYTES(sbi, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
 		iomap->bdev = map.m_bdev;
-		iomap->addr = F2FS_BLK_TO_BYTES(map.m_pblk);
+		iomap->addr = F2FS_BLK_TO_BYTES(sbi, map.m_pblk);

 		if (flags & IOMAP_WRITE && map.m_last_pblk)
 			iomap->private = (void *)map.m_last_pblk;
@@ -4666,11 +4672,11 @@ static int f2fs_iomap_begin(struct inode
*inode, loff_t offset, loff_t length,
 			return -ENOTBLK;

 		if (map.m_pblk == NULL_ADDR) {
-			iomap->length = F2FS_BLK_TO_BYTES(next_pgofs) -
+			iomap->length = F2FS_BLK_TO_BYTES(sbi, next_pgofs) -
 							iomap->offset;
 			iomap->type = IOMAP_HOLE;
 		} else if (map.m_pblk == NEW_ADDR) {
-			iomap->length = F2FS_BLK_TO_BYTES(map.m_len);
+			iomap->length = F2FS_BLK_TO_BYTES(sbi, map.m_len);
 			iomap->type = IOMAP_UNWRITTEN;
 		} else {
 			f2fs_bug_on(F2FS_I_SB(inode), 1);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 5980b9d79afb..a6cfceafe2fe 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -343,7 +343,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	/* build nm */
 	si->base_mem += sizeof(struct f2fs_nm_info);
 	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
-	si->base_mem += F2FS_BLK_TO_BYTES(NM_I(sbi)->nat_bits_blocks);
+	si->base_mem += F2FS_BLK_TO_BYTES(sbi, NM_I(sbi)->nat_bits_blocks);
 	si->base_mem += NM_I(sbi)->nat_blocks *
 				f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK(sbi));
 	si->base_mem += NM_I(sbi)->nat_blocks / 8;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b90c5a42703f..c625a2572841 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4016,7 +4016,7 @@ void f2fs_inode_synced(struct inode *inode);
 int f2fs_dquot_initialize(struct inode *inode);
 int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
 int f2fs_do_quota_sync(struct super_block *sb, int type);
-loff_t max_file_blocks(struct inode *inode);
+loff_t max_file_blocks(struct f2fs_sb_info *sbi, struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
@@ -5263,8 +5263,9 @@ static inline void
f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
 							NULL, 0, DATA);

 	truncate_inode_pages_range(META_MAPPING(sbi),
-			F2FS_BLK_TO_BYTES((loff_t)blkaddr),
-			F2FS_BLK_END_BYTES((loff_t)(blkaddr + cnt - 1)));
+			F2FS_BLK_TO_BYTES(sbi, (loff_t)blkaddr),
+			F2FS_BLK_END_BYTES(sbi,
+					    (loff_t)(blkaddr + cnt - 1)));
 }

 static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c72e028cec2..6fafb32bc5f2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -513,7 +513,8 @@ static bool __found_offset(struct address_space *mapping,
 static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+	loff_t maxbytes = F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
+			max_file_blocks(F2FS_I_SB(inode), inode));
 	struct dnode_of_data dn;
 	pgoff_t pgofs, end_offset;
 	loff_t data_ofs = offset;
@@ -537,9 +538,10 @@ static loff_t f2fs_seek_block(struct file *file,
loff_t offset, int whence)
 		}
 	}

-	pgofs = (pgoff_t)(offset >> PAGE_SHIFT);
+	pgofs = F2FS_BYTES_TO_BLK(F2FS_I_SB(inode), offset);

-	for (; data_ofs < isize; data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
+	for (; data_ofs < isize;
+			data_ofs = F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), pgofs)) {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_dnode_of_data(&dn, pgofs, LOOKUP_NODE);
 		if (err && err != -ENOENT) {
@@ -559,7 +561,7 @@ static loff_t f2fs_seek_block(struct file *file,
loff_t offset, int whence)
 		/* find data/hole in dnode block */
 		for (; dn.ofs_in_node < end_offset;
 				dn.ofs_in_node++, pgofs++,
-				data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
+				data_ofs = F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), pgofs)) {
 			block_t blkaddr;

 			blkaddr = f2fs_data_blkaddr(&dn);
@@ -595,7 +597,8 @@ static loff_t f2fs_seek_block(struct file *file,
loff_t offset, int whence)
 static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+	loff_t maxbytes = F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
+			max_file_blocks(F2FS_I_SB(inode), inode));

 	switch (whence) {
 	case SEEK_SET:
@@ -846,9 +849,9 @@ int f2fs_do_truncate_blocks(struct inode *inode,
u64 from, bool lock)
 		goto out_err;
 	}

-	free_from = (pgoff_t)F2FS_BLK_ALIGN(from);
+	free_from = (pgoff_t)F2FS_BLK_ALIGN(sbi, from);

-	if (free_from >= max_file_blocks(inode))
+	if (free_from >= max_file_blocks(sbi, inode))
 		goto free_partial;

 	if (lock)
@@ -959,9 +962,10 @@ int f2fs_truncate_blocks(struct inode *inode, u64
from, bool lock)

 int f2fs_truncate(struct inode *inode)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;

-	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
+	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;

 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
@@ -970,7 +974,7 @@ int f2fs_truncate(struct inode *inode)

 	trace_f2fs_truncate(inode);

-	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE))
+	if (time_to_inject(sbi, FAULT_TRUNCATE))
 		return -EIO;

 	err = f2fs_dquot_initialize(inode);
@@ -986,8 +990,8 @@ int f2fs_truncate(struct inode *inode)
 			 * leak in evict() path.
 			 */
 			truncate_inode_pages_range(inode->i_mapping,
-					F2FS_BLK_TO_BYTES(0),
-					F2FS_BLK_END_BYTES(0));
+					F2FS_BLK_TO_BYTES(sbi, 0),
+					F2FS_BLK_END_BYTES(sbi, 0));
 			return err;
 		}
 	}
@@ -1161,7 +1165,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct
dentry *dentry,
 			return -EOPNOTSUPP;
 		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
 			!IS_ALIGNED(attr->ia_size,
-			F2FS_BLK_TO_BYTES(fi->i_cluster_size)))
+			F2FS_BLK_TO_BYTES(sbi, fi->i_cluster_size)))
 			return -EINVAL;

 		if (f2fs_is_pinned_file(inode)) {
@@ -1177,7 +1181,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct
dentry *dentry,
 			 * pinned file.
 			 */
 			else if (!IS_ALIGNED(attr->ia_size,
-				F2FS_BLK_TO_BYTES(CAP_BLKS_PER_SEC(sbi))))
+				F2FS_BLK_TO_BYTES(sbi, CAP_BLKS_PER_SEC(sbi))))
 				return -EINVAL;
 		}
 	}
@@ -2648,7 +2652,8 @@ static int f2fs_keep_noreuse_range(struct inode *inode,
 				loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	u64 max_bytes = F2FS_BLK_TO_BYTES(max_file_blocks(inode));
+	u64 max_bytes = F2FS_BLK_TO_BYTES(sbi,
+					max_file_blocks(sbi, inode));
 	u64 start, end;
 	int ret = 0;

@@ -3191,8 +3196,8 @@ static int f2fs_ioc_defragment(struct file
*filp, unsigned long arg)
 	if (range.start & (F2FS_BLKSIZE - 1) || range.len & (F2FS_BLKSIZE - 1))
 		return -EINVAL;

-	if (unlikely((range.start + range.len) >> PAGE_SHIFT >
-					max_file_blocks(inode)))
+	if (unlikely(F2FS_BYTES_TO_BLK(sbi, range.start + range.len) >
+					max_file_blocks(sbi, inode)))
 		return -EINVAL;

 	err = mnt_want_write_file(filp);
@@ -3326,9 +3331,9 @@ static int f2fs_move_file_range(struct file
*file_in, loff_t pos_in,
 	}

 	f2fs_lock_op(sbi, &lc);
-	ret = __exchange_data_block(src, dst, F2FS_BYTES_TO_BLK(pos_in),
-				F2FS_BYTES_TO_BLK(pos_out),
-				F2FS_BYTES_TO_BLK(len), false);
+	ret = __exchange_data_block(src, dst, F2FS_BYTES_TO_BLK(sbi, pos_in),
+				F2FS_BYTES_TO_BLK(sbi, pos_out),
+				F2FS_BYTES_TO_BLK(sbi, len), false);

 	if (!ret) {
 		if (dst_max_i_size)
@@ -3994,7 +3999,7 @@ int f2fs_precache_extents(struct inode *inode)
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
 	map.m_may_create = false;
-	end = F2FS_BLK_ALIGN(i_size_read(inode));
+	end = F2FS_BLK_ALIGN(F2FS_I_SB(inode), i_size_read(inode));

 	while (map.m_lblk < end) {
 		map.m_len = end - map.m_lblk;
@@ -4594,7 +4599,7 @@ static int f2fs_sec_trim_file(struct file *filp,
unsigned long arg)
 		goto err;
 	}

-	index = F2FS_BYTES_TO_BLK(range.start);
+	index = F2FS_BYTES_TO_BLK(sbi, range.start);
 	pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);

 	ret = f2fs_convert_inline_inode(inode);
@@ -5385,7 +5390,8 @@ static int f2fs_preallocate_blocks(struct kiocb
*iocb, struct iov_iter *iter,
 	 * buffered IO, if DIO meets any holes.
 	 */
 	if (dio && i_size_read(inode) &&
-		(F2FS_BYTES_TO_BLK(pos) < F2FS_BLK_ALIGN(i_size_read(inode))))
+		(F2FS_BYTES_TO_BLK(sbi, pos) <
+		 F2FS_BLK_ALIGN(sbi, i_size_read(inode))))
 		return 0;

 	/* No-wait I/O can't allocate blocks. */
@@ -5406,8 +5412,8 @@ static int f2fs_preallocate_blocks(struct kiocb
*iocb, struct iov_iter *iter,
 	}

 	/* Do not preallocate blocks that will be written partially in 4KB. */
-	map.m_lblk = F2FS_BLK_ALIGN(pos);
-	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
+	map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
+	map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
 	if (map.m_len > map.m_lblk)
 		map.m_len -= map.m_lblk;
 	else
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7dabfada1b54..e7aa3b790214 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3294,9 +3294,10 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	if (!enabled_nat_bits(sbi, NULL))
 		return 0;

-	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
+	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN(sbi,
+					       (nat_bits_bytes << 1) + 8);
 	nm_i->nat_bits = f2fs_kvzalloc(sbi,
-			F2FS_BLK_TO_BYTES(nm_i->nat_bits_blocks), GFP_KERNEL);
+			F2FS_BLK_TO_BYTES(sbi, nm_i->nat_bits_blocks), GFP_KERNEL);
 	if (!nm_i->nat_bits)
 		return -ENOMEM;

@@ -3309,7 +3310,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 		if (IS_ERR(folio))
 			return PTR_ERR(folio);

-		memcpy(nm_i->nat_bits + F2FS_BLK_TO_BYTES(i),
+		memcpy(nm_i->nat_bits + F2FS_BLK_TO_BYTES(sbi, i),
 					folio_address(folio), F2FS_BLKSIZE);
 		f2fs_folio_put(folio, true);
 	}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index aaa5227739c8..b52718741ddc 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -734,9 +734,9 @@ static int do_recover_data(struct f2fs_sb_info
*sbi, struct inode *inode,
 		}

 		if (!file_keep_isize(inode) &&
-			(i_size_read(inode) <= ((loff_t)index << PAGE_SHIFT)))
+			(i_size_read(inode) <= F2FS_BLK_TO_BYTES(sbi, index)))
 			f2fs_i_size_write(inode,
-				(loff_t)(index + 1) << PAGE_SHIFT);
+				F2FS_BLK_TO_BYTES(sbi, index + 1));

 		/*
 		 * dest is reserved block, invalidate src block
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f565b6873832..f58b26c84b3a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3592,8 +3592,8 @@ static unsigned int
__issue_discard_cmd_range(struct f2fs_sb_info *sbi,

 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 {
-	__u64 start = F2FS_BYTES_TO_BLK(range->start);
-	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
+	__u64 start = F2FS_BYTES_TO_BLK(sbi, range->start);
+	__u64 end = start + F2FS_BYTES_TO_BLK(sbi, range->len) - 1;
 	unsigned int start_segno, end_segno;
 	block_t start_block, end_block;
 	struct cp_control cpc;
@@ -3624,7 +3624,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi,
struct fstrim_range *range)
 	}

 	cpc.reason = CP_DISCARD;
-	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
+	cpc.trim_minlen = max_t(__u64, 1,
+				F2FS_BYTES_TO_BLK(sbi, range->minlen));
 	cpc.trim_start = start_segno;
 	cpc.trim_end = end_segno;

@@ -3658,7 +3659,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi,
struct fstrim_range *range)
 					start_block, end_block);
 out:
 	if (!err)
-		range->len = F2FS_BLK_TO_BYTES(trimmed);
+		range->len = F2FS_BLK_TO_BYTES(sbi, trimmed);
 	return err;
 }

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 46973207cd7b..b962c14cbcc1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3884,7 +3884,7 @@ static const struct export_operations f2fs_export_ops = {
 	.get_parent = f2fs_get_parent,
 };

-loff_t max_file_blocks(struct inode *inode)
+loff_t max_file_blocks(struct f2fs_sb_info *sbi, struct inode *inode)
 {
 	loff_t result = 0;
 	loff_t leaf_count;
@@ -3918,7 +3918,8 @@ loff_t max_file_blocks(struct inode *inode)
 	 * fit within U32_MAX + 1 data units.
 	 */

-	result = umin(result, F2FS_BYTES_TO_BLK(((loff_t)U32_MAX + 1) * 4096));
+	result = umin(result, F2FS_BYTES_TO_BLK(sbi,
+						((loff_t)U32_MAX + 1) * 4096));

 	return result;
 }
@@ -4370,7 +4371,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)

 	nat_blocks = nat_segs << log_blocks_per_seg;
 	nat_bits_bytes = nat_blocks / BITS_PER_BYTE;
-	nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
+	nat_bits_blocks = F2FS_BLK_ALIGN(sbi, (nat_bits_bytes << 1) + 8);
 	if (__is_set_ckpt_flags(ckpt, CP_NAT_BITS_FLAG) &&
 		(cp_payload + F2FS_CP_PACKS +
 		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >= blocks_per_seg)) {
@@ -5193,7 +5194,7 @@ static int f2fs_fill_super(struct super_block
*sb, struct fs_context *fc)
 	if (err)
 		goto free_options;

-	sb->s_maxbytes = max_file_blocks(NULL) <<
+	sb->s_maxbytes = max_file_blocks(sbi, NULL) <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 39f482515445..ee838f880c4a 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -75,7 +75,8 @@ static int pagecache_write(struct inode *inode,
const void *buf, size_t count,
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;

-	if (pos + count > F2FS_BLK_TO_BYTES(max_file_blocks(inode)))
+	if (pos + count > F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
+			max_file_blocks(F2FS_I_SB(inode), inode)))
 		return -EFBIG;

 	while (count) {
@@ -239,7 +240,8 @@ static int f2fs_get_verity_descriptor(struct inode
*inode, void *buf,

 	/* Get the descriptor */
 	if (pos + size < pos ||
-	    pos + size > F2FS_BLK_TO_BYTES(max_file_blocks(inode)) ||
+	    pos + size > F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
+			max_file_blocks(F2FS_I_SB(inode), inode)) ||
 	    pos < f2fs_verity_metadata_pos(inode) || size > INT_MAX) {
 		f2fs_warn(F2FS_I_SB(inode), "invalid verity xattr");
 		f2fs_handle_error(F2FS_I_SB(inode),
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f89609356be8..f622d26f37a7 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -28,10 +28,14 @@
 #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */

 #define F2FS_BLKSIZE_MASK		(F2FS_BLKSIZE - 1)
-#define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >>
F2FS_BLKSIZE_BITS)
-#define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) <<
F2FS_BLKSIZE_BITS)
-#define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
-#define F2FS_BLK_ALIGN(x)		(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
+#define F2FS_BYTES_TO_BLK(sbi, bytes)					\
+	((unsigned long long)(bytes) >> (sbi)->log_blocksize)
+#define F2FS_BLK_TO_BYTES(sbi, blk)					\
+	((unsigned long long)(blk) << (sbi)->log_blocksize)
+#define F2FS_BLK_END_BYTES(sbi, blk)					\
+	(F2FS_BLK_TO_BYTES(sbi, (blk) + 1) - 1)
+#define F2FS_BLK_ALIGN(sbi, x)						\
+	DIV_ROUND_UP_ULL((x), (sbi)->blocksize)

 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
