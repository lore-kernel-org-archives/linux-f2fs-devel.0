Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E431C61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sWybSb0fz9XtFDA3RvHBpOFIddDKBjsU2L8dLzPiXsg=; b=VKx3xH+o2K6JeIdiZDcTIEFHku
	UxcJ5wNI8BtRCP6gjqFd2gIDw2g+jDUpKHoFrx7m38DhsVhqlMzdDlXmO5EHU43sfnzMybs2VFo+A
	8mJezM72/7wOpx32c1rrexNa5bVOWqFnC0S1lTWY5HtE2gS5uS3C8PaJDxcxVSA9bRa0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzF9S-0007Un-W5;
	Wed, 26 Aug 2026 15:02:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wzF9R-0007St-CZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sTxI5UdO0rtdKSksJfWZZPHZ6Bbg4ffM5X8VWwPtsHg=; b=d6jeoSPlLHemgeI4AGmAvSv0rp
 jqqw2G9qweBGLEa2IDErkg9t8CHw1RE++9oZFyXlVHh8+AqITnkpev6LxYd3Y7XToOC+PjDo0uBrv
 Ay/l4nm1wQiWbYdpSIpBvg93r2ZDuAFbe8XudqzlXsYW4cRZc9aAlEuqTwvXsB3LjGnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sTxI5UdO0rtdKSksJfWZZPHZ6Bbg4ffM5X8VWwPtsHg=; b=SaN9zU1oR38hrMAMX1j1sIGhB9
 8WSgX4gVg9oQmH3kpXqu7gfVro5Wq84eUgLmlW+CYJTSBmj5nbqtaFJAtlQCtvyURc4qmho4/CYRW
 +GseRWDwmhX6CCnc0Yck6ShpbDlTsixTegKWGZzGsDJXpZzFloZ2uFRmU8S3iQWyBZSU=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzF98-00079b-HK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sT
 xI5UdO0rtdKSksJfWZZPHZ6Bbg4ffM5X8VWwPtsHg=; b=OwAEA4poKDftAzbuCg
 Y6KGhngaRK9IbIsoTobhlpRLw/XTUQ3NsXogeORNEXMyDKOl59J500cSzc4hctnh
 VBI0GOmXhfmSEkOWA3hsHr1hkhNSOH/wxq38E1ZOJoLSmQcsaA2n6U/eEIc2K1zp
 B3xz1UAyM3ipRN0KKCp3bo1vk=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3P5N85Y5qx4G3Gg--.15517S4; 
 Wed, 26 Aug 2026 21:09:18 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 21:09:14 +0800
Message-ID: <20260826130916.2231342-3-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wB3P5N85Y5qx4G3Gg--.15517S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1fXr43CF48JF1UtF4fZrb_yoWrKFykpF
 Z8Gr1rGr4DuFyYgr1ktFs0vr1Yva4xW3yUAa97Aws5A3WDX34SgF1Ika45uF45trW8Jw4I
 qF40kryUWr15GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5Ma8UUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsR-WpmqO5X9YmAAA3g
X-Headers-End: 1wzF98-00079b-HK
Subject: [f2fs-dev] [PATCH 13/14] f2fs: allow large folio support to
 writeable files
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now we make all write path support large folios,
so we open permission to let writeable file set
large folio mapping.

Keep fs-layer encrypted files excluded unless inline encryption is
enabled, since f2fs_encrypt_one_page() still encrypts one PAGE_SIZE
page and cannot handle large folios.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c  |  9 ++++++++-
 fs/f2fs/f2fs.h  | 13 +++++++++++++
 fs/f2fs/file.c  | 16 ----------------
 fs/f2fs/inode.c |  4 +---
 fs/f2fs/namei.c |  1 +
 5 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0b167b14a9a5..2e20833c6417 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2955,7 +2955,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
@@ -3321,6 +3321,13 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return 0;
 
+	if (folio_test_large(page_folio(page))) {
+		f2fs_warn_ratelimited(F2FS_I_SB(inode),
+			"large folio does not support fs-layer encryption, ino=%llu",
+			(unsigned long long)inode->i_ino);
+		return -EOPNOTSUPP;
+	}
+
 	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(page_folio(page),
 					PAGE_SIZE, 0, GFP_NOFS);
 	if (IS_ERR(fio->encrypted_page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6ae249bf9aa1..04ed0ea92b26 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5201,6 +5201,19 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
 	return false;
 }
 
+static inline void f2fs_mapping_set_large_folio(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode) ||
+	    f2fs_has_inline_data(inode) ||
+	    f2fs_compressed_file(inode) ||
+	    f2fs_quota_file(F2FS_I_SB(inode), inode->i_ino) ||
+	    (f2fs_encrypted_file(inode) &&
+	     !(inode->i_sb->s_flags & SB_INLINECRYPT)))
+		return;
+
+	mapping_set_folio_min_order(inode->i_mapping, 0);
+}
+
 static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b82acbc3240f..c8426821e701 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -134,17 +134,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	int err = 0;
 	vm_fault_t ret;
 
-	/*
-	 * We only support large folio on the read case.
-	 * Don't make any dirty pages.
-	 */
-	if (unlikely(IS_IMMUTABLE(inode)) ||
-	    mapping_large_folio_support(inode->i_mapping)) {
-		f2fs_err(sbi, "Not expected: immutable: %d large_folio: %d",
-				IS_IMMUTABLE(inode),
-				mapping_large_folio_support(inode->i_mapping));
-		return VM_FAULT_SIGBUS;
-	}
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		err = -EIO;
@@ -698,9 +687,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
@@ -1177,8 +1163,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
-		if (mapping_large_folio_support(inode->i_mapping))
-			return -EOPNOTSUPP;
 		if (IS_DEVICE_ALIASING(inode))
 			return -EPERM;
 		if (!f2fs_is_compress_backend_ready(inode))
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 96cc0e777567..7c4b5cdfe276 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -642,9 +642,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		if (IS_IMMUTABLE(inode) && !f2fs_compressed_file(inode) &&
-		    !f2fs_quota_file(sbi, inode->i_ino))
-			mapping_set_folio_min_order(inode->i_mapping, 0);
+		f2fs_mapping_set_large_folio(inode);
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index afaab7739283..bdf4e586bfcf 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -341,6 +341,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 	f2fs_set_inode_flags(inode);
 
 	f2fs_init_extent_tree(inode);
+	f2fs_mapping_set_large_folio(inode);
 
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
