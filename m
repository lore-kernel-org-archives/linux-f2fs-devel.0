Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C158C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KhIO20OymHOlocJhIV5RlKpFAT0b+rM4+RmtYfNTRU=; b=D5Yb5Tl5cW6VzJtV5pb2ijh0jO
	XvkTfABSipZMxXCOpCCGXTnhobTLsVsTxfC/rzb02njRAW2X3G/h+UjQOos7yIryUPpbPxp5b/BaZ
	gvJtiBbodcUtD2ZVxhMOKSiv7Usc1GS0EU0bxYFSd0PNI8QE1oU2x5OKsJCGkXy7t1qo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0ueB-0000tO-A4;
	Mon, 31 Aug 2026 05:33:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0ue8-0000t9-T3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sShZ/p9JhAyJtYlCQ6JBaxq71U2kKKsBw7SA3hikdnY=; b=KxPtekxXvWp0c4iDU9CuqvYhCw
 LZb5/AgGgiFfdkMRcPzpNWZuLdeVT6bPx1ytiOOhimT0hV7SNe7pJjdSRwsMghC5XwHaNFCFof4hB
 +zab/P7tdUnjBky+sY7L6Ylzghu+ResXIn/2UPCkQ9+sLvyl9LU5GekpibjKaEjHshG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sShZ/p9JhAyJtYlCQ6JBaxq71U2kKKsBw7SA3hikdnY=; b=JDSFPxYIlh5TynL0NH1XEFmhDy
 nagkpA4K1j5/6JLCsyGpIlvwi/N6+nDWzjbsEic8Hgy6uU0K9sR9ptDTexrKlAA1Zfa9K4quG05D3
 Z6IhFtXWJYflOmTz5KbW1FkRj9DHTuqaQ/UF46sKRjvj9625+gI/ZD1d0faYjYlLPQG4=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0ue6-0008Ac-MG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:29 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so1357011a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 22:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788154400; cv=none;
 d=google.com; s=arc-20260327;
 b=PV0wshbpeUl3p3sOYUNHdaaLYywRhIArUMfXJMRkrspQd1LkV93eYXhTc6kzgXTfMO
 Dg7Xe3ghsGClU2c4sgnuBHC4h2dZpcJbCXk+gmHxx42XO6iDNAevmiPpXcW/F7oFEZiE
 vaEgB8RDnY2+4Lt2BE41lQHeu3s+tIZWERU+pKKSiZ9BpB5OB/4KL9rfJFC+R62WWRSB
 6XIeSUJF3DnQ77Bi7mquP4eHiUdt88S4rUjiRMNcjB+NH4xomd3YVxxPnS60iaVu1NXO
 uliXe3bvlhgEMqqEHGVkkgcsWWjFOzY1amXcyyGgge2bSGYXn3+VyzTX4DBf0yHM878F
 td6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=sShZ/p9JhAyJtYlCQ6JBaxq71U2kKKsBw7SA3hikdnY=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=ZNPqcCEbmF9n6rBiQ7d69XH9Fmo/FfLO+cxSGwcVCPfN4Se7xiiDF7xFhBpxlkckIr
 17gr1Ps0u0slMjuMhAI9WYdViUJIwL0gw6ub+C02Pw7vqsy5g2RNac/5CN5Mrj0GoQCU
 2foe23vIzGpmhEvd1g0/pqN3IXP+CCw6IN4SCh7Q/HYhJ7R9EE0HSz8jjJ7xK7aycJVk
 zP3OM1YeNWMzwWbzqi3T+uaXrADTcyh0wx9402rX1EgWloeS7pPj+70XNj3Z60t9DjNv
 VKxAOrmohyzudvzmlANnSIGdZcJOafi2jpoUeCOsdb4/UZGL87lIPnbvpyw7ybe3LjWr
 WVMw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788154400; x=1788759200; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sShZ/p9JhAyJtYlCQ6JBaxq71U2kKKsBw7SA3hikdnY=;
 b=MOkEMOIGJyJWp9+WXC8koI0iU/zyGxvY/czzFhHs0xDsRMeZ8Dqq3o1/1IpwtJTXkv
 MrU0XaJuLUZnyX0Ki5ZlsHNiYaUcDyQj375LKRgSnfz/3Q6yDHvQcU8ZmczDNEwxfsTR
 Ggzg7cwXOPVo0F/kvQRY8C//ZgWdSl2EqdzvRybF0liOtxR6GZPfosoT0zSqXDcjrQmk
 Ws9XnDhpra6I0b5CwXZD52Gz4jD9cO+k3zUXgj29PmOO9BBGEibHAj3g2dgx+xl3kXUF
 1+cwwq98z0GjN9Nlczm+qO1c2w2RK/CJZIPWqhG9dpB+qmruOL1auy3tEfyff2/35ls7
 QZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788154400; x=1788759200;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sShZ/p9JhAyJtYlCQ6JBaxq71U2kKKsBw7SA3hikdnY=;
 b=LD1JPT3NpQfAZJJ9LsrLC794q+nW5RHScHGBTRZWLXV52Ea4uCeDgNl+DcvNqwuKlr
 f5b1NEc4U7RLl0ZrN08Y7NyKRT4cCftbHunVOQktuDzRy4mWDHyhRdclOBwvNt7GY7q0
 4ltxoleKtxu0iG+8oyLRLcr0lyCm8wxymXt4uJ8y7QjPL7LS3wJARt76zSysAJyDqHYf
 +19LBhfR/l/3LSHbVt2OiMw6I0W4nBhLcYLKHJwEoBumIn8lbCJmjrHApcq9jbS9dcrg
 6GE7fK+TFEnAtQ4L20I0pjCWeBaX9DC8zEi0rpa7auAL+8DxJOCe9BMbuITcT5apRqjv
 42eg==
X-Gm-Message-State: AFuF++kja4tu5UyZPfvhJIIhDqr+mTBOhjkXtTBieuTS7YDdmvLZHC+v
 C9+rWdycHgaNDLFUq6dKbGIwTTtjnQOxd7ZzgA5DBSOyy1i+zxtDApQWigjSXKkz2RIB+Nsoe95
 JTNdUA0oEShUJ3jDMeZ7LDYb1zoUjPMILU1BZ4VM=
X-Gm-Gg: AYBFou3094nuXFOPmmc+FLIIyp+P0kLG5emE/edr2t6bn2MifU5BdpPWuMCTa9z7n1+
 gtceKIpgsGEQMKDuLLvJkLVTpdYm9y4VfDZAlxraZbExbRAMdjIzttMR02GWbqLZjOW+deP/P85
 CFOIEEEfQdORyETCdlvymmSF2yPoyjOamMuo+gK3SUDtTbJhlQMO30jRkXekp/s7/LuFhjUfKjD
 IdoB6kzS5hPD8ScjmgwboYRCYcDJT7lVkshnIbaBytjoOH6dtfS3iY924bQdYBo9BFiWq6SkRVV
 HzPdTvOFBu4NvrEQFewPb8jqsWOX4DNYn1XvvRMd48P5jjRzADw6qt+GWyl286uDvVqZUDxBn7Y
 wvA==
X-Received: by 2002:a05:6402:510c:b0:69c:811f:8f5 with SMTP id
 4fb4d7f45d1cf-6a60d32f3ecmr12406765a12.6.1788154399807; Sun, 30 Aug 2026
 22:33:19 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:33:18 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:33:18 +0200
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
Date: Mon, 31 Aug 2026 07:33:18 +0200
X-Gm-Features: AcwNN1UuNdyjNqRYwsvLtaXsLpDOIKAL_ipaefzEhYQCTMkQRaXo2k1fckqS2s0
Message-ID: <CAH=xXfESv64DXrofNfVsJ60vywTgO5sXdFwsgoGRy6eOAjTDtQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0ue6-0008Ac-MG
Subject: [f2fs-dev] [PATCH v3 10/11] f2fs: parameterize block size and mask
 macros
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

Block size constants, shift counts, masks, and page-to-block ratios were
globally defined assuming a fixed 4KB block size.

Parameterize F2FS_BLKSIZE, F2FS_BLKSIZE_BITS, F2FS_BLKSIZE_MASK,
F2FS_BLKS_PER_PAGE, and CP_CHKSUM_OFFSET with struct f2fs_sb_info *sbi
to reference sbi->blocksize, sbi->log_blocksize, and runtime masks.

Update call sites across metadata operations, data I/O, file operations,
garbage collection, inline data, and sysfs information.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    | 23 ++++++++++++-----------
 fs/f2fs/data.c          | 25 ++++++++++++++-----------
 fs/f2fs/extent_cache.c  |  6 ++++--
 fs/f2fs/f2fs.h          | 15 +++++++++++----
 fs/f2fs/file.c          | 30 +++++++++++++++++-------------
 fs/f2fs/gc.c            | 11 ++++++-----
 fs/f2fs/inline.c        |  6 +++---
 fs/f2fs/inode.c         |  4 ++--
 fs/f2fs/node.c          |  7 ++++---
 fs/f2fs/node.h          |  2 +-
 fs/f2fs/segment.c       | 18 +++++++++++-------
 fs/f2fs/segment.h       |  4 ++--
 fs/f2fs/super.c         |  6 +++---
 fs/f2fs/sysfs.c         | 10 +++++-----
 fs/f2fs/xattr.c         |  2 +-
 include/linux/f2fs_fs.h | 22 +++++++++++-----------
 16 files changed, 107 insertions(+), 84 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d0dcc918422e..015c7449e45a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -288,7 +288,7 @@ static struct folio *__get_meta_folio(struct
f2fs_sb_info *sbi, pgoff_t index,
 		return ERR_PTR(err);
 	}

-	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE(sbi));

 	folio_lock(folio);
 	if (unlikely(!is_meta_folio(folio))) {
@@ -513,7 +513,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi,
block_t start, int nrpages,

 		if (!err)
 			f2fs_update_iostat(sbi, NULL, FS_META_READ_IO,
-							F2FS_BLKSIZE);
+							F2FS_BLKSIZE(sbi));
 	}
 out:
 	blk_finish_plug(&plug);
@@ -1141,16 +1141,17 @@ static void write_orphan_inodes(struct
f2fs_sb_info *sbi, block_t start_blk)
 	}
 }

-static __u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *ckpt)
+static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
+				     struct f2fs_checkpoint *ckpt)
 {
 	unsigned int chksum_ofs = le32_to_cpu(ckpt->checksum_offset);
 	__u32 chksum;

 	chksum = f2fs_crc32(ckpt, chksum_ofs);
-	if (chksum_ofs < CP_CHKSUM_OFFSET) {
+	if (chksum_ofs < CP_CHKSUM_OFFSET(sbi)) {
 		chksum_ofs += sizeof(chksum);
 		chksum = f2fs_chksum(chksum, (__u8 *)ckpt + chksum_ofs,
-				     F2FS_BLKSIZE - chksum_ofs);
+					F2FS_BLKSIZE(sbi) - chksum_ofs);
 	}
 	return chksum;
 }
@@ -1170,13 +1171,13 @@ static int get_checkpoint_version(struct
f2fs_sb_info *sbi, block_t cp_addr,

 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
 	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
-			crc_offset > CP_CHKSUM_OFFSET) {
+			crc_offset > CP_CHKSUM_OFFSET(sbi)) {
 		f2fs_folio_put(*cp_folio, true);
 		f2fs_warn(sbi, "invalid crc_offset: %zu", crc_offset);
 		return -EINVAL;
 	}

-	crc = f2fs_checkpoint_chksum(*cp_block);
+	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
 	if (crc != cur_cp_crc(*cp_block)) {
 		f2fs_folio_put(*cp_folio, true);
 		f2fs_warn(sbi, "invalid crc value");
@@ -1713,7 +1714,7 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	 */
 	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);

-	memcpy(folio_address(folio), src, PAGE_SIZE);
+	memcpy(folio_address(folio), src, F2FS_BLKSIZE(sbi));

 	folio_mark_dirty(folio);
 	if (unlikely(!folio_clear_dirty_for_io(folio)))
@@ -1848,7 +1849,7 @@ static int do_checkpoint(struct f2fs_sb_info
*sbi, struct cp_control *cpc)
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
 	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));

-	crc32 = f2fs_checkpoint_chksum(ckpt);
+	crc32 = f2fs_checkpoint_chksum(sbi, ckpt);
 	*((__le32 *)((unsigned char *)ckpt +
 				le32_to_cpu(ckpt->checksum_offset)))
 				= cpu_to_le32(crc32);
@@ -1873,8 +1874,8 @@ static int do_checkpoint(struct f2fs_sb_info
*sbi, struct cp_control *cpc)
 	f2fs_update_meta_page(sbi, ckpt, start_blk++);

 	for (i = 1; i < 1 + cp_payload_blks; i++)
-		f2fs_update_meta_page(sbi, (char *)ckpt + i * F2FS_BLKSIZE,
-							start_blk++);
+		f2fs_update_meta_page(sbi, (char *)ckpt +
+				i * F2FS_BLKSIZE(sbi), start_blk++);

 	if (orphan_num) {
 		write_orphan_inodes(sbi, start_blk);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6ee4440c17dd..d7b22eaa746e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1227,7 +1227,7 @@ static void f2fs_submit_page_read(struct inode
*inode, struct fsverity_info *vi,
 		f2fs_bug_on(sbi, 1);

 	inc_page_count(sbi, F2FS_RD_DATA);
-	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE(sbi));
 	f2fs_submit_read_bio(sbi, bio, DATA);
 }

@@ -2210,7 +2210,7 @@ int f2fs_fiemap(struct inode *inode, struct
fiemap_extent_info *fieinfo,
 			count_in_cluster += map.m_len;
 			if (count_in_cluster == cluster_size) {
 				compr_cluster = false;
-				size += F2FS_BLKSIZE;
+				size += F2FS_BLKSIZE(sbi);
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
 			flags = FIEMAP_EXTENT_UNWRITTEN;
@@ -2255,7 +2255,7 @@ static int f2fs_read_single_page(struct inode
*inode, struct fsverity_info *vi,
 				 struct readahead_control *rac)
 {
 	struct bio *bio = *bio_ret;
-	const unsigned int blocksize = F2FS_BLKSIZE;
+	const unsigned int blocksize = F2FS_BLKSIZE(F2FS_I_SB(inode));
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -2344,7 +2344,7 @@ static int f2fs_read_single_page(struct inode
*inode, struct fsverity_info *vi,

 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 	f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-							F2FS_BLKSIZE);
+					F2FS_BLKSIZE(F2FS_I_SB(inode)));
 	*last_block_in_bio = block_nr;
 out:
 	*bio_ret = bio;
@@ -2362,7 +2362,7 @@ int f2fs_read_multi_pages(struct compress_ctx
*cc, struct bio **bio_ret,
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
 	sector_t last_block_in_file;
-	const unsigned int blocksize = F2FS_BLKSIZE;
+	const unsigned int blocksize = F2FS_BLKSIZE(sbi);
 	struct decompress_io_ctx *dic = NULL;
 	struct extent_info ei = {};
 	bool from_dnode = true;
@@ -2495,7 +2495,8 @@ int f2fs_read_multi_pages(struct compress_ctx
*cc, struct bio **bio_ret,
 		refcount_inc(&dic->refcnt);

 		inc_page_count(sbi, F2FS_RD_DATA);
-		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO,
+				   F2FS_BLKSIZE(sbi));
 		*last_block_in_bio = blkaddr;
 	}

@@ -2669,14 +2670,14 @@ static int f2fs_read_data_large_folio(struct
inode *inode,
 		 */
 		f2fs_wait_on_block_writeback(inode, block_nr);

-		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE,
-					offset << PAGE_SHIFT))
+		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(F2FS_I_SB(inode)),
+				offset << PAGE_SHIFT))
 			goto submit_and_realloc;

 		folio_in_bio = true;
 		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-				F2FS_BLKSIZE);
+				F2FS_BLKSIZE(F2FS_I_SB(inode)));
 		last_block_in_bio = block_nr;
 	}
 	trace_f2fs_read_folio(folio, DATA);
@@ -4230,6 +4231,7 @@ static sector_t f2fs_bmap_compress(struct inode
*inode, sector_t block)
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	sector_t blknr = 0;

 	if (f2fs_has_inline_data(inode))
@@ -4240,7 +4242,7 @@ static sector_t f2fs_bmap(struct address_space
*mapping, sector_t block)
 		filemap_write_and_wait(mapping);

 	/* Block number less than F2FS MAX BLOCKS */
-	if (unlikely(block >= max_file_blocks(F2FS_I_SB(inode), inode)))
+	if (unlikely(block >= max_file_blocks(sbi, inode)))
 		goto out;

 	if (f2fs_compressed_file(inode)) {
@@ -4442,7 +4444,8 @@ static int check_swap_activate(struct
swap_info_struct *sis,
 out:
 	if (not_aligned)
 		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(),
2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(%lu * N)",
-			  not_aligned, blks_per_sec * F2FS_BLKSIZE);
+			  not_aligned,
+			  (unsigned long)blks_per_sec * F2FS_BLKSIZE(sbi));
 	return ret;
 }

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 37cf9fa8d537..2d3fdd82b13d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -904,11 +904,13 @@ static int __get_new_block_age(struct inode
*inode, struct extent_info *ei,
 	struct extent_info tei = *ei;	/* only fofs and len are valid */

 	/*
-	 * When I/O is not aligned to a PAGE_SIZE, update will happen to the last
+	 * When I/O is not aligned to the filesystem block size, update will
+	 * happen to the last
 	 * file block even in seq write. So don't record age for newly last file
 	 * block here.
 	 */
-	if ((f_size >> PAGE_SHIFT) == ei->fofs && f_size & (PAGE_SIZE - 1) &&
+	if ((f_size >> sbi->log_blocksize) == ei->fofs &&
+	    f_size & F2FS_BLKSIZE_MASK(sbi) &&
 			blkaddr == NEW_ADDR)
 		return -EINVAL;

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c625a2572841..f83cdab66f54 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2234,7 +2234,7 @@ static inline struct f2fs_sb_info
*F2FS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }

-static inline struct f2fs_sb_info *F2FS_I_SB(struct inode *inode)
+static inline struct f2fs_sb_info *F2FS_I_SB(const struct inode *inode)
 {
 	return F2FS_SB(inode->i_sb);
 }
@@ -2249,12 +2249,18 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)
 	return F2FS_M_SB(folio->mapping);
 }

+static inline struct f2fs_sb_info *F2FS_P_SB(struct page *page)
+{
+	return F2FS_F_SB(page_folio(page));
+}
+
 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
 #define NAT_ENTRY_PER_BLOCK(sbi)	((sbi)->nat_entries_per_block)
 #define DEF_ADDRS_PER_INODE_SBI(sbi)	((sbi)->addrs_per_inode)
 #define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
 #define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
 					F2FS_ORPHANS_PER_BLOCK(sbi))
+#define CP_CHKSUM_OFFSET(sbi)		(F2FS_BLKSIZE(sbi) - sizeof(__le32))

 static inline struct f2fs_orphan_footer *
 f2fs_orphan_footer(void *orphan_block, struct f2fs_sb_info *sbi)
@@ -2303,7 +2309,7 @@ static inline struct f2fs_checkpoint
*F2FS_CKPT(struct f2fs_sb_info *sbi)

 static inline struct node_footer *F2FS_NODE_FOOTER(const struct folio *folio)
 {
-	return folio_address(folio) + F2FS_BLKSIZE -
+	return folio_address(folio) + F2FS_BLKSIZE(F2FS_F_SB(folio)) -
 		sizeof(struct node_footer);
 }

@@ -2319,7 +2325,8 @@ static inline struct f2fs_inode
*F2FS_INODE(const struct folio *folio)

 static inline __le32 *F2FS_INODE_NIDS(const struct folio *folio)
 {
-	return folio_address(folio) + F2FS_BLKSIZE - sizeof(struct node_footer) -
+	return folio_address(folio) + F2FS_BLKSIZE(F2FS_F_SB(folio)) -
+		sizeof(struct node_footer) -
 		SIZE_OF_I_NID;
 }

@@ -2968,7 +2975,7 @@ static inline void *__bitmap_ptr(struct
f2fs_sb_info *sbi, int flag)
 		if (flag == NAT_BITMAP)
 			return tmp_ptr;
 		else
-			return (unsigned char *)ckpt + F2FS_BLKSIZE;
+			return (unsigned char *)ckpt + F2FS_BLKSIZE(sbi);
 	} else {
 		offset = (flag == NAT_BITMAP) ?
 			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6fafb32bc5f2..7001c18da506 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -110,7 +110,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	if (ret & VM_FAULT_LOCKED)
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
-					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
+					APP_MAPPED_READ_IO,
+					F2FS_BLKSIZE(F2FS_I_SB(inode)));

 	trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);

@@ -233,7 +234,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 	folio_mark_dirty(folio);

-	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE(sbi));
 	f2fs_update_time(sbi, REQ_TIME);

 out_sem:
@@ -974,7 +975,7 @@ int f2fs_truncate(struct inode *inode)

 	trace_f2fs_truncate(inode);

-	if (time_to_inject(sbi, FAULT_TRUNCATE))
+	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE))
 		return -EIO;

 	err = f2fs_dquot_initialize(inode);
@@ -1675,7 +1676,8 @@ static int f2fs_collapse_range(struct inode
*inode, loff_t offset, loff_t len)
 		return -EINVAL;

 	/* collapse range should be aligned to block size of f2fs. */
-	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
+	if (offset & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)) ||
+	    len & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)))
 		return -EINVAL;

 	ret = f2fs_convert_inline_inode(inode);
@@ -1890,7 +1892,8 @@ static int f2fs_insert_range(struct inode
*inode, loff_t offset, loff_t len)
 		return -EINVAL;

 	/* insert range should be aligned to block size of f2fs. */
-	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
+	if (offset & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)) ||
+	    len & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)))
 		return -EINVAL;

 	ret = f2fs_convert_inline_inode(inode);
@@ -3193,7 +3196,8 @@ static int f2fs_ioc_defragment(struct file
*filp, unsigned long arg)
 		return -EFAULT;

 	/* verify alignment of offset & size */
-	if (range.start & (F2FS_BLKSIZE - 1) || range.len & (F2FS_BLKSIZE - 1))
+	if (range.start & F2FS_BLKSIZE_MASK(sbi) ||
+	    range.len & F2FS_BLKSIZE_MASK(sbi))
 		return -EINVAL;

 	if (unlikely(F2FS_BYTES_TO_BLK(sbi, range.start + range.len) >
@@ -3279,7 +3283,7 @@ static int f2fs_move_file_range(struct file
*file_in, loff_t pos_in,
 	if (src == dst && pos_out > pos_in && pos_out < pos_in + len)
 		goto out_unlock;
 	if (pos_in + len == src->i_size)
-		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
+		len = ALIGN(src->i_size, F2FS_BLKSIZE(sbi)) - pos_in;
 	if (len == 0) {
 		ret = 0;
 		goto out_unlock;
@@ -3297,9 +3301,9 @@ static int f2fs_move_file_range(struct file
*file_in, loff_t pos_in,
 	}

 	/* verify the end result is block aligned */
-	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||
-			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE) ||
-			!IS_ALIGNED(pos_out, F2FS_BLKSIZE))
+	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE(sbi)) ||
+			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE(sbi)) ||
+			!IS_ALIGNED(pos_out, F2FS_BLKSIZE(sbi)))
 		goto out_unlock;

 	ret = f2fs_convert_inline_inode(src);
@@ -4593,14 +4597,14 @@ static int f2fs_sec_trim_file(struct file
*filp, unsigned long arg)
 		to_end = true;
 	}

-	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
-			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
+	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE(sbi)) ||
+	    (!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE(sbi)))) {
 		ret = -EINVAL;
 		goto err;
 	}

 	index = F2FS_BYTES_TO_BLK(sbi, range.start);
-	pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);
+	pg_end = F2FS_BLK_ALIGN(sbi, end_addr);

 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f15ab07a7347..299d5310e597 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1303,8 +1303,8 @@ static int ra_data_block(struct inode *inode,
pgoff_t index)
 	f2fs_put_page(fio.encrypted_page, false);
 	f2fs_folio_put(folio, true);

-	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
-	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE(sbi));
+	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE(sbi));

 	if (atomic_inode)
 		iput(atomic_inode);
@@ -1424,9 +1424,9 @@ static int move_data_block(struct inode *inode,
block_t bidx,
 		}

 		f2fs_update_iostat(fio.sbi, inode, FS_DATA_READ_IO,
-							F2FS_BLKSIZE);
+						F2FS_BLKSIZE(fio.sbi));
 		f2fs_update_iostat(fio.sbi, NULL, FS_GDATA_READ_IO,
-							F2FS_BLKSIZE);
+						F2FS_BLKSIZE(fio.sbi));

 		folio_lock(mfolio);
 		if (unlikely(!is_meta_folio(mfolio) ||
@@ -1477,7 +1477,8 @@ static int move_data_block(struct inode *inode,
block_t bidx,
 	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_write(&fio);

-	f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO,
+					F2FS_BLKSIZE(fio.sbi));

 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 73cd9b6ddcc5..3e0b9449ffba 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -448,7 +448,7 @@ static int f2fs_move_inline_dirents(struct inode
*dir, struct folio *ifolio,
 	 * Start by zeroing the full block, to ensure that all unused space is
 	 * zeroed and no uninitialized memory is leaked to disk.
 	 */
-	memset(dentry_blk, 0, F2FS_BLKSIZE);
+	memset(dentry_blk, 0, F2FS_BLKSIZE(F2FS_I_SB(dir)));

 	make_dentry_ptr_inline(dir, &src, inline_dentry);
 	make_dentry_ptr_block(dir, &dst, dentry_blk);
@@ -477,8 +477,8 @@ static int f2fs_move_inline_dirents(struct inode
*dir, struct folio *ifolio,
 		F2FS_I(dir)->i_inline_xattr_size = 0;

 	f2fs_i_depth_write(dir, 1);
-	if (i_size_read(dir) < PAGE_SIZE)
-		f2fs_i_size_write(dir, PAGE_SIZE);
+	if (i_size_read(dir) < F2FS_BLKSIZE(F2FS_I_SB(dir)))
+		f2fs_i_size_write(dir, F2FS_BLKSIZE(F2FS_I_SB(dir)));
 out:
 	f2fs_folio_put(folio, true);
 	return err;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b628fdc4198f..b947b724b3bc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -165,7 +165,7 @@ static __u32 f2fs_inode_chksum(struct f2fs_sb_info
*sbi, struct folio *folio)
 	chksum = f2fs_chksum(chksum, (__u8 *)&dummy_cs, cs_size);
 	offset += cs_size;
 	chksum = f2fs_chksum(chksum, (__u8 *)ri + offset,
-			     F2FS_BLKSIZE - offset);
+			     F2FS_BLKSIZE(sbi) - offset);
 	return chksum;
 }

@@ -447,7 +447,7 @@ static int do_read_inode(struct inode *inode)
 	set_nlink(inode, le32_to_cpu(ri->i_links));
 	inode->i_size = le64_to_cpu(ri->i_size);
 	inode->i_blocks = SECTOR_FROM_BLOCK(sbi,
-			le64_to_cpu(ri->i_blocks) - 1);
+					    le64_to_cpu(ri->i_blocks) - 1);

 	inode_set_atime(inode, le64_to_cpu(ri->i_atime),
 			le32_to_cpu(ri->i_atime_nsec));
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e7aa3b790214..8d16715a3aae 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -165,7 +165,7 @@ static struct folio *get_next_nat_folio(struct
f2fs_sb_info *sbi, nid_t nid)

 	src_addr = folio_address(src_folio);
 	dst_addr = folio_address(dst_folio);
-	memcpy(dst_addr, src_addr, PAGE_SIZE);
+	memcpy(dst_addr, src_addr, F2FS_BLKSIZE(sbi));
 	folio_mark_dirty(dst_folio);
 	f2fs_folio_put(src_folio, true);

@@ -1498,7 +1498,8 @@ static int read_node_folio(struct folio *folio,
blk_opf_t op_flags)
 	err = f2fs_submit_page_bio(&fio);

 	if (!err)
-		f2fs_update_iostat(sbi, NULL, FS_NODE_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, NULL, FS_NODE_READ_IO,
+				   F2FS_BLKSIZE(sbi));

 	return err;
 }
@@ -3311,7 +3312,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 			return PTR_ERR(folio);

 		memcpy(nm_i->nat_bits + F2FS_BLK_TO_BYTES(sbi, i),
-					folio_address(folio), F2FS_BLKSIZE);
+					folio_address(folio), F2FS_BLKSIZE(sbi));
 		f2fs_folio_put(folio, true);
 	}

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 6a2b7c63f4a3..32125f8fc753 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -284,7 +284,7 @@ static inline void fill_node_footer(const struct
folio *folio, nid_t nid,
 	unsigned int old_flag = 0;

 	if (reset)
-		memset(rn, 0, F2FS_BLKSIZE);
+		memset(rn, 0, F2FS_BLKSIZE(F2FS_F_SB(folio)));
 	else
 		old_flag = le32_to_cpu(footer->flag);

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f58b26c84b3a..f2641a6080ae 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1316,7 +1316,8 @@ static void __submit_zone_reset_cmd(struct
f2fs_sb_info *sbi,
 	submit_bio(bio);

 	atomic_inc(&dcc->issued_discard);
-	f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO, dc->di.len * F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO,
+			   dc->di.len * F2FS_BLKSIZE(sbi));
 }
 #endif

@@ -1419,7 +1420,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,

 		atomic_inc(&dcc->issued_discard);

-		f2fs_update_iostat(sbi, NULL, FS_DISCARD_IO, len * F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, NULL, FS_DISCARD_IO,
+			   len * F2FS_BLKSIZE(sbi));

 		lstart += len;
 		start += len;
@@ -2797,7 +2799,7 @@ void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
 	if (IS_ERR(folio))
 		return;

-	memcpy(folio_address(folio), src, PAGE_SIZE);
+	memcpy(folio_address(folio), src, F2FS_BLKSIZE(sbi));
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 }
@@ -4152,7 +4154,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info
*sbi, struct folio *folio,
 	f2fs_submit_page_write(&fio);

 	stat_inc_meta_count(sbi, folio->index);
-	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE(sbi));
 }

 void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
@@ -4162,7 +4164,8 @@ void f2fs_do_write_node_page(unsigned int nid,
struct f2fs_io_info *fio)
 	set_summary(&sum, nid, 0, 0);
 	do_write_page(&sum, fio);

-	f2fs_update_iostat(fio->sbi, NULL, fio->io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(fio->sbi, NULL, fio->io_type,
+					F2FS_BLKSIZE(fio->sbi));
 }

 void f2fs_outplace_write_data(struct dnode_of_data *dn,
@@ -4178,7 +4181,8 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);

-	f2fs_update_iostat(sbi, dn->inode, fio->io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, dn->inode, fio->io_type,
+					F2FS_BLKSIZE(sbi));
 }

 int f2fs_inplace_write_data(struct f2fs_io_info *fio)
@@ -4220,7 +4224,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		f2fs_update_device_state(fio->sbi, fio->ino,
 						fio->new_blkaddr, 1);
 		f2fs_update_iostat(fio->sbi, fio_inode(fio),
-						fio->io_type, F2FS_BLKSIZE);
+						fio->io_type, F2FS_BLKSIZE(fio->sbi));
 	}

 	return err;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2275404e769c..2c85c085961b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -116,7 +116,7 @@ f2fs_start_segno(struct f2fs_sb_info *sbi,
unsigned int segno)

 #define SECTOR_FROM_BLOCK(sbi, blk_addr)				\
 	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK(sbi))
-#define SECTOR_TO_BLOCK(sbi, sectors)					\
+#define SECTOR_TO_BLOCK(sbi, sectors)				\
 	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK(sbi))

 /*
@@ -432,7 +432,7 @@ static inline void seg_info_to_sit_folio(struct
f2fs_sb_info *sbi,
 	int i;

 	raw_sit = folio_address(folio);
-	memset(raw_sit, 0, PAGE_SIZE);
+	memset(raw_sit, 0, F2FS_BLKSIZE(sbi));
 	for (i = 0; i < end - start; i++) {
 		rs = &raw_sit->entries[i];
 		se = get_seg_entry(sbi, start + i);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b962c14cbcc1..ca6403a0ed88 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1610,7 +1610,7 @@ static int f2fs_check_opt_consistency(struct
fs_context *fc,
 			return -EINVAL;
 		}
 		min_size = MIN_INLINE_XATTR_SIZE;
-		max_size = MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(F2FS_BLKSIZE);
+		max_size = MAX_INLINE_XATTR_SIZE_FOR_BLOCKSIZE(F2FS_BLKSIZE(sbi));

 		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
 				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
@@ -4079,10 +4079,10 @@ static int sanity_check_raw_super(struct
f2fs_sb_info *sbi,
 	}

 	/* only support block_size equals to PAGE_SIZE */
-	if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS) {
+	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
 		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
 			  le32_to_cpu(raw_super->log_blocksize),
-			  F2FS_BLKSIZE_BITS);
+			  PAGE_SHIFT);
 		return -EFSCORRUPTED;
 	}

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 811e350a1430..aaca9ed9b169 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1871,8 +1871,8 @@ static int __maybe_unused
disk_map_seq_show(struct seq_file *seq,
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;

-	seq_printf(seq, "Address Layout   : %5luB Block address (# of Segments)\n",
-					F2FS_BLKSIZE);
+	seq_printf(seq, "Address Layout   : %5uB Block address (# of Segments)\n",
+		   F2FS_BLKSIZE(sbi));
 	seq_printf(seq, " SB            : %12s\n", "0/1024B");
 	seq_printf(seq, " seg0_blkaddr  : 0x%010x\n", SEG0_BLKADDR(sbi));
 	seq_printf(seq, " Checkpoint    : 0x%010x (%10d)\n",
@@ -1889,13 +1889,13 @@ static int __maybe_unused
disk_map_seq_show(struct seq_file *seq,
 	seq_printf(seq, " Main          : 0x%010x (%10d)\n",
 			SM_I(sbi)->main_blkaddr,
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main));
-	seq_printf(seq, " Block size    : %12lu KB\n", F2FS_BLKSIZE >> 10);
+	seq_printf(seq, " Block size    : %12u KB\n", F2FS_BLKSIZE(sbi) >> 10);
 	seq_printf(seq, " Segment size  : %12d MB\n",
-			(BLKS_PER_SEG(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
+			(BLKS_PER_SEG(sbi) << (F2FS_BLKSIZE_BITS(sbi) - 10)) >> 10);
 	seq_printf(seq, " Segs/Sections : %12d\n",
 			SEGS_PER_SEC(sbi));
 	seq_printf(seq, " Section size  : %12d MB\n",
-			(BLKS_PER_SEC(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
+			(BLKS_PER_SEC(sbi) << (F2FS_BLKSIZE_BITS(sbi) - 10)) >> 10);
 	seq_printf(seq, " # of Sections : %12d\n",
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 99c863513725..98059e583b09 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -850,4 +850,4 @@ int __init f2fs_init_xattr_cache(void)
 void f2fs_destroy_xattr_cache(void)
 {
 	kmem_cache_destroy(inline_xattr_slab);
-}
\ No newline at end of file
+}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f622d26f37a7..957bb713ff24 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -14,12 +14,9 @@
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
-#define F2FS_LOG_SECTORS_PER_BLOCK(sbi)	((sbi)->log_blocksize - 9) /*
log number for sector/blk */
 #define F2FS_MIN_LOG_BLOCKSIZE		12
 #define F2FS_MIN_BLKSIZE		4096UL
-#define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
 #define F2FS_MAX_BLKSIZE		PAGE_SIZE
-#define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */

@@ -27,15 +24,19 @@
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */

-#define F2FS_BLKSIZE_MASK		(F2FS_BLKSIZE - 1)
+#define F2FS_BLKSIZE(sbi)		((sbi)->blocksize)
+#define F2FS_BLKSIZE_BITS(sbi)		((sbi)->log_blocksize)
+#define F2FS_BLKSIZE_MASK(sbi)		(F2FS_BLKSIZE(sbi) - 1)
+#define F2FS_LOG_SECTORS_PER_BLOCK(sbi)	(F2FS_BLKSIZE_BITS(sbi) - 9)
+#define F2FS_BLKS_PER_PAGE(sbi)		(PAGE_SIZE / F2FS_BLKSIZE(sbi))
 #define F2FS_BYTES_TO_BLK(sbi, bytes)					\
-	((unsigned long long)(bytes) >> (sbi)->log_blocksize)
+	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS(sbi))
 #define F2FS_BLK_TO_BYTES(sbi, blk)					\
-	((unsigned long long)(blk) << (sbi)->log_blocksize)
+	((unsigned long long)(blk) << F2FS_BLKSIZE_BITS(sbi))
 #define F2FS_BLK_END_BYTES(sbi, blk)					\
 	(F2FS_BLK_TO_BYTES(sbi, (blk) + 1) - 1)
 #define F2FS_BLK_ALIGN(sbi, x)						\
-	DIV_ROUND_UP_ULL((x), (sbi)->blocksize)
+	DIV_ROUND_UP_ULL((x), F2FS_BLKSIZE(sbi))

 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
@@ -221,7 +222,6 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[];
 } __packed;

-#define CP_CHKSUM_OFFSET	(F2FS_BLKSIZE - sizeof(__le32))	/* default
chksum offset in checkpoint */
 #define CP_MIN_CHKSUM_OFFSET						\
 	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))

@@ -271,7 +271,7 @@ struct node_footer {
 } __packed;

 /* Address Pointers in an Inode */
-#define DEF_ADDRS_PER_INODE	((F2FS_BLKSIZE - OFFSET_OF_END_OF_I_EXT	\
+#define DEF_ADDRS_PER_INODE	((PAGE_SIZE - OFFSET_OF_END_OF_I_EXT	\
 					- SIZE_OF_I_NID	\
 					- sizeof(struct node_footer)) / sizeof(__le32))
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
@@ -279,10 +279,10 @@ struct node_footer {
 #define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
 #define ADDRS_PER_INODE(inode)	addrs_per_page(inode, true)
 /* Address Pointers in a Direct Block */
-#define DEF_ADDRS_PER_BLOCK	((F2FS_BLKSIZE - sizeof(struct
node_footer)) / sizeof(__le32))
+#define DEF_ADDRS_PER_BLOCK	((PAGE_SIZE - sizeof(struct node_footer))
/ sizeof(__le32))
 #define ADDRS_PER_BLOCK(inode)	addrs_per_page(inode, false)
 /* Node IDs in an Indirect Block */
-#define NIDS_PER_BLOCK		((F2FS_BLKSIZE - sizeof(struct node_footer))
/ sizeof(__le32))
+#define NIDS_PER_BLOCK		((PAGE_SIZE - sizeof(struct node_footer)) /
sizeof(__le32))

 #define ADDRS_PER_PAGE(folio, inode)	(addrs_per_page(inode, IS_INODE(folio)))

-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
