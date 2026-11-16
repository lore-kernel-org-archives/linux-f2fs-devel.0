Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D7606A33B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ESSquoMo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kjWRls/L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KFnxoZOU;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nWwgrSaN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=AvLAAGb0dThRHRigDzbwj/ubrFC+3A0qYtYDgd+ZELU=; b=ESSquoMoVou4f/yLuXgm8oLNQW
	N/R0wcIYqjuUKLPf+uTEHv9Qiv/wj8KuwAl/xGRma6mt621ou/i80jUtNyDvnYDNeohuUd0e5eBVA
	NqfaGoYBX/v/dFU5NgHUAehvd+sqA+sphIKTrcyPumamO9IV0M2HiUSoh7IpL+iXK46c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo1p-000000007ql-1ic5;
	Mon, 16 Nov 2026 04:09:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo1m-000000007qd-1T7E
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ni4OGtBntQFfDiHFAh2+umVCtkXEiVh2XmKbvv86p/c=; b=kjWRls/L3HzHwejDEJ0HDSa9cb
 0vMBNMpHlxro3fV8L4gRNo1dUzYRV/7fBugGLBpKYJAQWcgnswZxl4qEry31wQeKZrqaxhCieahVY
 aGREWB0McOMy4Z+OaOG69uOZ8ry7g2/ppULj325E5NFQYMexDFNaJ/lyg6DvSv0AYZaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ni4OGtBntQFfDiHFAh2+umVCtkXEiVh2XmKbvv86p/c=; b=KFnxoZOU/xQYpdIcgBB5F1tlJf
 juYCY7HyG4ofm+reU3i4SJ6UJQbCza1MYWOIsE7efr522J2y3JdjAa2nY6YxPhjgYQApg5Y0YAjsq
 mANPuyO2tgfNG265pgt7lNfqeAHmc3gpYEfdjDmEhK4gMHe3fPvlMFvAtv0TFf55GjLI=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1k-000000007br-3zVS
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:10 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3b1535be329so2233607a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802143; x=1795406943; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ni4OGtBntQFfDiHFAh2+umVCtkXEiVh2XmKbvv86p/c=;
 b=nWwgrSaNnvVoyeSAHng1H7ZZ+UulMnr+JjfVtywm5z237bBEy3zNqwIVQpi3zjUXhw
 tZd3liUe+G00dMyt+Q88YgWaC2wukGB/gd6waqq8ceS20jciqjVndPNPWJ2iTmejFkIs
 fCTrJSjOtW2UPd/Ow6bm+QMo2HduMe9DYg2SNU08p42rWjWgXyt4RTWtJzXHV5Ce7Jig
 CJw/CmSok1Ct1gqoMBflZUXvdJvPt/k9+yEefsyHRtGzsAVdb9FJIbgoJO3ZgqphT7bn
 0Jehzvh1kw20P1rmYFmb9fbABt6IH2Lzpt0Y49CZ+lFx2jYIEm1zOCJKWCD6dyT6W2Tq
 QbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802143; x=1795406943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ni4OGtBntQFfDiHFAh2+umVCtkXEiVh2XmKbvv86p/c=;
 b=1F27DOxOap+e22meHZNMLLcRsfnbYapCiviKXAlrrUWlF7YH8yWcZxtkZCKBlkMzs0
 +szgTspO84C8l+pID8YuIJzIMm31VltxyIVimMzb1IwmTLOpUrVcPtJemACYgQ6gNFVB
 fTpwBIHmiaPtE2VOjjeWnTvxuyYy7Az7BtcEwBNmlWJoF5sEXIQ9Bkwxngk/ZEAfszj0
 XOhcPICZ/XyHLjB6tUTV3llci0Bf/ltQGce49AdsX+bLLHPPQOeoevpeX08ef0darlQG
 DS+kteSDmzvMIpwRto1Ay5Ji+flFFQUh6r3B9tZP+Ai4bcZZ282rGzzO6LoiLLVh+xkH
 qskg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZbKndyQHp20D+zOYv5lUiVaXXcrOpUU9ny+uVO/IuvSI5mvDzsZarWHuwfrCIoqPnbS6xyS+Awn8HovFQrtPe@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/7JHpFQn6bWmCsmZEVYzKBBMhnQVF/pde/PHMRvF5cpq3n5i5g
 rMnHIV7HfpqLhpSxNSy6f1FU6ti8RDWg/qQOGtca85ywv8BkAWbn6mpH9zgffw==
X-Gm-Gg: AYBFou3noBXRYmW/ZtFhKyOULaA2BwSc2MNPa/WtH8OMwWMnNy2DiU+Rc16cy6/q87o
 BJMHRFmaxm4YZD6G8lDj/3FBUoKPvccAnI5iVExLBKoildmED9GLyfNpTgLzgsKJQGnfl5uWyqN
 gKt36nueoOA0mZwfmpfrwq8rBK1S+r4UlZYIjtjqHN2PClEPsGaW5EnYT6y/bgbEfxnDcop9MJp
 n43FZDrldoKtC3I2lSaX7oV9DB7H+ejAtdYD/Qnz5SY7XBJiV1Oc/b2UKHzVaNXPb2WaN6kHHN2
 GZgn7FXsShAtHt/SJtzrPSk/l7HpisV8XWYBt4Lye8z1FGtRbWhe9EW9bZ1qPB6vaEJhbmjLzDY
 ypZWDRm0/PjEjxHxmYi4LwSOQG5hLb7Nk6obfNvh1WnHF2yojJ67X5SowjnW+5S4ERncTz74ilG
 NzJcgYj3IRnnucXOPFYLa3Obi5G6bozg47VgdIKcaCQY89i7MMr6Kn/PzgTIMKlTv6KCW2NZmX9
 ubc9DLtnK/w6eG5U85dPhR70ngISDo1ri1HYYqXva4BHDvsQFRWZ7D5vdUG+NSBVC79OPUa6Qz8
 PkjhnHT4e+wbTlb73fYczYnCvRjdrUgbggO+M2hoZxXVyU5P1q3Qu6jonAtBqQUlz229S4stJzF
 VHGTlWOU0zHOVsC+7OJEadcSPIn39G8sZ+xBOKWIfuXvPXOPULN5gwXTl2wOC4rIOknj4
X-Received: by 2002:a17:90b:5105:b0:3ac:a5ff:2cc3 with SMTP id
 98e67ed59e1d1-3b1b081ad46mr9077275a91.8.1794802143010; 
 Sun, 15 Nov 2026 20:09:03 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:00 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:33 -0800
Message-ID: <20261116040851.2849696-3-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1k-000000007br-3zVS
Subject: [f2fs-dev] [PATCH v2 02/20] f2fs: support subpage block size
 superblock and mount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Add the infrastructure to mount F2FS with a block size smaller than
PAGE_SIZE, e.g. 4KB blocks on a 16KB page kernel.

- Add helpers to convert between block indices, folio indices and
  offsets within a folio.
- Take the block size from the 1st superblock, which is at the same
  offset for every block size. If it is invalid, probe the 2nd
  superblock with each supported block size from the smallest, and
  stop at the first one found, even if it is invalid, so that a stale
  superblock of a larger block size is not picked.
- Allow log_blocksize up to PAGE_SHIFT, and write back only the target
  superblock block instead of the whole folio.
- Bound log_sectorsize by log_blocksize, so that
  log_sectors_per_block + log_sectorsize cannot wrap around, and remove
  F2FS_MAX_LOG_SECTOR_SIZE, which has no user left.
- Check the requested inline_xattr_size, not the current one,
  against the block size in f2fs_check_opt_consistency().
- Keep rejecting subpage block sizes, and return -EOPNOTSUPP for the
  features that do not support them yet. Later patches add the support
  and lift these restrictions.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c      |   2 +
 fs/f2fs/f2fs.h          |  61 +++++++++++---
 fs/f2fs/file.c          |  42 ++++++++++
 fs/f2fs/super.c         | 178 +++++++++++++++++++++++++++++-----------
 fs/f2fs/verity.c        |   3 +
 include/linux/f2fs_fs.h |   2 +-
 6 files changed, 226 insertions(+), 62 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c7910688c318..0b0f31af6626 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -550,6 +550,8 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 {
 	if (!f2fs_compressed_file(inode))
 		return true;
+	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
+		return false;
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50a5f845176d..3f83d01489d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1372,11 +1372,11 @@ struct f2fs_io_info {
 };
 
 #define F2FS_FIO_LBLK(fio)						\
-	(((fio)->folio)->index + (fio)->folio_offset)
+	(f2fs_folio_lblk((fio)->sbi, (fio)->folio) + (fio)->folio_offset)
 #define F2FS_FIO_BLKCNT(fio)						\
 	((fio)->folio_blkcnt)
 #define F2FS_FIO_BIO_OFFSET(fio)					\
-	((fio)->folio_offset << PAGE_SHIFT)
+	F2FS_BLK_TO_BYTES((fio)->sbi, (fio)->folio_offset)
 #define F2FS_FIO_BIO_SIZE(fio)					\
 	F2FS_BLK_TO_BYTES((fio)->sbi, F2FS_FIO_BLKCNT(fio))
 
@@ -2326,19 +2326,59 @@ static inline void make_dentry_ptr_block(struct inode *inode,
 					SIZE_OF_DIR_ENTRY * entries;
 }
 
+static inline unsigned int f2fs_blocks_per_folio(struct f2fs_sb_info *sbi,
+						 const struct folio *folio)
+{
+	return F2FS_BYTES_TO_BLK(sbi, folio_size(folio));
+}
+
+static inline bool f2fs_has_subpage_blocks(struct f2fs_sb_info *sbi)
+{
+	return F2FS_BLKSIZE(sbi) < PAGE_SIZE;
+}
+
+static inline pgoff_t f2fs_folio_lblk(struct f2fs_sb_info *sbi,
+				      const struct folio *folio)
+{
+	return F2FS_BYTES_TO_BLK(sbi, folio_pos(folio));
+}
+
+static inline pgoff_t f2fs_lblk_to_folio_index(struct f2fs_sb_info *sbi,
+					       pgoff_t index)
+{
+	return F2FS_BLK_TO_BYTES(sbi, index) >> PAGE_SHIFT;
+}
+
+static inline pgoff_t f2fs_folio_blk_offset(struct f2fs_sb_info *sbi,
+					     const struct folio *folio,
+					     pgoff_t index)
+{
+	return index - f2fs_folio_lblk(sbi, folio);
+}
+
+static inline size_t f2fs_folio_byte_offset(struct f2fs_sb_info *sbi,
+					     const struct folio *folio,
+					     pgoff_t index)
+{
+	return F2FS_BLK_TO_BYTES(sbi, f2fs_folio_blk_offset(sbi, folio, index));
+}
+
+static inline void *f2fs_folio_lblk_address(struct f2fs_sb_info *sbi,
+					    struct folio *folio, pgoff_t index)
+{
+	return folio_address(folio) + f2fs_folio_byte_offset(sbi, folio, index);
+}
+
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_super_block *)(sbi->raw_super);
 }
 
-static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio,
-								pgoff_t index)
+static inline struct f2fs_super_block *
+F2FS_SUPER_BLOCK(struct f2fs_sb_info *sbi, struct folio *folio, pgoff_t index)
 {
-	pgoff_t idx_in_folio = index % folio_nr_pages(folio);
-
 	return (struct f2fs_super_block *)
-		(page_address(folio_page(folio, idx_in_folio)) +
-						F2FS_SUPER_OFFSET);
+		(f2fs_folio_lblk_address(sbi, folio, index) + F2FS_SUPER_OFFSET);
 }
 
 static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
@@ -3905,11 +3945,10 @@ static inline bool f2fs_is_time_consistent(struct inode *inode)
 
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	bool ret;
 
 	if (dsync) {
-		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
 		spin_lock(&sbi->inode_lock[DIRTY_META]);
 		ret = list_empty(&F2FS_I(inode)->gdirty_list);
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
@@ -3917,7 +3956,7 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 	}
 	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
 			file_keep_isize(inode) ||
-			i_size_read(inode) & ~PAGE_MASK)
+			i_size_read(inode) & F2FS_BLKSIZE_MASK(sbi))
 		return false;
 
 	if (!f2fs_is_time_consistent(inode))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f8a444064ec8..5a6f0ff9f377 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2207,6 +2207,15 @@ static long f2fs_fallocate(struct file *file, int mode,
 		goto out;
 	}
 
+	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
+		if ((mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) ||
+		    f2fs_is_pinned_file(inode) || f2fs_is_atomic_file(inode) ||
+		    f2fs_compressed_file(inode)) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+	}
+
 	ret = file_modified(file);
 	if (ret)
 		goto out;
@@ -2455,6 +2464,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	loff_t isize;
 	int ret;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
@@ -3262,6 +3274,9 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	struct f2fs_defragment range;
 	int err;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -3484,6 +3499,9 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 {
 	struct f2fs_move_range range;
 
+	if (f2fs_has_subpage_blocks(F2FS_I_SB(file_inode(filp))))
+		return -EOPNOTSUPP;
+
 	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
@@ -3734,6 +3752,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin;
 	int ret = 0;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (get_user(pin, (__u32 __user *)arg))
 		return -EFAULT;
 
@@ -4114,6 +4135,9 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 block_count;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -4131,6 +4155,9 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
+	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
+		return -EOPNOTSUPP;
+
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
@@ -4311,6 +4338,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	int ret;
 	int writecount;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
@@ -4506,6 +4536,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	unsigned int reserved_blocks = 0;
 	int ret;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
@@ -4827,6 +4860,9 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	struct f2fs_comp_option option;
 	int ret = 0;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
@@ -4965,6 +5001,9 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	pgoff_t page_idx = 0, last_idx, cluster_idx;
 	int ret;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
 		return -EOPNOTSUPP;
@@ -5046,6 +5085,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	pgoff_t page_idx = 0, last_idx, cluster_idx;
 	int ret;
 
+	if (f2fs_has_subpage_blocks(sbi))
+		return -EOPNOTSUPP;
+
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78dbf1e92285..f17bae198fe5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1613,8 +1613,8 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 		min_size = MIN_INLINE_XATTR_SIZE;
 		max_size = MAX_INLINE_XATTR_SIZE(F2FS_BLKSIZE(sbi));
 
-		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
-				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
+		if (F2FS_CTX_INFO(ctx).inline_xattr_size < min_size ||
+				F2FS_CTX_INFO(ctx).inline_xattr_size > max_size) {
 			f2fs_err(sbi, "inline xattr size is out of range: %d ~ %d",
 				 min_size, max_size);
 			return -EINVAL;
@@ -4000,7 +4000,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 	folio_lock(folio);
 	folio_wait_writeback(folio);
 	if (update)
-		memcpy(F2FS_SUPER_BLOCK(folio, index), F2FS_RAW_SUPER(sbi),
+		memcpy(F2FS_SUPER_BLOCK(sbi, folio, index), F2FS_RAW_SUPER(sbi),
 					sizeof(struct f2fs_super_block));
 	folio_mark_dirty(folio);
 	folio_clear_dirty_for_io(folio);
@@ -4010,9 +4010,10 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
 
 	/* it doesn't need to set crypto context for superblock update */
-	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, folio->index);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, index);
 
-	if (!bio_add_folio(bio, folio, folio_size(folio), 0))
+	if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(sbi),
+			   f2fs_folio_byte_offset(sbi, folio, index)))
 		f2fs_bug_on(sbi, 1);
 
 	ret = submit_bio_wait(bio);
@@ -4025,7 +4026,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t index)
 {
-	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(folio, index);
+	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(sbi, folio, index);
 	struct super_block *sb = sbi->sb;
 	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
 	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
@@ -4107,11 +4108,13 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 			res = "internally";
 		} else {
 			/*
-			 * __f2fs_commit_super() will access log_blocksize
-			 * in SECTOR_FROM_BLOCK(), init it in advance.
+			 * __f2fs_commit_super() will access log_blocksize and
+			 * blocksize to locate the superblock, init them in
+			 * advance.
 			 */
 			sbi->log_blocksize =
 				le32_to_cpu(raw_super->log_blocksize);
+			sbi->blocksize = BIT(sbi->log_blocksize);
 			err = __f2fs_commit_super(sbi, folio, index, false);
 			res = err ? "failed" : "done";
 		}
@@ -4129,7 +4132,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 {
 	block_t segment_count, segs_per_sec, secs_per_zone, segment_count_main;
 	block_t total_sections, blocks_per_seg;
-	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(folio, index);
+	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(sbi, folio, index);
 	size_t crc_offset = 0;
 	__u32 crc = 0;
 
@@ -4155,14 +4158,23 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	/* only support block_size equals to PAGE_SIZE */
-	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
-		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
+	/* Keep one or more filesystem blocks in each base-page folio. */
+	if (le32_to_cpu(raw_super->log_blocksize) <
+			F2FS_MIN_LOG_BLOCKSIZE ||
+			le32_to_cpu(raw_super->log_blocksize) > F2FS_MAX_LOG_BLOCKSIZE) {
+		f2fs_info(sbi, "Invalid log_blocksize (%u), supports %u..%u",
 			  le32_to_cpu(raw_super->log_blocksize),
-			  PAGE_SHIFT);
+			  F2FS_MIN_LOG_BLOCKSIZE, F2FS_MAX_LOG_BLOCKSIZE);
 		return -EFSCORRUPTED;
 	}
 
+	/* Subpage block size is enabled after all paths support it. */
+	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
+		f2fs_info(sbi, "Subpage block size (%u) is not supported yet",
+			  le32_to_cpu(raw_super->log_blocksize));
+		return -EOPNOTSUPP;
+	}
+
 	/* check log blocks per segment */
 	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
 		f2fs_info(sbi, "Invalid log blocks per segment (%u)",
@@ -4172,7 +4184,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 
 	/* Currently, support 512/1024/2048/4096/16K bytes sector size */
 	if (le32_to_cpu(raw_super->log_sectorsize) >
-				F2FS_MAX_LOG_SECTOR_SIZE ||
+				le32_to_cpu(raw_super->log_blocksize) ||
 		le32_to_cpu(raw_super->log_sectorsize) <
 				F2FS_MIN_LOG_SECTOR_SIZE) {
 		f2fs_info(sbi, "Invalid log sectorsize (%u)",
@@ -4181,7 +4193,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	}
 	if (le32_to_cpu(raw_super->log_sectors_per_block) +
 		le32_to_cpu(raw_super->log_sectorsize) !=
-			F2FS_MAX_LOG_SECTOR_SIZE) {
+			le32_to_cpu(raw_super->log_blocksize)) {
 		f2fs_info(sbi, "Invalid log sectors per block(%u) log sectorsize(%u)",
 			  le32_to_cpu(raw_super->log_sectors_per_block),
 			  le32_to_cpu(raw_super->log_sectorsize));
@@ -4697,6 +4709,61 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 }
 #endif
 
+static int check_super_block(struct f2fs_sb_info *sbi,
+			     struct f2fs_super_block *super,
+			     int block, int *valid_super_block,
+			     struct f2fs_super_block **raw_super)
+{
+	struct folio *folio;
+	int err;
+
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
+				   f2fs_lblk_to_folio_index(sbi, block), NULL);
+	if (IS_ERR(folio)) {
+		f2fs_err(sbi, "Unable to read %dth superblock", block + 1);
+		return PTR_ERR(folio);
+	}
+
+	if (block) {
+		struct f2fs_super_block *raw =
+				F2FS_SUPER_BLOCK(sbi, folio, block);
+		bool magic_ok = le32_to_cpu(raw->magic) == F2FS_SUPER_MAGIC;
+		u32 log_bs = le32_to_cpu(raw->log_blocksize);
+
+		/* Skip unmatched magic during probing to avoid noisy logs */
+		if (!*raw_super && !magic_ok) {
+			err = -ENOENT;
+			goto out_put;
+		}
+
+		/*
+		 * The 2nd superblock was located with sbi->log_blocksize.
+		 * Check it before sanity_check_raw_super(), which may write
+		 * the superblock back with its own log_blocksize. Leave an
+		 * unmatched magic for sanity_check_raw_super() to report.
+		 */
+		if (magic_ok && log_bs != sbi->log_blocksize) {
+			f2fs_info(sbi, "Mismatched log_blocksize (%u) in 2nd superblock, expected %u",
+				  log_bs, sbi->log_blocksize);
+			err = -EFSCORRUPTED;
+			goto out_put;
+		}
+	}
+
+	err = sanity_check_raw_super(sbi, folio, block);
+	if (!err && !*raw_super) {
+		memcpy(super, F2FS_SUPER_BLOCK(sbi, folio, block),
+		       sizeof(*super));
+		*valid_super_block = block;
+		*raw_super = super;
+		sbi->log_blocksize = le32_to_cpu(super->log_blocksize);
+		sbi->blocksize = BIT(sbi->log_blocksize);
+	}
+out_put:
+	folio_put(folio);
+	return err;
+}
+
 /*
  * Read f2fs raw super block.
  * Because we have two copies of super block, so read both of them
@@ -4707,52 +4774,54 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			struct f2fs_super_block **raw_super,
 			int *valid_super_block, int *recovery)
 {
-	struct super_block *sb = sbi->sb;
-	int block;
-	struct folio *folio;
 	struct f2fs_super_block *super;
-	int err = 0;
+	int log_bs, err, ret, err2 = -ENOENT;
 
 	super = kzalloc_obj(struct f2fs_super_block);
 	if (!super)
 		return -ENOMEM;
 
-	for (block = 0; block < 2; block++) {
-		folio = read_mapping_folio(sb->s_bdev->bd_mapping, block, NULL);
-		if (IS_ERR(folio)) {
-			f2fs_err(sbi, "Unable to read %dth superblock",
-				 block + 1);
-			err = PTR_ERR(folio);
-			*recovery = 1;
-			continue;
-		}
+	/* 1. Read 1st superblock (block 0) */
+	err = check_super_block(sbi, super, 0, valid_super_block, raw_super);
+	if (err) {
+		f2fs_err(sbi, "Can't find valid F2FS filesystem in 1st superblock");
+		*recovery = 1;
+	}
 
-		/* sanity checking of raw super */
-		err = sanity_check_raw_super(sbi, folio, block);
-		if (err) {
-			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
-				 block + 1);
-			folio_put(folio);
+	/* 2. Read 2nd superblock (block 1) */
+	if (*raw_super) {
+		if (check_super_block(sbi, super, 1, valid_super_block, raw_super)) {
+			f2fs_err(sbi, "Can't find valid F2FS filesystem in 2nd superblock");
 			*recovery = 1;
-			continue;
 		}
-
-		if (!*raw_super) {
-			memcpy(super, F2FS_SUPER_BLOCK(folio, block),
-							sizeof(*super));
-			*valid_super_block = block;
-			*raw_super = super;
+	} else {
+		for (log_bs = F2FS_MIN_LOG_BLOCKSIZE;
+		     log_bs <= F2FS_MAX_LOG_BLOCKSIZE; log_bs++) {
+			sbi->log_blocksize = log_bs;
+			sbi->blocksize = BIT(log_bs);
+			ret = check_super_block(sbi, super, 1, valid_super_block,
+						raw_super);
+			if (!ret)
+				break;
+			/* A 2nd superblock was found: do not probe larger blocks. */
+			if (ret != -ENOENT) {
+				err2 = ret;
+				break;
+			}
 		}
-		folio_put(folio);
+		if (!*raw_super)
+			f2fs_err(sbi, "Can't find valid F2FS filesystem in 2nd superblock");
 	}
 
-	/* No valid superblock */
-	if (!*raw_super)
+	/*
+	 * No valid superblock: return the error of the 2nd superblock if one
+	 * was found, or the error of the 1st superblock otherwise.
+	 */
+	if (!*raw_super) {
 		kfree(super);
-	else
-		err = 0;
-
-	return err;
+		return err2 != -ENOENT ? err2 : err;
+	}
+	return 0;
 }
 
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
@@ -4777,7 +4846,8 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 
 	/* write back-up superblock first */
 	index = sbi->valid_super_block ? 0 : 1;
-	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping, index, NULL);
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
+				f2fs_lblk_to_folio_index(sbi, index), NULL);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	err = __f2fs_commit_super(sbi, folio, index, true);
@@ -4789,7 +4859,8 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 
 	/* write current valid superblock */
 	index = sbi->valid_super_block;
-	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping, index, NULL);
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
+				f2fs_lblk_to_folio_index(sbi, index), NULL);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	err = __f2fs_commit_super(sbi, folio, index, true);
@@ -5263,6 +5334,13 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	mutex_init(&sbi->flush_lock);
 
+	/*
+	 * The 1st superblock is at F2FS_SUPER_OFFSET of block 0 for every
+	 * block size, so locate it with the minimum supported block size.
+	 */
+	sbi->log_blocksize = F2FS_MIN_LOG_BLOCKSIZE;
+	sbi->blocksize = F2FS_MIN_BLKSIZE;
+
 	err = read_raw_super_block(sbi, &raw_super, &valid_super_block,
 								&recovery);
 	if (err)
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4a2cea4288f9..af1b7f21c1d8 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -94,6 +94,9 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int err;
 
+	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
+		return -EOPNOTSUPP;
+
 	if (f2fs_verity_in_progress(inode))
 		return -EBUSY;
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 3081702b1ddb..4007f54d7db4 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -13,8 +13,8 @@
 
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
-#define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
 #define F2FS_MIN_LOG_BLOCKSIZE		12
+#define F2FS_MAX_LOG_BLOCKSIZE		PAGE_SHIFT
 #define F2FS_MIN_BLKSIZE		4096UL
 #define F2FS_MAX_BLKSIZE		PAGE_SIZE
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
