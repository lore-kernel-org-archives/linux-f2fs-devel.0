Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3E0C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SIodD3A+hPILL2ju0KJyWQO8+97DqbET3OvRGt4kFhE=; b=Ji0KdQi7d/qYHDq5cf6RHcheRp
	OXQEx+W6eZB7mRmXEvLwuv9XXTM7CqA/mdqEnc/TTbsjM16BvlZshpGLk3YJKFD3446dPBNve0yOp
	j3f4UYWCXXi4/kaV9o6ii3CSrQQjPD+vzZzVjYEEYtq+Vk+PS+HRhZBVMDQ8wME4nNbY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2Gb6-0000kc-1Y;
	Thu, 03 Sep 2026 23:11:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2Gb3-0000kU-U5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:11:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CLwAES2u1MQkbbFWItpUQu4cQcCnvsnD60S+KPQRK2U=; b=FjP8dS5Ya3JyombuivdUURdhqW
 K88Kb2ls5CzVR8m78X40xKpXrdZgYCEnDBi/wU52uhT2wLat3HVoyfBIapM0KwtZwSF9uoCSMmZNX
 YgTrQLZVB1benmDmQA6P121aIy+UD3uSHKnRAUfdTxDyzwrnE+mUzw6k+/+KX1dw+3Es=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CLwAES2u1MQkbbFWItpUQu4cQcCnvsnD60S+KPQRK2U=; b=A7kp+hZ8Y+dq/AVMuVfEmwBcoQ
 lxHXnfaHQ+FiPnbBdO+Xn4/QBBEWnSoba1i9cI0bcJxqy11IMD7PvrwD1BenuKxo9lTrBTBRwBEbt
 qLUvmZygjwHyjKscgTkDWxzvnUppE/QtbPykmBB/0OPKQogP2xgOLWvUzX/LU8/32seQ=;
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Gb0-0007L9-J6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:11:51 +0000
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d91ded8174so3493115ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788477105; x=1789081905; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CLwAES2u1MQkbbFWItpUQu4cQcCnvsnD60S+KPQRK2U=;
 b=Ngf6DS3uoPrQikoFx5QefG/Ww62gtVj9Bz8ei2vUn2AbDV85hrpR0J4YBEXlECzZnj
 cBNXCHZ1XuX5V9T2VPrJ0gWUU7oqjL4YmY0sh3TGReHO/c22fFvUdm7c3uo68t8fpAM+
 8n5jzQGFFRfYVxSxaFY6aZp7IS+Hpbi6QDxXi9yCJO5HvAFIGdsFzXMgTgFtofy184rL
 7NAzfn/FcNr6ksmmPy/o0ddcHPdQbxWAHRAQUrIhgLSnt2ZvkIGwZh1LhNPmuaz5hesB
 Ydd78Xf+nHDYZHxBdcaPrlKQGNFYB2xwga8ae1U6HTL50zPT3MoNKdsUJEfiOVOm69v3
 Ql1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788477105; x=1789081905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CLwAES2u1MQkbbFWItpUQu4cQcCnvsnD60S+KPQRK2U=;
 b=eIrWLgKGV+bLcpXyiY+rvH4p6fB9TSTlkP3NknFn6OvetU5h1X2EAxQz/Xu8F3wGny
 d6uoyoqt8FGU6TInjqHxFaO3uPhzK6PNFwGIM19pvCwneJVB7VAcrmYVOFwyH8GsyTxp
 yq8X1pcMs6BV08euS0lyuI4A+YYVAQIVT7x2fNNPaKpd7UzNEol8wF+FR6GE/DMGyyaU
 9dt8nEUpkoxTHwYIuutcIgVePxDn1/wFKivdA47ZWIDkqHG6SglwEQdF6yMSgRUrtFGT
 GIibDz23RcvCviLp5MigxZ2ayziKETPOoM4n5602l9Wl2P0/R0dfjvfNeTjGzD6YCmHg
 Hn1A==
X-Gm-Message-State: AFuF++n35syqX90529loxpD+nF8/6fi1li2pwm/GwtNNyIYXiRcOt3vZ
 nHAbtDDan0FtdUOU0daDVAAZavSHuLA7YpWIyinSBxwZdxYf4g4AyLMY2C8KKvscn9E=
X-Gm-Gg: AYBFou29m0Msq9eDaG5sS61FS/RWJ1BcDedSVMuo5emgyrknJ7oWE1vCavZOWBatADR
 ubzLCGgycQ4zPDjJHFIpCSYL1nQSpUP9VFUfdiv7HINyFBKUm9Nxc3dli27C5PZy+4WlBUcSyyI
 4OD+SiOM3/7vOn/Wv+MjudxG1bXXdYwQ784SEJe9DAu8uvG81nUwDYoQu5wwQuJOCribar6byVG
 ANLtrB3Aypf5rxr8/vJaLZwCtT/8w1mxFCUdvvwdiF1Rc6Iq4TOYCHlCXJvGoS+gJZxSEu/CoAu
 LhdoYWXVpKbp/TEF15KTO7ZwE+a82SyMShdmxh4Hqe63c1UdANo45QAxX+eXC4ilWhhWw2SAmf2
 McjFRXYf8Z3MkKUVqFlptdBRiZZPvIXh8Jb7JscoBgOSWkPj5VtUiMElzCRdtfnlkoaMW+s+HZ6
 MMMnEvqRVoxjNxDf8cizAP/uGhHDe6lCXTQzFVhK9EyQiOzJ447sNt/Ug4IjtGmvHG3Q==
X-Received: by 2002:a17:902:f092:b0:2d8:df44:a5c2 with SMTP id
 d9443c01a7336-2db126afe54mr23783235ad.20.1788477104649; 
 Thu, 03 Sep 2026 16:11:44 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495acf7sm1835205ad.25.2026.09.03.16.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:11:44 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:11:32 -0700
Message-ID: <edfbfcc572a81d69315c07cc756518d02fda7b1c.1788476500.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788476500.git.zhangxp1998@gmail.com>
References: <cover.1788476500.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2Gb0-0007L9-J6
Subject: [f2fs-dev] [PATCH v8 05/11] f2fs: describe dentry block layout
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
@@ -195,7 +195,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
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
@@ -690,7 +690,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	unsigned long bidx, block;
 	unsigned int nbucket, nblock;
 	struct folio *dentry_folio = NULL;
-	struct f2fs_dentry_block *dentry_blk = NULL;
+	void *dentry_blk = NULL;
 	struct f2fs_dentry_ptr d;
 	struct folio *folio = NULL;
 	int slots, err = 0;
@@ -727,9 +727,9 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
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
@@ -750,7 +750,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
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
@@ -905,18 +905,17 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
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
@@ -1066,10 +1065,12 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
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
@@ -1089,7 +1090,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	for (; n < npages; ctx->pos = n * NR_DENTRY_IN_BLOCK) {
+	for (; n < npages; ctx->pos = n * entries) {
 		struct folio *dentry_folio;
 		pgoff_t next_pgofs;
 
@@ -1122,7 +1123,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
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
@@ -2268,6 +2260,23 @@ f2fs_orphan_footer(void *orphan_block, struct f2fs_sb_info *sbi)
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
@@ -415,7 +415,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 {
 	struct folio *folio;
 	struct dnode_of_data dn;
-	struct f2fs_dentry_block *dentry_blk;
+	void *dentry_blk;
 	struct f2fs_dentry_ptr src, dst;
 	int err;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5891dba76bce..5ca4f54e794c 100644
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
index bdb8c63ac0c6..2370af742c8f 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -605,15 +605,7 @@ typedef __le32	f2fs_hash_t;
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
@@ -624,14 +616,21 @@ struct f2fs_dir_entry {
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
