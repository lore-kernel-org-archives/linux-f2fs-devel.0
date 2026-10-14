Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B3ACC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQS6qjUIefZECBmPUcs2EUAfKJfZ0cPDUJFc2TvFeUQ=; b=eEQAmV1lN57AEgvecBK+zHvTOo
	iNrgHhqcD6a1nV4AU2P4U6ivkjsKUuEULY6ZTymuc+50L1aCaaD6J8YF8eTF3j/0g5hZXL4qNG5AR
	RjdI+En8Fxs82l4K14HxcAc6f+sOa6lhVIm7vkZCFIxMRnzQJ+pxDTEjWEFeGpR+w3Gg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskw-0000o4-Cj;
	Wed, 14 Oct 2026 06:46:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskv-0000nq-0p
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d51OaHjNWv8Izp5BdDFoIII7UFVdhf7f4jHUBNxIQfs=; b=Tbg/cyP8BaHdAYPXtqnUti5jrC
 fhj/v+V96Cgl0wBNyYrLQaShHhylX/rSD2Wix+vioUjRY4eF3gd248ol/Gl85YklcDgGFGme9PecS
 qqWR6Ai6g/qageVU/c6ZfobEF0g/yX6J/f5B2VsjlPseTq8ZD2T7mVpps8X80UNMTmPw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d51OaHjNWv8Izp5BdDFoIII7UFVdhf7f4jHUBNxIQfs=; b=UPNIlljYw14lEOXHxbqcLIwg6L
 oukY+hg0ksYbzR1faiGhLHg2XeRUTTHiP34Jxdpyj7dPCp2k3R7KaQ4MBSgYrQeVY71m5ZQ9HjMxI
 g3zG9dCjUMsbj6Kk4k/p0MhYXEg+sPHjvGagxuo+qbEleuhAjIZ+sztt+oXk7EZplym8=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskt-00010X-MM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:28 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so1196821a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960382; x=1792565182; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d51OaHjNWv8Izp5BdDFoIII7UFVdhf7f4jHUBNxIQfs=;
 b=tNl5sQWkr4BNvPALjDjkfW0d+WL5VMD20fWH8HBxwC/HhZiyOnPte9BHxzcyOQCgpn
 YBReu6Kf2ypPX4VSmK/Y3o3FYuKPRuYakS75CnhSC8o1vWzicntYbuMG/TtXHi3qna0w
 qA58uT0wD/Q2EXuNZvqD0oy5vsWwkwEnrgR4vrMTfp/Dwc2scH1VSVi+9uozhOM9HQ4M
 AiY9kKHQGZTqTziI6yZuU2nytj6SeqayrJwTfjd9P8538gW6dCNxJYD7BMPSOJyHTCh/
 xflNadqLXkLHrrpcx4qQsTD8K5v+IY9PS82TwijfAnD6beNHmkifI7FgtC460l+GR/LX
 7zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960382; x=1792565182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d51OaHjNWv8Izp5BdDFoIII7UFVdhf7f4jHUBNxIQfs=;
 b=fgq4fRpqpUPdgRBT0EOVHDSy+E+JI652F8NQuYKNkbKnnKDnxT2jzfDFqHDVw9pmnN
 HVI2u8bttUKGI1nfVqsa5ANNefvIinCREgT7g7xrwaPRKV7VhE1vMKkhy0vZ78OgGZ56
 cYl7ejqGN94USXP3k4KikeiwMNOZ0FU2woX6xbd6y6v9Uablytxv2kcozYo63U5Y0PA+
 LbPfmk2MCOqOq6eUpo+6uDdnMNY5zN0483dVPnmA/9px+nYo6l95hvD6a5twrF0T1QcL
 PGMfLVRjZCYxXauwdYOi4yPDANQWKql1rm9wDq5nbrTac9FPByhR6PjR2VJOPRH24Et4
 TKtA==
X-Gm-Message-State: AFq9FYIT5c0x68g+8ovodgYmXqlWlt7hzozwDH08gG7HEdDn+TBaaFOq
 K+ZnxtoOZvA/XMkvPJoVBOPL64p3MIEJgP68QKFhjkkTVfPVaYNSBrrsmnUWZr1dOhc=
X-Gm-Gg: AYBFou18y3omkNgxK1XMfpkYEN6z001fGd3dh66MK41f+aN70RQItdZL/or3gMylQ/B
 2CrgEGqq+/gopgOsgoAC1udQ2n49vSoLJuZalDTDKRiAuYyW1K9jajI5W4xIcXz2D9GPW1PTDbk
 5O2L7VYEwaZKZhcDggVN0nRWU1pv6nrVj8z/vlcuBwWETsJtlXH7sUSt7owMYGIuBticD4rDfS3
 D7Pe0pher/QGbzUg448di92g+/shkHVpt0x3sk8J2na7QBud5wI4DcxUbSugJYGw/uWbBkVXQYU
 fhFc2P9Nf+Vxkouikd+NV9WTzEILfxqGkcSZNQTMe4OS50WwX18tKX9/VSq4Xa/qjWQlG2e3b7j
 cgboP7O4Xk1+zJmU0X4wkCAzWM1C4rQazuYwVRZOkfZNL+yfRgvQEdHaMA8DpED9Ksks8obVUee
 euOTDRJSZqLol+zmp6+AnnFXEKpszotq7e7sa3BgFSiiTCPz6zXU7a0LDRYi5OdJxu3hTEobIGJ
 g8VJT023bTqUGtXSViOPJl8pHKPz/3qwVt2
X-Received: by 2002:a17:90b:28ce:b0:3a0:809b:1972 with SMTP id
 98e67ed59e1d1-3ab3a745e5bmr11938256a91.26.1791960381967; 
 Tue, 13 Oct 2026 23:46:21 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:46:20 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:44 +0800
Message-ID: <20261014064445.2835813-16-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskt-00010X-MM
Subject: [f2fs-dev] [PATCH v5 15/16] f2fs: allow large folio support to
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now we make all write path support large folios,
so we open permission to let writeable file set
large folio mapping.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   | 17 +++++++++++++++++
 fs/f2fs/file.c   | 16 +---------------
 fs/f2fs/inline.c |  6 ++++++
 fs/f2fs/inode.c  |  4 +---
 fs/f2fs/namei.c  |  1 +
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45861c31fe76..a476464b856c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3242,7 +3242,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ddff43bcb800..1f9bd8e3b526 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5348,6 +5348,23 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
 	return false;
 }
 
+static inline void f2fs_mapping_set_large_folio(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode) ||
+	    f2fs_compressed_file(inode) ||
+	    f2fs_quota_file(F2FS_I_SB(inode), inode->i_ino))
+		return;
+
+	/*
+	 * Keep the folio order range at 0 as a transitional step; large
+	 * folios will be enabled once the whole write path is audited.
+	 */
+	if (IS_IMMUTABLE(inode))
+		mapping_set_folio_min_order(inode->i_mapping, 0);
+	else
+		mapping_set_folio_order_range(inode->i_mapping, 0, 0);
+}
+
 static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cad5329bbfd6..803e2b9900d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -163,17 +163,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
+	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
-	}
 
 	/* mmap stores bypass the COW inode and would break atomicity */
 	if (f2fs_is_atomic_file(inode))
@@ -724,9 +715,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
@@ -1198,8 +1186,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
-		if (mapping_large_folio_support(inode->i_mapping))
-			return -EOPNOTSUPP;
 		if (IS_DEVICE_ALIASING(inode))
 			return -EPERM;
 		if (!f2fs_is_compress_backend_ready(inode))
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 49905aa08418..0dca6c3d58fb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -239,6 +239,12 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	/*
+	 * Inline data is only supported in an order-0 index #0 folio; the
+	 * inline write and mmap fault paths never request a larger order.
+	 */
+	f2fs_bug_on(sbi, folio_test_large(folio));
+
 	f2fs_lock_op(sbi, &lc);
 
 	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9164a2b5d9f0..f5a4dac98ef2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -599,9 +599,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
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
index 38fcea8b72bf..6a1ff631393c 100644
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
