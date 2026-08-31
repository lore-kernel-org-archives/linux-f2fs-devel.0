Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A94C624CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qduLsXr7gxSFUDex1cp4DkWF4ixFcHMzn19B8QHYpAQ=; b=d+g+dDFHLq1Eahu7ElrHdoZ3kc
	xXpvI7AxhvSJAK2zZyQgAqIEj1ryR1YQDWpNF/2UrzXzCszf486f+VoGAM5U49LCBiPigQQxLUEMF
	LAk4lCVeCl53Zf2U/n5rzRsjfyat+QvA0ZyQi/rXttYwIlm5PEMLzB6eUNIe9QTZpryk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Ot-0007dg-M5;
	Mon, 31 Aug 2026 17:02:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Or-0007dY-MA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RqZhl3KyjNT5gAP4GrsiR5RK9iHeIl9R7u9oOVd2Ssc=; b=JcxMQ0eGjx1NRK4fw/RhiSJx70
 CnwcsrF0fiBMHS51HrV9Pod1J7uzEvfqwMTy2+EUT/GaHL6Y10u8nTKSAmApBCxQcLVZFhg975cn1
 /LymhhMtivIiyEOU68esC0dcZgRbdCXjECeiEB4wuBxZH9bq6l5Hh7Amkrd/q0hjaAK0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RqZhl3KyjNT5gAP4GrsiR5RK9iHeIl9R7u9oOVd2Ssc=; b=K/W23ItDRLQMMAsYXO991ZQIft
 SG4JlygXjVnCpEfqvvsc9qdc1kw+kK0DcxZgNSFctUoNVpwBDdmPcCE1zXvlnibmR9WjE9rE5zPG3
 I7xCtkWDYV/XHU5G+09aRhyrS+CcDP8dfCrLlMqQG9Pecn+SGUDsjGNkxQAOT98gniWI=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Oq-0001Oj-6g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:26 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a5f1d0af69so5882739a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195737; cv=none;
 d=google.com; s=arc-20260327;
 b=e+cbvyjzrNPbU/9SihK2CxKpVVYUJ56MteLN7huTdba2zhNr6G8HpgxTgA/mMPO5gW
 Ru392KIKeX+wlu+AZbOaFvqjxMsnOi8soGLt+96MYYTZsTWyXSA1t3MxPyJlltypcAk4
 jI+EXJNVH8QSiQzZtI93Bdra/cN+RV0lesS0DuOEpDqVZ88NHELW9G2QU58fn8sY4tfE
 oaksBIsccTiE3vINXGsKxqmIrCxsH9j85g6D6hH7xRZpwiAYYwaz6QiFktjGowQbbOlw
 m6vstaHWbKm5gEUklVGXudTDO37K/WVn+95NGfgHm9y955K+3R0zL+0Xntq33o8TQjnv
 hdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=RqZhl3KyjNT5gAP4GrsiR5RK9iHeIl9R7u9oOVd2Ssc=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=X+zeI6C73KSWeDfNmo8wKAP/RfBp+urIoqGIhmBowsy3nUMwLWWruF/rg1G10VszLM
 PYDFNksJOFj7yv8pMTZ55/U0AkH+zryLNtaMvipj306DKBbkga4vy0wIr+kSctiVbd8x
 Tarqsa9wXjaxkJ7fR/DIF41rYzw+hyR/xV6Y7LkTF3Abw+PaEW2BnWt/Ca8AVPCGRMpJ
 Sh4F9X6594zBKucRgOzuMcfSJE0G+R2rZtK2DlB44ttXgPl0Ktiedh3CDqYuLSqSL953
 9NoMwyd/o5tZmXGG1UfXmvZ07QxaHMgtTc+P/ooY3EFC2AaFivx5IVMEihE5x+dzC7c/
 Nj/A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195737; x=1788800537; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RqZhl3KyjNT5gAP4GrsiR5RK9iHeIl9R7u9oOVd2Ssc=;
 b=TJ5ntfM+kz3TUA4spAJowNlfVsvBrhBDX6dAWbu/JvMJXLjRIWuq6qI8D2JIZLI8Xa
 601Dm4/1UPfxveqpsIN62HzS8IhIvqEdrrFsusUr56mQmWu8oz8U30ffn5nOhs/A72pX
 6mTfGYl7fBg5LDrX9cjZP37bn9+vsdjnpidovK+3WayVdLHCyq7iTGrCHfl4/2rxYmzZ
 ofUEioYqbjn42qRDposhvedCaPM2NGORQdIzRXSfK8tJLNcTxdzWfCly2jpzgA1AiDew
 2Si2kC7TtO1Vb214yF1M3dy+rTG6nsY9ya03kPf5R7l1gJSL4qxrG4iTt7rOdd3GUMiV
 Kh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195737; x=1788800537;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RqZhl3KyjNT5gAP4GrsiR5RK9iHeIl9R7u9oOVd2Ssc=;
 b=IO6IvH/UM6PhRlIx2gWRCZRAZ3ixDAaUEPfAV7MJtxq8qZnh3V6e3zhDMQjgqAzRVv
 fegO4Agcyfio6C/SBv3F9bFScog+DwMUqmqhnqJQe91dtgIeDRsAzgN//xI+5sQerEtp
 3MmQizlWWEgNKSB2IEJWQF3XSZmQgwuGobhxYD+5RNRFjy6U+Kw9MhPPSoieehJKTrfo
 v//YD2ZotViS6qbJtjSg5QkbRyFoEefNWDSv6Xbtpr5jS/NxemmTiSygY8maMxqVq2g7
 FWdu3mm2fyykVTUP5hbkFQSIBeylIVC5qaVl23Z5K6Gk6vBc/yNMcj73MFDD6qMp/AqC
 RSqw==
X-Gm-Message-State: AFuF++l3sKAm5mum1viMmYUYE76ZRAUiPyXKqkg3+h+sEJQdNWFUsTMa
 axKJoYW1TR/p0D2if96ywTjGjsqwPXDzdCW2pO1bU5Nvc5Qs3PZF8oImygRD9hDCYLRPtBYMV5n
 JvtTPvgE8KbF1ndfwSbnHU/VqlSj63DyQE0b37hE=
X-Gm-Gg: AYBFou3pQX/4Eg2R/995TQK09qQ81WhgkBDMwWyio85T7O6M5/xGk8AIrxy1NA78IH9
 uzYVzdsYqNs0xmi+WOm44JC5HfojUSaYnAXkoENod/XCbURDmUJbd9mBq3t8lGd3iWk0vktCjib
 Nd3xJeaw7pwSU5OqpOJg73mbilg0zT5LoTu4PpEYZXQnUnDJY3Xlr4XjkwAIazTcxeIRqvyhlJx
 5/KWb7rkJHzjFBGwl2iNBSi8ZXBR/ka6jFL1UsSoILJb9rgV4RREa9y+Rp1IxYvQ8acn3wlYH2U
 GQZm4LzfJkc6sZBtIkDraOZ3TEH5WpcG1NSPOEZczEZPlRuT8DwPJvzXuOYD8b/QoXrCZ2neJvg
 eMg==
X-Received: by 2002:a05:6402:5414:b0:6a6:32f5:ff3d with SMTP id
 4fb4d7f45d1cf-6a632f60114mr8666042a12.17.1788195737187; Mon, 31 Aug 2026
 10:02:17 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:16 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:16 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
References: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:02:16 +0200
X-Gm-Features: AcwNN1WwLC2gMpSVYDVTHUZGEjuuZ7s8LcWu1aQjVNxQPwvamV8E1SfIjcRxvxY
Message-ID: <CAH=xXfFsmucd5DpYvXVmQQbE3618+TpzNYYX-0v3x7pLYKQRkw@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Oq-0001Oj-6g
Subject: [f2fs-dev] [PATCH v4 05/11] f2fs: describe dentry block layout
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

An on-disk directory block contains a bitmap, reserved padding, an
array of directory entries (struct f2fs_dir_entry), and matching filename
slots. A fixed compile-time structure couples their offsets to 4KB blocks
and relies on static reserved-space definitions.

Remove struct f2fs_dentry_block and compute region offsets (bitmap
bytes, directory-entry count, and filename slots) dynamically from the
filesystem block size. Access directory blocks through
struct f2fs_dentry_ptr views initialized with the runtime geometry.

Update directory operations, inline dentry handling, and recovery paths
to use the dynamic block layout. No functional change is introduced for
4KB blocks.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/dir.c           | 51 +++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h          | 31 ++++++++++++++++---------
 fs/f2fs/inline.c        |  2 +-
 fs/f2fs/super.c         |  6 +++++
 include/linux/f2fs_fs.h | 31 ++++++++++++-------------
 5 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index fd0e2cd31a81..75ff36a13f60 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -195,7 +195,7 @@ static struct f2fs_dir_entry *find_in_block(struct
inode *dir,
 				int *max_slots,
 				bool use_hash)
 {
-	struct f2fs_dentry_block *dentry_blk;
+	void *dentry_blk;
 	struct f2fs_dentry_ptr d;

 	dentry_blk = folio_address(dentry_folio);
@@ -518,7 +518,7 @@ static int make_empty_dir(struct inode *inode,
 		struct inode *parent, struct folio *folio)
 {
 	struct folio *dentry_folio;
-	struct f2fs_dentry_block *dentry_blk;
+	void *dentry_blk;
 	struct f2fs_dentry_ptr d;

 	if (f2fs_has_inline_dentry(inode))
@@ -530,7 +530,7 @@ static int make_empty_dir(struct inode *inode,

 	dentry_blk = folio_address(dentry_folio);

-	make_dentry_ptr_block(NULL, &d, dentry_blk);
+	make_dentry_ptr_block(inode, &d, dentry_blk);
 	f2fs_do_make_empty_dir(inode, parent, &d);

 	folio_mark_dirty(dentry_folio);
@@ -690,7 +690,7 @@ int f2fs_add_regular_entry(struct inode *dir,
const struct f2fs_filename *fname,
 	unsigned long bidx, block;
 	unsigned int nbucket, nblock;
 	struct folio *dentry_folio = NULL;
-	struct f2fs_dentry_block *dentry_blk = NULL;
+	void *dentry_blk = NULL;
 	struct f2fs_dentry_ptr d;
 	struct folio *folio = NULL;
 	int slots, err = 0;
@@ -727,9 +727,9 @@ int f2fs_add_regular_entry(struct inode *dir,
const struct f2fs_filename *fname,
 			return PTR_ERR(dentry_folio);

 		dentry_blk = folio_address(dentry_folio);
-		bit_pos = f2fs_room_for_filename(&dentry_blk->dentry_bitmap,
-						slots, NR_DENTRY_IN_BLOCK);
-		if (bit_pos < NR_DENTRY_IN_BLOCK)
+		make_dentry_ptr_block(dir, &d, dentry_blk);
+		bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
+		if (bit_pos < d.max)
 			goto add_dentry;

 		f2fs_folio_put(dentry_folio, true);
@@ -750,7 +750,6 @@ int f2fs_add_regular_entry(struct inode *dir,
const struct f2fs_filename *fname,
 		}
 	}

-	make_dentry_ptr_block(NULL, &d, dentry_blk);
 	f2fs_update_dentry(ino, mode, &d, &fname->disk_name, fname->hash,
 			   bit_pos);

@@ -887,7 +886,8 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
 void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 					struct inode *dir, struct inode *inode)
 {
-	struct f2fs_dentry_block *dentry_blk;
+	void *dentry_blk;
+	struct f2fs_dentry_ptr d;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	pgoff_t index = folio->index;
@@ -905,18 +905,17 @@ void f2fs_delete_entry(struct f2fs_dir_entry
*dentry, struct folio *folio,
 	f2fs_folio_wait_writeback(folio, DATA, true, true);

 	dentry_blk = folio_address(folio);
-	bit_pos = dentry - dentry_blk->dentry;
+	make_dentry_ptr_block(dir, &d, dentry_blk);
+	bit_pos = dentry - d.dentry;
 	for (i = 0; i < slots; i++)
-		__clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
+		__clear_bit_le(bit_pos + i, d.bitmap);

 	/* Let's check and deallocate this dentry page */
-	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
-			NR_DENTRY_IN_BLOCK,
-			0);
+	bit_pos = find_next_bit_le(d.bitmap, d.max, 0);
 	folio_mark_dirty(folio);

-	if (bit_pos == NR_DENTRY_IN_BLOCK &&
-		!f2fs_truncate_hole(dir, index, index + 1)) {
+	if (bit_pos == d.max &&
+	    !f2fs_truncate_hole(dir, index, index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(folio);
 		folio_clear_dirty_for_io(folio);
 		folio_clear_uptodate(folio);
@@ -938,7 +937,8 @@ bool f2fs_empty_dir(struct inode *dir)
 {
 	unsigned long bidx = 0;
 	unsigned int bit_pos;
-	struct f2fs_dentry_block *dentry_blk;
+	void *dentry_blk;
+	struct f2fs_dentry_ptr d;
 	unsigned long nblock = dir_blocks(dir);

 	if (f2fs_has_inline_dentry(dir))
@@ -959,17 +959,16 @@ bool f2fs_empty_dir(struct inode *dir)
 		}

 		dentry_blk = folio_address(dentry_folio);
+		make_dentry_ptr_block(dir, &d, dentry_blk);
 		if (bidx == 0)
 			bit_pos = 2;
 		else
 			bit_pos = 0;
-		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
-						NR_DENTRY_IN_BLOCK,
-						bit_pos);
+		bit_pos = find_next_bit_le(d.bitmap, d.max, bit_pos);

 		f2fs_folio_put(dentry_folio, false);

-		if (bit_pos < NR_DENTRY_IN_BLOCK)
+		if (bit_pos < d.max)
 			return false;

 		bidx++;
@@ -1066,10 +1065,12 @@ static int f2fs_readdir(struct file *file,
struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
 	unsigned long npages = dir_blocks(inode);
-	struct f2fs_dentry_block *dentry_blk = NULL;
+	void *dentry_blk = NULL;
 	struct file_ra_state *ra = &file->f_ra;
 	loff_t start_pos = ctx->pos;
-	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int entries = sbi->dentries_per_block;
+	unsigned int n = (unsigned long)ctx->pos / entries;
 	struct f2fs_dentry_ptr d;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
 	int err = 0;
@@ -1089,7 +1090,7 @@ static int f2fs_readdir(struct file *file,
struct dir_context *ctx)
 		goto out_free;
 	}

-	for (; n < npages; ctx->pos = n * NR_DENTRY_IN_BLOCK) {
+	for (; n < npages; ctx->pos = n * entries) {
 		struct folio *dentry_folio;
 		pgoff_t next_pgofs;

@@ -1122,7 +1123,7 @@ static int f2fs_readdir(struct file *file,
struct dir_context *ctx)
 		make_dentry_ptr_block(inode, &d, dentry_blk);

 		err = f2fs_fill_dentries(ctx, &d,
-				n * NR_DENTRY_IN_BLOCK, &fstr);
+				n * entries, &fstr);
 		f2fs_folio_put(dentry_folio, false);
 		if (err)
 			break;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2a4ba7d4ec0e..d2e54573ed34 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -669,17 +669,6 @@ struct f2fs_dentry_ptr {
 	int nr_bitmap;
 };

-static inline void make_dentry_ptr_block(struct inode *inode,
-		struct f2fs_dentry_ptr *d, struct f2fs_dentry_block *t)
-{
-	d->inode = inode;
-	d->max = NR_DENTRY_IN_BLOCK;
-	d->nr_bitmap = SIZE_OF_DENTRY_BITMAP;
-	d->bitmap = t->dentry_bitmap;
-	d->dentry = t->dentry;
-	d->filename = t->filename;
-}
-
 static inline void make_dentry_ptr_inline(struct inode *inode,
 					struct f2fs_dentry_ptr *d, void *t)
 {
@@ -1866,6 +1855,9 @@ struct f2fs_sb_info {
 	unsigned int nat_entries_per_block;	/* NAT entries in a block */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int orphans_per_block;	/* orphan inodes in a block */
+	unsigned int dentries_per_block;	/* dentries in a block */
+	unsigned int dentry_bitmap_size;	/* dentry bitmap size in bytes */
+	unsigned int dentry_reserved_size;	/* dentry reserved bytes */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2268,6 +2260,23 @@ f2fs_orphan_footer(void *orphan_block, struct
f2fs_sb_info *sbi)
 		 sizeof(struct f2fs_orphan_footer));
 }

+static inline void make_dentry_ptr_block(struct inode *inode,
+				struct f2fs_dentry_ptr *d, void *t)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int entries = sbi->dentries_per_block;
+	unsigned int bitmap_size = sbi->dentry_bitmap_size;
+	unsigned int reserved_size = sbi->dentry_reserved_size;
+
+	d->inode = inode;
+	d->max = entries;
+	d->nr_bitmap = bitmap_size;
+	d->bitmap = t;
+	d->dentry = t + bitmap_size + reserved_size;
+	d->filename = t + bitmap_size + reserved_size +
+					SIZE_OF_DIR_ENTRY * entries;
+}
+
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_super_block *)(sbi->raw_super);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index aec06fb4fd76..718dd785865a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -415,7 +415,7 @@ static int f2fs_move_inline_dirents(struct inode
*dir, struct folio *ifolio,
 {
 	struct folio *folio;
 	struct dnode_of_data dn;
-	struct f2fs_dentry_block *dentry_blk;
+	void *dentry_blk;
 	struct f2fs_dentry_ptr src, dst;
 	int err;

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f9811d571ae5..8d2224e585d3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4388,6 +4388,12 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		sizeof(struct f2fs_sit_entry);
 	sbi->orphans_per_block = (sbi->blocksize -
 		sizeof(struct f2fs_orphan_footer)) / sizeof(__le32);
+	sbi->dentries_per_block = (BITS_PER_BYTE * sbi->blocksize) /
+		((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * BITS_PER_BYTE + 1);
+	sbi->dentry_bitmap_size = DIV_ROUND_UP(sbi->dentries_per_block,
+		BITS_PER_BYTE);
+	sbi->dentry_reserved_size = sbi->blocksize - sbi->dentry_bitmap_size -
+		(SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * sbi->dentries_per_block;
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
 	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 7d2cbceb42d5..d1059a27e1b9 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -601,15 +601,7 @@ typedef __le32	f2fs_hash_t;
  * dentry, when converting inline dentry we should handle this carefully.
  */

-/* the number of dentry in a block */
-#define NR_DENTRY_IN_BLOCK	((BITS_PER_BYTE * F2FS_BLKSIZE) / \
-					((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * BITS_PER_BYTE + 1))
 #define SIZE_OF_DIR_ENTRY	11	/* by byte */
-#define SIZE_OF_DENTRY_BITMAP	((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
-					BITS_PER_BYTE)
-#define SIZE_OF_RESERVED	(F2FS_BLKSIZE - ((SIZE_OF_DIR_ENTRY + \
-				F2FS_SLOT_LEN) * \
-				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
 #define MIN_INLINE_DENTRY_SIZE		40	/* just include '.' and '..' entries */

 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
@@ -620,14 +612,21 @@ struct f2fs_dir_entry {
 	__u8 file_type;		/* file type */
 } __packed;

-/* Block-sized directory entry block */
-struct f2fs_dentry_block {
-	/* validity bitmap for directory entries in each block */
-	__u8 dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
-	__u8 reserved[SIZE_OF_RESERVED];
-	struct f2fs_dir_entry dentry[NR_DENTRY_IN_BLOCK];
-	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
-} __packed;
+/*
+ * A dentry block is laid out as follows, where the number of entries and all
+ * offsets are determined by the filesystem block size at runtime:
+ *
+ * 0                                                         blocksize
+ * +--------+----------+-------------------+-----------------------+
+ * | bitmap | reserved | dir_entry[entries]| filename[entries][8] |
+ * +--------+----------+-------------------+-----------------------+
+ *
+ * entries = (BITS_PER_BYTE * blocksize) /
+ *           ((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * BITS_PER_BYTE + 1)
+ * bitmap_size = DIV_ROUND_UP(entries, BITS_PER_BYTE)
+ * reserved_size = blocksize - bitmap_size -
+ *                 (SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * entries
+ */

 #define	F2FS_DEF_PROJID		0	/* default project ID */

-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
