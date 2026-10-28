Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D860A2621
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N027SZXI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z/oI+WJ5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WumfYjcg;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQPXlPbd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=rXyoASA8OkdSx2TnZz6E0Wm5NTqgSd8+RfTLHeoSR3w=; b=N027SZXIo/sK7TUmUD61eTl7KK
	gQ7tSPw2g+7qkc2LK04O9nDrAtY5hzSpsp35C2AsvqEeGOkW2Dj6XiTg+G+ZuKMWuA7nLXDGz3z39
	nbvA85j1Af+5vnvs56zLNs+oDNkfkcyhWczA9XAg7UnL79LXYkbllP1rNZ63n7BFFdbc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5qR-000000000zc-31YQ;
	Wed, 28 Oct 2026 15:45:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5qQ-000000000zU-1dAL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gtH4j3tT1itrQEFkbnlrDQChbAZM+EFXcvfy+QYs5TA=; b=Z/oI+WJ51eNEzUcJNeW4ctnCwp
 NsEntsGc/cAs9eHXKKTW8rux34tZiyb4h8QHn80IuqxImgqNMOjboQtg09+AFBgvgAIPKzm21WpNJ
 nqm/TlT07hY9g84QAU/VTMdbJg/1/8dc4Ujek1KcmFpca1hZRDCM4qUyJRgsJyaHKZ0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gtH4j3tT1itrQEFkbnlrDQChbAZM+EFXcvfy+QYs5TA=; b=WumfYjcgnZkSBcIXYKPlgBN2Q/
 1GzI5xQ+k2kSwL17ZDfQgjWd4YnHi2395pDpC1m1hray1TdzUkKllYahYAdfNvrQXBVPMDIKUpFV7
 2BdjHRFuWnW9IV9wvccG5Tmb44a9bQHTd2ahfgg6BBe7HtmV8aAON2oBbYxveAdFyPxw=;
Received: from mail-pj2-f4.google.com ([74.125.227.132])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5qH-000000003bt-37eL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:42 +0000
Received: by mail-pj2-f4.google.com with SMTP id
 d9443c01a7336-2e96b8bfb43so3796625ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202328; x=1793807128; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtH4j3tT1itrQEFkbnlrDQChbAZM+EFXcvfy+QYs5TA=;
 b=KQPXlPbdNHWLHKCjqFgpvZov8OTSPLaJf1Z3bNrT8v7FMqwsfbPidgqKAsaBT3m7Zz
 HK+zjgt+1bRZhTBlEmtl6S7Hj3SpfZt7GP9NEXw2w3eJ0geQ2/h7uThMy9oDyM1YCQEz
 ub6pUzG09GvCsp/TT29fPtGLguONvKOKXBfhHrjND9z3tphTT7l8TzWlJW+9fTeyChd5
 Qx1rvHW3LCQMWXyvTPwYG9xADt1eBWI+6DIzMOqCs6BwiLk0Qg8pWOyRuWIwrbQmyvZI
 Ai+Adhymqm3EGYx0qqJgrqQEtGpR2opwbiL20KkcUt3KkLlUtMtw9jjJ9N60S/IE5stW
 Xk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202328; x=1793807128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gtH4j3tT1itrQEFkbnlrDQChbAZM+EFXcvfy+QYs5TA=;
 b=LVZPHpT7EsEzKwy5JmjLEeUEe55Ty7NVkdp4WsB+dK94cpsJbhg048dkOwM+LVRgnW
 acSaVBwLCsP9JfQO/5llKfJ02Conbh7cSug6wqSWrHWR8ZcU4/pwPlutvSNTZ23iSN8f
 9sVRx919KZQDUg6TqAZeU076YvyUfxviIa5O6Nmt5cP5yca2zWdHU0ZE1Tm63K4o45xk
 Q05repv/PvMgm/UyK5MNe4Yy+IBzrcX2u3wJesesuW8KAJPInW74nQq3S6LvvSqjmCaL
 39d5wIxfgOFheJHKBikWxPwzmBBhQ+q2onJKdOkEudvC9Tfo5g37aaYqHFQ56Mb9qgmx
 26qg==
X-Gm-Message-State: AFq9FYISCPmf//QV0SDZp2KqdZX0gVxKuJeWmhPf78w2hm+bp87dW5yI
 SpGcqZS8mbZLVkq0FEQrHkbWAzNfSwxXzBrcQVNcoYSdk4rUogMvp+1SeNYE17bzYtM=
X-Gm-Gg: AYBFou3YbNlB9dD4lykUzmx5qlKtmu3GsHHurXFITw8k95I5pTBFl8zZb9DuPkPmTGq
 Zvr0gn3tHGMQI4U1OKx+uQrBA3ReTiz/u0+dYlGQ//CMoKBGqAGE7TkD6CQ7MxLqRjtt6x8W7ej
 uBHk6nXzZV5DEqG6rGidDINq/DOaNRr8n6r+hADh6eghnNbmurScZZBWVNlmvcZMu8CdOr14nWx
 EdMeFfpKC9BVyAP2TuTygIR6NGUSVxkfPrhBVdZwNsVTPERWnFwPsKfeEhbu/90nTibdwD4OC+z
 1ZtY2r3RyoR5mYqfWEQynnw21J4XU0ksZ5P+AG3VmiglxvkhXcNYt4lOzD7oOO0p4xwI5UBwg85
 Z8cR0w12AMxQdznum+iDavNZjqSdh8HQ5XVchNCTv4sbdurTwpwOxYabWJYZsahaWMp5fJ8tUFv
 rQwGL8yJ419t//dpbXy0Ou3iK0m4NiglLg8ixyDMDu9SxL4Jgsk1Te9y8uDVA+FfMo2dREqii8X
 3e1NsZ/Fmw2BDf1GO7k9AZG+jOp24kelqUlmjs0g0UBji9FTKrxtuaZX2E7RWkXxDW8qB2u2fKX
 pmz38TLi/ULhGI5mZrkWwsMvu+Kl59+rfB/Q3r4vQeZIRCJZfgW2ltwGMrq3lYp8CGfhwCMPVOp
 Y3VPEAN2iEQUt
X-Received: by 2002:a17:903:2c0e:b0:2e9:4243:431d with SMTP id
 d9443c01a7336-2eb003b8866mr27729785ad.30.1793202327795; 
 Wed, 28 Oct 2026 08:45:27 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:27 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:05 +0800
Message-ID: <20261028154407.1601430-15-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5qH-000000003bt-37eL
Subject: [f2fs-dev] [PATCH v8 14/15] f2fs: allow large folio support to
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
 fs/f2fs/data.c  |  2 +-
 fs/f2fs/f2fs.h  | 17 +++++++++++++++++
 fs/f2fs/file.c  | 16 +---------------
 fs/f2fs/inode.c |  4 +---
 fs/f2fs/namei.c |  1 +
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index da54fe425f78..cc3c9e51db9c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3288,7 +3288,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 412053e1e507..7974f04893db 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5360,6 +5360,23 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
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
index 8360ac4317f3..15bea642e986 100644
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
@@ -733,9 +724,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
@@ -1207,8 +1195,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
-		if (mapping_large_folio_support(inode->i_mapping))
-			return -EOPNOTSUPP;
 		if (IS_DEVICE_ALIASING(inode))
 			return -EPERM;
 		if (!f2fs_is_compress_backend_ready(inode))
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
