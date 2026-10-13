Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CB8CC6B0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ewpXus53lNU9d63m+MH7Qm4kOHbFFOOffRq2XstGvQ4=; b=KW3u+w8yc6Y6EMOkZ3QgjZxAAl
	TffH4pcn+xn8DWWMkFl+uiIfCgP0oO3vjw5vj5MbBI3087+NvS0k5b3IRkHkGC7VhoQ/wVpC5WH9C
	OTqmuUd0kQsHFCAvFfBoEGOXDS5hRNiyXcOuJfRvTw/v4X/laAw0hKzmxVFo/SwBShbY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8s-0002KU-Rs;
	Tue, 13 Oct 2026 11:58:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8r-0002K9-EK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBYDeDJPiU7Woi24r+XJ0DdmQKbYBi2/3x/Ae90790s=; b=hGpIbGHoQZ3RtO2Ssd6YyIMgON
 9GpbgFwK7aNT8jwKV8qV2VaYDsBxOqqhEgrXaHWgs4Thlwcf+n/uvWvOp85bqwWEyQxUGa6/Zb/yi
 Qbw4X7Lzl5qcw+C0m2pnQYXs3DqJsxPfIGm5hTYqxYRLgyUL2oJ2MfkSSTsUFj/y48QQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cBYDeDJPiU7Woi24r+XJ0DdmQKbYBi2/3x/Ae90790s=; b=JL5cFy5ohuE8foHw6VeBSwsk2e
 tR2ZPRlO8BmhR29kRfcdYKrB2J19bY1+DW606bHzBpBZMWdTHHUJOR89N/FKCeOSNQ68+1q8JpVHK
 aNAulanX/vQbzqe6gUoxCatfQdrbsZFrVnJYKGL5DWQJmCV+qmg6CsHc4x2i9ROyCgrY=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8o-0005TK-Lx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:58:01 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4fb64d2so1170048a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892673; x=1792497473; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cBYDeDJPiU7Woi24r+XJ0DdmQKbYBi2/3x/Ae90790s=;
 b=ESsirJ94BU2shEcOMnVIEU/DmcXMB0gLiRunKqwXannijQcyyWmBiEf0r2mvfWqeOI
 gHiWZuiH0gkDZnlPmqzcH/IO0dYDJgoYI3gnixG7c9SUBeOtJf85dQzrxmH6eZ7KXw1C
 0ctL35RdBAihrUputxbYANA3KXyOYJCf5P2GBD2NxmVxYIvrupuI02mmFEWT08eklhSn
 Z7MUiXrYXVML5816+bhk2Q3vu9cvXb9n3BWdW8weB2i3Lst5iELpiCGoCmxAW5cXfRlt
 8LjyOVkYvACFLMOIH48qj0U3NBYM4qfUGzdCAkW7sprPHMejwdTEYlJe/TRkohMcb/jG
 iLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892673; x=1792497473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cBYDeDJPiU7Woi24r+XJ0DdmQKbYBi2/3x/Ae90790s=;
 b=YldJE2Tep3dx5Edoskp28gowVUrQ/naSAPJBImWACCaYOlClGCoWJO9zqEbMYZq45C
 V6Pxff5wn5mg0ab/w/Qwm/TP+nSZApYYrD+47P51W+v6JVbDR4cje2fG4h/r8meTiNYu
 MmJK3zPTr1lprX5WGkI3SyZnxS32lq5ErOJIHSISfexybQz2PJ8heqyvVWLeTCeObNOr
 Qw7zkVh+NeQEgk96zYiuOlVd75wruHPrYT1q0BRL9TcXTbl/DaSEpameIJNEPnKKg+xA
 s7CEiVIZjFyAD2DLSHSaAwoJ/dKDiiBgwSCei4Cp+o5EpaUWg5g9KoXQtdzbegT0VIvR
 pKhw==
X-Gm-Message-State: AFq9FYJRV09EVtydYuG3+DG/q5sR2wZdYCZG70/B03AL5++ZEDjZMwMS
 7Qc4Gly/YuXbi906V0s+O7STfjo8DP1yDMIle2cyVm1fiQD+Cjwmp1MZe+15T6XiUyY=
X-Gm-Gg: AYBFou0/PH19044JiCHL8sFbDQfXZa5Xv8c/pdEBXY7Wmx9Oj/VSTRj6oMJkdTCGrcx
 hi1Daw5WHJ9jK5iqS2Dt6PAo4SVHJ27e7LIiDYFlzyaceyT6AFAuwA9qkIM/WOp4iQuYOIMLaC7
 X8sFwblEAm63lAg1r1YmQzhG05lDvhK6sydWvaHQiwwprhLf/LOxg5bZIj33UFkPqxKbUI4isz1
 jCXJiZyxGKlZdKhmrdAuecivCHUIdUSl48GKuhtJMFC1qHPqhUEheBcgyNM/g7MTxNQaFh4nafQ
 /W+plh+63s87JE/3nQ+F3AwjZKAV2p7qCJnxV/GMPp8Zn3uDfUu4oKhLcl8bc0NYBMVx8OJHqXu
 AOgTFgrM+E6WxUPJYKw9BpJ7GTwLKuJZ944lrlcr9c0zj77oYJtiBOGxHZXi7YjheVWQtJBEL5x
 4CZef/8agK7FxBmZ+kBDwdUFHx/4AtZjaoP6jKmKg5Gr+/3GGPhXZhaWjOi89aHKsECPMbiTQPd
 i1szggfTPt/uFFvLBc3vtptBP9THHmf3oGatQ==
X-Received: by 2002:a17:90b:5807:b0:3a4:9dd7:296f with SMTP id
 98e67ed59e1d1-3ab3a9dfda0mr9413758a91.40.1791892672923; 
 Tue, 13 Oct 2026 04:57:52 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:52 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:20 +0800
Message-ID: <20261013115621.968742-18-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8o-0005TK-Lx
Subject: [f2fs-dev] [PATCH v4 17/18] f2fs: allow large folio support to
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Now we make all write path support large folios,
so we open permission to let writeable file set
large folio mapping.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   | 17 +++++++++++++++++
 fs/f2fs/file.c   | 16 ----------------
 fs/f2fs/inline.c |  6 ++++++
 fs/f2fs/inode.c  |  4 +---
 fs/f2fs/namei.c  |  1 +
 6 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 48376cbcc..0e139b4ca 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3243,7 +3243,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a925d1a59..3a9b247cf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5326,6 +5326,23 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
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
index 3c90cd365..9cee36258 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -164,17 +164,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
@@ -729,9 +718,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
@@ -1204,8 +1190,6 @@ int f2fs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
-		if (mapping_large_folio_support(inode->i_mapping))
-			return -EOPNOTSUPP;
 		if (IS_DEVICE_ALIASING(inode))
 			return -EPERM;
 		if (!f2fs_is_compress_backend_ready(inode))
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 49905aa08..0dca6c3d5 100644
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
index 9164a2b5d..f5a4dac98 100644
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
index ce5d536d8..c0f2e6777 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -341,6 +341,7 @@ static struct inode *f2fs_new_inode(const struct mnt_idmap *idmap,
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
