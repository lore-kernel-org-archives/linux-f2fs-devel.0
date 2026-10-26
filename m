Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D4606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GUkzp027;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OWD/cXrf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i/OLnh65;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tk5ijWBn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=WgehcyfFukuxuC7b301Us4jrHP/22S7d4mm9BrkOUl8=; b=GUkzp0274rt6sLWLXg5a/cIgsx
	J0G7reD3zFd0bIZ4Q7w/VNF57IdXBCqnBplNcmcM9gQanA76Zt0l1ufreVN5E9F2CWGGQbLdpD26l
	8AjU1qfQSxaEYcLJzKKF2zOFT6vv3mRpQSt5JXPoELCcsUpRvBTn9x03H/BN8MCGi09c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBYL-000000007QM-1uAx;
	Mon, 26 Oct 2026 03:39:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBYK-000000007Q0-0Tjj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mcKmQWD5BzKPZcYyv/2kD79SsEZPAeCLB89VrkV54d8=; b=OWD/cXrfJ404xmRMY0zyApMpKF
 ROkDX0ShcX7K3gOtF5cKZg4TENTUCyf2OhBj+xcnB30vt1Sq16oK+TtoJZct2upImVW8sMajQJ387
 Y5VSvGOfWYa3cnMoW6CA3Zuf1f66bFP0k4jZXaUWUisiMksOqLyA2LDEUfqIdhEtPnuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mcKmQWD5BzKPZcYyv/2kD79SsEZPAeCLB89VrkV54d8=; b=i/OLnh657oFYxaS4kfOGWPQMIt
 0t1Y2Ls7e8fJWDbb4sDwnhCa4UizTTVf7JSyUW4xh6RPSFwjlt2C+fAoND5cPVeD+EkJyO1ZZKAWz
 4DGo0GkKtBhXSaxHTaaSniatHeza2Mn9w3jZlWz5XdiTR4SqSyHNzZo9UkZqOSNfjPRs=;
Received: from mail-pj2-f2.google.com ([74.125.227.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBY7-000000000h9-28sL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:16 +0000
Received: by mail-pj2-f2.google.com with SMTP id
 98e67ed59e1d1-3adc8668936so747994a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985938; x=1793590738; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mcKmQWD5BzKPZcYyv/2kD79SsEZPAeCLB89VrkV54d8=;
 b=Tk5ijWBnAmcIvSYkpLBesW5I7yz/v+MPR1x/RxcDcW5roHNSu4Hc/T/7IE0lTw+gLw
 YgMgktQsSvcCBTByE+7hQipANxjpDXQGwT2wCTiI6AlKuLCSgp+zC7gvwjvIbZuDJz2q
 NGwMjonsyF2eutmHrRfwVEGx90ahF6VBHUcDHTLCWhBKD42bLIyR+mf6TVjZk9Gf8AWF
 CBoMMbiQFcFg+U2rg4EKDFk/7rCySmU7H05b8QtQMViK/NAnRBdV7XhnPmxfxT4bVqza
 UNjPZSwzYtjW+rPTazL0j1YAsBGIkuVVJnAIcXuROmUQIDiEPS+LAaHoxLbp04sffutD
 7V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985938; x=1793590738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mcKmQWD5BzKPZcYyv/2kD79SsEZPAeCLB89VrkV54d8=;
 b=oOi1F7yyH72Nr/c19PJ7M3WxWHBm30ns71OuydlQcAV3bjpaR2eCpjh0KXzUVixi9n
 Jqej3XcGGdQlHvZVkiB2UTcHIRHJ6D3B/OFvf5gsNf8uQrjei0ibyB8E5t7JoUlUXKM2
 7W8hoLEejXkb4Uld1UVk8yH0rtwguHAMLJitms/Dh+Kni9w9aZAW2waDhfPwz7OOD8jy
 MGWHz0wNnVmfPS3Jw7QkoNmjMuG3YQtnilBtROLP9BxIz/Yuaj2smdOSJVKlaxo87EuE
 NoTz+2nFAgg5nVLV8uuW4VPPgP26fn7U7Ip4uZfTeTyxD7XYpUqCfBBeDII1VbTKXpG5
 j+Kw==
X-Gm-Message-State: AFq9FYL2GEUYZl2Gqsfdxuz2EXzjq6Oz14I3AaEXvbE5Ui7XRQ8TRGlL
 fcRMGo60PJTmUykOCOALbnLSIfIrm3c2ve3xVUQ4Vs+TP34dTTlwzJH+XoHdLghx
X-Gm-Gg: AYBFou0BsIHfbPWfRK4U2ZyKH9+HJkxA3VQDUTP8sQOKNkqYxYfmnne3u0G+Cno9mGE
 UrAWDL/rVwbSByYld9k5f50Eo4KTz/Q2ihMpvSpTte7Fjt4mJdOGOQbk5NGIFCB1AtVsRXGhupT
 AKqCBASWF27PiFPT95bFv9VuV6331qptPzbktfdJn/lYgewLR7UbwiLtaRvTa9GThk+WEybUgGy
 IUSxn2E0i3cTPNMBp88mbCNsYebfItYmeFyiWYsle+U4holNB2BSBWvR76eI4t9NlS46DDstsb3
 vUF4H8japy2iP34YO5DMKFlM5Tux7YNvX9qly3BdVYQDBTxyzPF0MRReKiHMTrlEUOG3wxwi2Dp
 rPIqqDB8cHxpdcOqAgTsaDXBEeYWrgNOxV2hsu8X896ZDEJGBZCMDpS2rwStEq5GXgUJIMYMobl
 qWPdKvGLW45dy+FsbHIj50ghjcH4eh5bGqbfhePRzXJB9SJ0qmYcU9HEUYpBl12FvZQH4xcLQj+
 r/Fj2pDUdGtRuMl64qbeobjqrT/E1iHHErDV9zom/oPwcznrORuX6SrAbhNwegpDVyD7ntv+SUN
 cTF+pYarYjFmsuNwC4PkGlR0PvsahRCQN3IaD8k=
X-Received: by 2002:a17:90b:1b09:b0:3ab:36c4:b4ff with SMTP id
 98e67ed59e1d1-3adead248d6mr4684275a91.24.1792985937744; 
 Sun, 25 Oct 2026 20:38:57 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:57 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:44 +0800
Message-ID: <20261026033745.784107-15-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBY7-000000000h9-28sL
Subject: [f2fs-dev] [PATCH v7 14/15] f2fs: allow large folio support to
 writeable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

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
index 29d39737232d..4db92c85ea99 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3282,7 +3282,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c9343eb6b5e..53914629c604 100644
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
index f621d5e65023..3d621a20766d 100644
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
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		err = -EIO;
@@ -720,9 +711,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
@@ -1194,8 +1182,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
