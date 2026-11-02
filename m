Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B85606D833
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PA6hovav;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pg/yJgsW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UWn00Lbo;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6DOOmju
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=95knSSty98TmNCdj4JB5i8fC7TXuW2CIlU1vYkXoXpY=; b=PA6hovavLRwO5aJCAfyw/x2iXl
	FhNMsO7JtnsmWumph1G6tEoPBHf2LekJALWjgf9YWPh8l/Q9qIXck+fQIsF2nfFL41TJruzNR/ppx
	LaEnV2ruXJX4rC+i6Xk0vukmVzVH0cNKkeKP9/5Z+msPamRaK11jkP/4wvLBK/3NPyqM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtC-000000006k1-1bCV;
	Mon, 02 Nov 2026 19:40:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtA-000000006ju-3A1c
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mjejBAvk4iAN0H06zTBVIj4UWOh/v6q/mvgI7NIbUug=; b=Pg/yJgsWoqa0+XfaFWmVVZ2I1y
 bXAaC+zq58l49mZPxfEiSEjCqZ3uyqu8o2F0dZ9SfdHtZBNMt0YdIysG/U5bG/c/SObuPKdS7ch84
 zqcDcUYYxBx6OLhF81rmHsugKoWl61QcTEpQRXdU/9zGQYU7kBORB3AsZQ1LgbGiYKZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mjejBAvk4iAN0H06zTBVIj4UWOh/v6q/mvgI7NIbUug=; b=UWn00LbomA+YKISfVtv9aE+4OH
 tSJBd9iTmWk1vNPfVThP9IEzky2keg7DqgLEs2+EvnU6ii94DRwgzPiRhSfzmGYMxxx7WU/oEHxtD
 AWSbstEeaabUyGA8aCV79gQhTQ0eqg7m1NVK6yM17HFvFdV/kWLrIbwy75HNZCrf/j1c=;
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxt9-000000002Cu-1X2r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:16 +0000
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-89f639ba307so1210353b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648410; x=1794253210; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjejBAvk4iAN0H06zTBVIj4UWOh/v6q/mvgI7NIbUug=;
 b=P6DOOmju2zMf0k3CJspH7Tz4jEMO78olfmz7yJLtHWhEVWpnh12nI/A+4q3YQvNXLu
 FNSjfmDAJXRkFvNaRgdJ1S05OfedU0Ea+BjRGZMdGvN9jx1A1YyrYxEQSq/UUDUm7JVk
 x0i8lUskkxFw8tfBz1atiWC1cllbVboTy8puaJigSUMkNcUELt9Q1FjE6kAxPOAWRx0h
 /G3tNYsoT8oPyXg+JBeWEzv0aPBwhIzl/hQZ3VTamskwSGTrnrF8kisOoSeT3jY6vgbd
 SonIq90FNFco/es4yqOZhbR3Ga8maRjmihmRdOs34TDSZPH1Ec8L5aIxRYX/3FenRDp0
 D6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648410; x=1794253210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mjejBAvk4iAN0H06zTBVIj4UWOh/v6q/mvgI7NIbUug=;
 b=NBLBCnI6dPJviQjaKVEzWL6iIvcKv25ZQh/fr/QBT3B2LPb6vDd0zUr14FTpLW28pZ
 +fv3Pblhu1sitVDx56BxOwgyW3WwCPFUzQJMNMBDGVzXUMXi3kA8Ksk2Hy21svycxwzU
 mOXV70X7Gr3ukd3cv+F28aDBfNyQ0maC1UKFyM/mo/CWb/I7y/z2x8sAlcapq9puNOyg
 M//7z2L+8ZtIXd1ljg8bL8qeZWBtA31aqWUuiP9H27jmwFffsXsUA46/FbN6RIfFsd14
 L24wrXMJinxr3Pf8gKb7bDURPzmgmGn2PIY9KiMDkDVi49wRpbydvymjbkbu5iuEGtse
 Utzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb1E/a/TE+ggec8UQBpKzFHWcI+k1+OTbK5sbHBIR6kulG+Wz5jnzmMi+4SP1cJOwk04cCZe3pFaMLvbOq9Lsl@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIgAzTf9hIzhBhqVhosUSHyfkzpBIaLKkY5YsVHh+k9lqIv1XkH
 t+1z4PtRGOSu6NTze/CH5dCS8myCQ0BbfJHFTmUm+/7Wsub5kVaJMZWg
X-Gm-Gg: AYBFou0xeAX3HTAINzHtWK4sRiKizGWr93MhGTNQ5QlTz4V5qqn/4F4NNHtY+f+m26K
 Oq7jwiH+Gw/r11QZcBANUVc6nS12yexvHg5gWoyn01rEeiDYoKDhHJRmsjJB9faVXiAwwKWhZPw
 6kYCUR0w/j1NOthx+MPeGr+ihzTMyz32qefw+hJfE5bFUsv2uTNpkTOXtyVmVk94HGbnfSfRcLr
 iNAfdbOw2BF4e3V3GAoo8eQSAVp04ufAUcSvl3BtdXRJskmGzOYNj8h9K15d3GyPNd+Eeug0//x
 dtVRnPugjcrrTQZGCCSTZWbf1Sm6AprmZ+wkW8BHLtQsVZB+gAlf6KVr8srOyyUQ9DDgBcULoJI
 gqszXNQvepamN3qqn+5ZU5j/o9XnZ7nO3ZWpaaC4SwxndcncOE87T9tkuM4dlBYFspBj1F6blVT
 wvIF551Yuln6kBuGIgykw8kP7I9XzHnGAqoGgiJ+jpBLlJdkLcQb/wjhfwyUKENOIMybA7Qo+Zu
 gNiBVSGWBeXZLsRvqA+kdSzs7N9i73SxmZDKn37a1wHuHS4L0ZcSTp9XlswzRR8Hnc+AVyLt/Hb
 cRQVeNVNYtIZcNwR99UxiWgaQOAggFwQnyDpXnSgQOdcCtA2VWGSJRi3BtsIBq0WHDSs3CmXY60
 4/DNFacEyauP3t6nDzS0RM6J1DDp5sxSpNtfiHeeyX3N5mg==
X-Received: by 2002:a05:6a21:3f95:b0:3e2:701d:7e8d with SMTP id
 adf61e73a8af0-3e928d9837emr7786215637.47.1793648409445; 
 Mon, 02 Nov 2026 11:40:09 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:06 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:34 -0800
Message-ID: <20261102193952.3002018-3-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxt9-000000002Cu-1X2r
Subject: [f2fs-dev] [PATCH 02/20] f2fs: support subpage block size
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
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
  superblock with each supported block size.
- Allow log_blocksize up to PAGE_SHIFT, and write back only the target
  superblock block instead of the whole folio.
- Keep rejecting subpage block sizes, and return -EOPNOTSUPP for the
  features that do not support them yet. Later patches add the support
  and lift these restrictions.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c      |   2 +
 fs/f2fs/f2fs.h          |  61 ++++++++++++---
 fs/f2fs/file.c          |  42 +++++++++++
 fs/f2fs/super.c         | 160 ++++++++++++++++++++++++++++------------
 fs/f2fs/verity.c        |   3 +
 include/linux/f2fs_fs.h |   1 +
 6 files changed, 212 insertions(+), 57 deletions(-)

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
index 50a5f845176d..11de12a3e804 100644
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
+	return folio_size(folio) >> sbi->log_blocksize;
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
+	return ((loff_t)folio->index << PAGE_SHIFT) >> sbi->log_blocksize;
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
+			i_size_read(inode) & (F2FS_BLKSIZE(sbi) - 1))
 		return false;
 
 	if (!f2fs_is_time_consistent(inode))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 93d3088c96f0..82eb62301c48 100644
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
index 78dbf1e92285..f34558b661eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
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
@@ -4181,7 +4193,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	}
 	if (le32_to_cpu(raw_super->log_sectors_per_block) +
 		le32_to_cpu(raw_super->log_sectorsize) !=
-			F2FS_MAX_LOG_SECTOR_SIZE) {
+			le32_to_cpu(raw_super->log_blocksize)) {
 		f2fs_info(sbi, "Invalid log sectors per block(%u) log sectorsize(%u)",
 			  le32_to_cpu(raw_super->log_sectors_per_block),
 			  le32_to_cpu(raw_super->log_sectorsize));
@@ -4703,56 +4715,103 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
  * to get the first valid one. If any one of them is broken, we pass
  * them recovery flag back to the caller.
  */
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
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	/* Skip unmatched magic during probing to avoid noisy logs */
+	if (block != 0 && !*raw_super &&
+	    le32_to_cpu(F2FS_SUPER_BLOCK(sbi, folio, block)->magic) !=
+			F2FS_SUPER_MAGIC) {
+		folio_put(folio);
+		return -EINVAL;
+	}
+
+	/*
+	 * The 2nd superblock was located with sbi->log_blocksize. Check it
+	 * before sanity_check_raw_super(), which may write the superblock
+	 * back with its own log_blocksize.
+	 */
+	err = 0;
+	if (block) {
+		u32 log_bs = le32_to_cpu(F2FS_SUPER_BLOCK(sbi, folio,
+						block)->log_blocksize);
+
+		if (log_bs != sbi->log_blocksize) {
+			f2fs_info(sbi, "Mismatched log_blocksize (%u) in 2nd superblock, expected %u",
+				  log_bs, sbi->log_blocksize);
+			err = -EFSCORRUPTED;
+		}
+	}
+	if (!err)
+		err = sanity_check_raw_super(sbi, folio, block);
+	if (!err && !*raw_super) {
+		memcpy(super, F2FS_SUPER_BLOCK(sbi, folio, block),
+		       sizeof(*super));
+		*valid_super_block = block;
+		*raw_super = super;
+		sbi->log_blocksize = le32_to_cpu(super->log_blocksize);
+		sbi->blocksize = BIT(sbi->log_blocksize);
+	}
+	folio_put(folio);
+	return err;
+}
+
 static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			struct f2fs_super_block **raw_super,
 			int *valid_super_block, int *recovery)
 {
-	struct super_block *sb = sbi->sb;
-	int block;
-	struct folio *folio;
 	struct f2fs_super_block *super;
-	int err = 0;
+	int log_bs, err;
 
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
+	} else {
+		for (log_bs = F2FS_MIN_LOG_BLOCKSIZE;
+		     log_bs <= F2FS_MAX_LOG_BLOCKSIZE; log_bs++) {
+			sbi->log_blocksize = log_bs;
+			sbi->blocksize = BIT(log_bs);
+			err = check_super_block(sbi, super, 1, valid_super_block,
+						raw_super);
+			if (!err)
+				break;
+		}
 		if (!*raw_super) {
-			memcpy(super, F2FS_SUPER_BLOCK(folio, block),
-							sizeof(*super));
-			*valid_super_block = block;
-			*raw_super = super;
+			f2fs_err(sbi, "Can't find valid F2FS filesystem in 2nd superblock");
+			*recovery = 1;
 		}
-		folio_put(folio);
 	}
 
-	/* No valid superblock */
-	if (!*raw_super)
+	/* No valid superblock: return the error of the last probe. */
+	if (!*raw_super) {
 		kfree(super);
-	else
-		err = 0;
-
-	return err;
+		return err;
+	}
+	return 0;
 }
 
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
@@ -4777,7 +4836,8 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 
 	/* write back-up superblock first */
 	index = sbi->valid_super_block ? 0 : 1;
-	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping, index, NULL);
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
+				f2fs_lblk_to_folio_index(sbi, index), NULL);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	err = __f2fs_commit_super(sbi, folio, index, true);
@@ -4789,7 +4849,8 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 
 	/* write current valid superblock */
 	index = sbi->valid_super_block;
-	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping, index, NULL);
+	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
+				f2fs_lblk_to_folio_index(sbi, index), NULL);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	err = __f2fs_commit_super(sbi, folio, index, true);
@@ -5263,6 +5324,13 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
index 3081702b1ddb..1b3276d57bce 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -15,6 +15,7 @@
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
 #define F2FS_MIN_LOG_BLOCKSIZE		12
+#define F2FS_MAX_LOG_BLOCKSIZE		PAGE_SHIFT
 #define F2FS_MIN_BLKSIZE		4096UL
 #define F2FS_MAX_BLKSIZE		PAGE_SIZE
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
