Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FABBC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdsU8IYnyzDkXW6po5ZAg0VplZdgVzvnAkEWhw8l/FY=; b=PBw232+88N/gw4sNc2+ClGZGUb
	wMsx8BwG7WWz+te3Wx2qgLxvFX3NIlZkWhNl8hq40Len5mhCSGmFrc1lfbin29pfxD4spo1AkH4+U
	DpPYLb5v/KeESoQuoMVXxRVE64Eqao06upadPo8+JA+gdJd1nssKIx2BKoRonSSsX/YI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0NBu-0002aL-Gj;
	Sat, 29 Aug 2026 17:50:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0NBo-0002YO-SQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c8moUB83P+kp5KmjBYVfuFkLyzF/rET/Hv2+K65l3kk=; b=mQyJE9nzJ02Wf/gWXFW+AxRb5N
 cV934WUjMBf21MONHxCpY3qh9Xl9eKpsLkvpO2UjBhrGcBZiBDgF1heWNcKRHEgyQM7zLgLPfZJS9
 APYWqurAiHw7iGHFLuuXQHsZ3U0EsqK+5ZqxrV/XmgPr1Q1qgdy8B5iL2OeHL110io9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c8moUB83P+kp5KmjBYVfuFkLyzF/rET/Hv2+K65l3kk=; b=ImSkJ6JpYkxwIbi+eSsIH5f1Hh
 JEM/iCvnTojlfAHE+9NRRrhigPuzKaMPnVAqmxvBJiSHU+ox/+bXGYW+lcIqLIMAsVTqno3ih6no6
 Ke2wgLnRJM5n/IaPEUi1KvopPx82hU51Yy3EvxnmLlJ1ERmIUtk/JI/evEg3PMQ9R3m4=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0NBV-0001EV-E8 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:49:44 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so2381122a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 10:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788025775; cv=none;
 d=google.com; s=arc-20260327;
 b=FaNfqGPJS5ZN6URCVqdy8JfWAAm2xSBFpq5VliRr/Yq7SWk+WEjnpublTjBqS2LQdI
 nQSLT9LBGvNb237A1evRT1Skij4npiIYlJpCa4ND65fT3TChbTJc0g8FaBI9Km7XPdmr
 6RyDUn0mnGElGCdow40H1BbIjSNgO2Xw6pcWIN68c9NjpNxcnx9ncXo3qcP5qfO93Hq6
 ZR+nwd1xpsunhW1pgkZCGl/qamk/FLZuaMq3VqrBQ+BFj8t74qxKo8xP9t6FYmzvmjNU
 6BX4XST+1QjRg8iDWeNVVjohWQ/J7yzo9dwSmCOmOFpkQ1sNR75fBZ4GcqF2iBBaAVXF
 aJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=c8moUB83P+kp5KmjBYVfuFkLyzF/rET/Hv2+K65l3kk=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=If0wp5YsbfezfpA5wWC9XvfeSXqnhA/R6QClUkQ0iQh0jiQONtEvd3XShaiyCaFfgI
 j1ml4hJRLp7UzhZFY7CYbVKEUNe44zVcwB3mQYgi8LBv0uJVf0ATZSZ35Fx9YgViMz0I
 IlHUtsUe9hQvnMi7N0riX/sVDWjhlc3U9Bve4yH4XlTecZUUy898kxDn6NH/AVrPicd1
 5+MEzoQh6ku6IWKzbhacl8uQsS5/KrwgIKy014iv9/gByJjcfGitpI7we7wj15VY3w3o
 jN0w3/VdjMxFEjgApBGulm4IoZo+q42LnVQNMjiyiKKhkFGkG58xza3B1hGsWSGyEfHL
 Ntow==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788025775; x=1788630575; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c8moUB83P+kp5KmjBYVfuFkLyzF/rET/Hv2+K65l3kk=;
 b=AYrYuyvavAxQr0A8fEiLsbiwpRHbXOnNeuz4uajnzMAZdirD1ZnYRiqSm8ymXnBlds
 ZnRlLss+Ht+3yZa4MmRdgZpk+yftHKJza8VReYv23vcFmegIYtHYYSiWzKBs72F/cpBk
 EBVFdYf9Nvuz7ZSBQ/byxVUkqfIVN+40mz0ESobqgB9ygl1Q3APcEsjARU15Q6OFH1L0
 uFSpIZBTyo1HI8mc2zUHeHl6LQrVe4XsHS+5fNaFLk0wqHyUWSh1N+de+wnXRWfmbaNs
 z/HbKvX4JkRIFekak+7Fn5DTdOOt/OhMXOR/JbG7ze3f+cSn8uZvTHh6+qwknV0/tbzZ
 jerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788025775; x=1788630575;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c8moUB83P+kp5KmjBYVfuFkLyzF/rET/Hv2+K65l3kk=;
 b=Dh8IP0i3YBh135YdzEJGBouz5pe3KYz+nAZxhEMe+BbrGNDGC7n+mD4BQTPhqBkIUd
 mmeXDyu8vPah6kvYIHfaazrsmdWH5uF2941C0g4qxOYBzlPIW7yZUxTrDOk8oAfDuL3i
 mWqYJ/Un8PO/G06+jo0tAWpThQVS7moISnsJfvo3cSffJEtfmcfufxzW0/PBPVJHSG3n
 CPLt8mbsgJUy/TgxEmE41vRuH968NX32vbGAqPvYRSXFDoM+R9EcAjsRvduEaBdk1b/b
 qS6xKUd6Jij4J10Be9i8uovZSiH2oOOVyStD7MDHn0/2G2Ob4aLNuenNiSepRkuk8pGG
 7vAA==
X-Gm-Message-State: AFuF++krMnkcxXKjasknf9CWZqMEetFwGF/9O1OtDqUoVvyCM8oGBgvo
 rTinP769tZKx1zltrUqr9i0+WDUPmZtGTYURfDwDLYVg4+wuv2vkAOGB4FB6wA0METZGey1BCwQ
 yjwQMDoOHHsDCwcsbJwotYHwjbqLAcELrSpJJgLg=
X-Gm-Gg: AYBFou1K9R4q0C6N7LoAqTQyDq9TiuWbRrF3KkwU1jT2swM8f8W9ipA8EtBM7AdZuR8
 x50oi/4y40YTgQGAyNCcZvDZ0eb9uNOzjrBsUdASn0t+mpyRedbT/4HW44H4V6wQNBNQQFg5/n+
 aqG9DcGroPOIcWj6mAYNyisU2jldgp0tWw+opgiGt7e+ZKwA1nNeDkyrfZ0Un1BUzoFwvtL9wr7
 RKGx6xXIoNtXjYeYF91pulo+dkpebM/yqddpiAhY8tPNKW1E7gKw2iwDTRHdcJe2K3zzdwTD4/Z
 J33YwKgRLLhQkRpM1xBPyfvSWx5FEYraCkMt2Lfrobu5gk2088BDEDwN4bfwxDV8P6woUby4M1U
 TxvU=
X-Received: by 2002:a05:6402:a6d2:10b0:6a6:1719:3f42 with SMTP id
 4fb4d7f45d1cf-6a6171940bcmr5519070a12.6.1788025774643; Sat, 29 Aug 2026
 10:49:34 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:33 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:33 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
References: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
Date: Sat, 29 Aug 2026 10:49:33 -0700
X-Gm-Features: AcwNN1U6oNO5oJ362powaMyP2M3wJ3wAubS464nVL0S4R0oZoMdglV6MClMJkG8
Message-ID: <CAH=xXfFGDEsnVeZ+NH167rp6wCcEnCi9xhLYrx4+qok+ogKJRg@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0NBV-0001EV-E8
Subject: [f2fs-dev] [PATCH v2 08/11] f2fs: parameterize sector conversion
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

Sector-to-block and block-to-sector conversion helpers previously
assumed a fixed sector count per block derived from 4KB pages.

Parameterize F2FS_LOG_SECTORS_PER_BLOCK, SECTOR_FROM_BLOCK, and
SECTOR_TO_BLOCK with struct f2fs_sb_info *sbi, using
sbi->log_sectors_per_block.

Update all call sites across metadata I/O, data mapping, discard
operations, and zoned block device reporting.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/f2fs.h          |  5 +++--
 fs/f2fs/file.c          |  4 ++--
 fs/f2fs/inode.c         | 11 +++++++----
 fs/f2fs/segment.c       | 14 +++++++-------
 fs/f2fs/segment.h       |  8 ++++----
 fs/f2fs/super.c         | 10 +++++-----
 include/linux/f2fs_fs.h |  2 +-
 8 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 751b7a457d9a..44e1ae43565e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -466,7 +466,7 @@ struct block_device *f2fs_target_device(struct
f2fs_sb_info *sbi,
 	}

 	if (sector)
-		*sector = SECTOR_FROM_BLOCK(blk_addr);
+		*sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
 	return bdev;
 }

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 247e56522441..b90c5a42703f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2609,7 +2609,8 @@ static inline int F2FS_HAS_BLOCKS(struct inode *inode)
 {
 	block_t xattr_block = F2FS_I(inode)->i_xattr_nid ? 1 : 0;

-	return (inode->i_blocks >> F2FS_LOG_SECTORS_PER_BLOCK) > xattr_block;
+	return (inode->i_blocks >>
+		F2FS_LOG_SECTORS_PER_BLOCK(F2FS_I_SB(inode))) > xattr_block;
 }

 static inline bool f2fs_has_xattr_block(unsigned int ofs)
@@ -2815,7 +2816,7 @@ static inline void dec_valid_block_count(struct
f2fs_sb_info *sbi,
 						struct inode *inode,
 						block_t count)
 {
-	blkcnt_t sectors = count << F2FS_LOG_SECTORS_PER_BLOCK;
+	blkcnt_t sectors = count << F2FS_LOG_SECTORS_PER_BLOCK(sbi);

 	spin_lock(&sbi->stat_lock);
 	if (unlikely(sbi->total_valid_block_count < count)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d440231b8cb9..2c72e028cec2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4510,8 +4510,8 @@ static int f2fs_reserve_compress_blocks(struct
file *filp, unsigned long arg)
 static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 		pgoff_t off, block_t block, block_t len, u32 flags)
 {
-	sector_t sector = SECTOR_FROM_BLOCK(block);
-	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
+	sector_t sector = SECTOR_FROM_BLOCK(F2FS_I_SB(inode), block);
+	sector_t nr_sects = SECTOR_FROM_BLOCK(F2FS_I_SB(inode), len);
 	int ret = 0;

 	if (flags & F2FS_TRIM_FILE_DISCARD) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 20b0561fe35d..b628fdc4198f 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -221,11 +221,11 @@ static bool sanity_check_compress_inode(struct
inode *inode,
 		return false;
 	}
 	if (le64_to_cpu(ri->i_compr_blocks) >
-			SECTOR_TO_BLOCK(inode->i_blocks)) {
+			SECTOR_TO_BLOCK(sbi, inode->i_blocks)) {
 		f2fs_warn(sbi,
 			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%llu,
i_blocks:%llu, run fsck to fix",
 			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
-			SECTOR_TO_BLOCK(inode->i_blocks));
+			SECTOR_TO_BLOCK(sbi, inode->i_blocks));
 		return false;
 	}
 	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
@@ -446,7 +446,8 @@ static int do_read_inode(struct inode *inode)
 	i_gid_write(inode, le32_to_cpu(ri->i_gid));
 	set_nlink(inode, le32_to_cpu(ri->i_links));
 	inode->i_size = le64_to_cpu(ri->i_size);
-	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks) - 1);
+	inode->i_blocks = SECTOR_FROM_BLOCK(sbi,
+			le64_to_cpu(ri->i_blocks) - 1);

 	inode_set_atime(inode, le64_to_cpu(ri->i_atime),
 			le32_to_cpu(ri->i_atime_nsec));
@@ -695,6 +696,7 @@ struct inode *f2fs_iget_retry(struct super_block
*sb, unsigned long ino)

 void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_inode *ri;
 	struct extent_tree *et = fi->extent_tree[EX_READ];
@@ -711,7 +713,8 @@ void f2fs_update_inode(struct inode *inode, struct
folio *node_folio)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(READ_ONCE(inode->i_blocks)) + 1);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(sbi,
+					   READ_ONCE(inode->i_blocks)) + 1);

 	if (!f2fs_is_atomic_file(inode) ||
 			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b29df65ab5b7..f565b6873832 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1310,7 +1310,7 @@ static void __submit_zone_reset_cmd(struct
f2fs_sb_info *sbi,
 	/* sanity check on discard range */
 	__check_sit_bitmap(sbi, dc->di.lstart, dc->di.lstart + dc->di.len);

-	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(dc->di.start);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, dc->di.start);
 	bio->bi_private = dc;
 	bio->bi_end_io = f2fs_submit_discard_endio;
 	submit_bio(bio);
@@ -1327,7 +1327,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	struct block_device *bdev = dc->bdev;
 	unsigned int max_discard_blocks =
-			SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
+			SECTOR_TO_BLOCK(sbi, bdev_max_discard_sectors(bdev));
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
@@ -1389,8 +1389,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,

 		dc->di.len += len;

-		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
-				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
+		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(sbi, start),
+				SECTOR_FROM_BLOCK(sbi, len), GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);

 		/*
@@ -1518,7 +1518,7 @@ static void __update_discard_tree_range(struct
f2fs_sb_info *sbi,
 	struct discard_info di = {0};
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int max_discard_blocks =
-			SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
+			SECTOR_TO_BLOCK(sbi, bdev_max_discard_sectors(bdev));
 	block_t end = lstart + len;

 	dc = __lookup_discard_cmd_ret(&dcc->root, lstart,
@@ -2041,8 +2041,8 @@ static int __f2fs_issue_discard_zone(struct
f2fs_sb_info *sbi,

 	/* For sequential zones, reset the zone write pointer */
 	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
-		sector = SECTOR_FROM_BLOCK(blkstart);
-		nr_sects = SECTOR_FROM_BLOCK(blklen);
+		sector = SECTOR_FROM_BLOCK(sbi, blkstart);
+		nr_sects = SECTOR_FROM_BLOCK(sbi, blklen);
 		div64_u64_rem(sector, bdev_zone_sectors(bdev), &remainder);

 		if (remainder || nr_sects != bdev_zone_sectors(bdev)) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 534e376cbc92..2275404e769c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -114,10 +114,10 @@ f2fs_start_segno(struct f2fs_sb_info *sbi,
unsigned int segno)
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))

-#define SECTOR_FROM_BLOCK(blk_addr)					\
-	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK)
-#define SECTOR_TO_BLOCK(sectors)					\
-	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
+#define SECTOR_FROM_BLOCK(sbi, blk_addr)				\
+	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK(sbi))
+#define SECTOR_TO_BLOCK(sbi, sectors)					\
+	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK(sbi))

 /*
  * In the victim_sel_policy->alloc_mode, there are three block
allocation modes.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3ba4df757213..46973207cd7b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3944,7 +3944,7 @@ static int __f2fs_commit_super(struct
f2fs_sb_info *sbi, struct folio *folio,
 	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);

 	/* it doesn't need to set crypto context for superblock update */
-	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(folio->index);
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, folio->index);

 	if (!bio_add_folio(bio, folio, folio_size(folio), 0))
 		f2fs_bug_on(sbi, 1);
@@ -4520,7 +4520,7 @@ static int f2fs_report_zone_cb(struct blk_zone
*zone, unsigned int idx,
 {
 	struct f2fs_report_zones_args *rz_args = data;
 	block_t unusable_blocks = (zone->len - zone->capacity) >>
-					F2FS_LOG_SECTORS_PER_BLOCK;
+					F2FS_LOG_SECTORS_PER_BLOCK(rz_args->sbi);

 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return 0;
@@ -4563,10 +4563,10 @@ static int init_blkz_info(struct f2fs_sb_info
*sbi, int devi)

 	zone_sectors = bdev_zone_sectors(bdev);
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
-				SECTOR_TO_BLOCK(zone_sectors))
+				SECTOR_TO_BLOCK(sbi, zone_sectors))
 		return -EINVAL;
-	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
-	FDEV(devi).nr_blkz = div_u64(SECTOR_TO_BLOCK(nr_sectors),
+	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(sbi, zone_sectors);
+	FDEV(devi).nr_blkz = div_u64(SECTOR_TO_BLOCK(sbi, nr_sectors),
 					sbi->blocks_per_blkz);
 	if (nr_sectors & (zone_sectors - 1))
 		FDEV(devi).nr_blkz++;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 18a9abaa879a..786bda333784 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -14,7 +14,7 @@
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
-#define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for
sector/blk */
+#define F2FS_LOG_SECTORS_PER_BLOCK(sbi)	((sbi)->log_blocksize - 9) /*
log number for sector/blk */
 #define F2FS_MIN_LOG_BLOCKSIZE		12
 #define F2FS_MIN_BLKSIZE		4096UL
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
