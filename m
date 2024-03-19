Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E763C54E68
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:23:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rmgvm-0000tU-7S;
	Tue, 19 Mar 2024 21:23:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1rmgvk-0000tO-VO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Mar 2024 21:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=; b=ALuj/NYwo4yFj16reSlE2JZOiS
 foC9JIJ6YyXdYs7T598p1lqjBn/+DExmwOr36Gp0LcCJKxwPIgvO8cEDwHFGSzU3JGq7R4vTE8QK/
 h/vyVs8XrjwbV+S6tLn4QzVkLcznE2o7+zqsWF+zDMouj1//wlwtsa2bXeXA8rG/UBW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=; b=T
 GIPqdsWt9w+AXzAilSJv1uNrSumyIZxoEKr7TPxzJzxrinjTEyGSPbieQdZO31Nk93AUFFoX1YO0Q
 HJaXLw+xTmc2KS8o7wRes4I7O7vEs32RbSNu8GK/AWy3woEuqwBgV3WoyG18zRbhY4YXsbGFu+DbI
 UVzgJelCmR1XHCj0=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rmgvb-0000sU-UU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Mar 2024 21:23:33 +0000
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1def59b537cso30568805ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 19 Mar 2024 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710883401; x=1711488201; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=;
 b=lrICW+LlGeL27mJeePVl6nqz1qx5Lioz7w/4kgyDCEKxPqn4E37yDzbJZVf6Lp9pYf
 VIAQkheQHqsxIBYM3no3d2KSpmXFpoTEqI19vIEE3BpuAa921+R/nVPnkkZrAt6g+Wna
 30qqkEjDaQ5Hvy+/IHLRByfIyxfMvKBAza8fE8L3Fw8Vly/LwWM2VAAwB9y0bcL9m3Gv
 PGylhSzXwhUaB3YUr2+x7eJ8WtyoDtvl5iNbUeBc5OEx8ZY3eRLKptIqnm9WyuPJy25B
 oDcjofCv8kOXMm8M0VdfLei8he1xWNTBuNwUQs4qn5edhRpRIQ5Mfd3rkIcrBh4F9vat
 EoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710883401; x=1711488201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=;
 b=dkDXdjfE1xac+54RD51kgxYb0tmH6L8HHcO+sdKVr3Gj7tl4pESEqwp71EkBnoicK6
 KHDvF/ppdhoZppItAqKKA/6ACm+JxKgC/OzLHASlg1dSq/WUBTVAMGoVhqpJ7S3IAVwZ
 aPxfviwrMqrM3SJAK9hPWL60L8LKCZNCV+fggXm3KPeLheKNRN3EnNIqOAk6wiWIyFGn
 H5Tt8UJlQpTaLNWnVzSR9H7qZdhsjMlIsUJprLmspiF0xsakxg2FI4gK7SGB4gprrAsN
 t8qcWJj86prdE/i8wkN7zZpT5N8LcaQvrslRMdA5tkvQ75K5oYMAOtN2mvcZRH1U36fU
 d3Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Bh2DV14x6UMCf0mD44qJvzPbg3XJHppGKzZVs93E1CQgXGcLBJulGv+InD9IQ2++83oAOId68eSou3kb4PvsAMTkTKMGzwxJRGm3BUmviG33e6BKUg==
X-Gm-Message-State: AOJu0YwVtZM+9+d76DGgqpBLafeeDzwIcr7OC95L4FE9ICABGSaVBC43
 d+FKJt5c92y+M0rYewCdkP2XynUgBwZHShRskGoW1UlmTfj2xDKX
X-Google-Smtp-Source: AGHT+IHdjdv+4okA5Kq7qrqysZRqYyE5cosG4uacKotZlgLZ+KDOK+5X2eAlLu/RoJua4ZlsLFOqTQ==
X-Received: by 2002:a17:903:11c8:b0:1dd:8ee9:62c0 with SMTP id
 q8-20020a17090311c800b001dd8ee962c0mr16359417plh.34.1710883400709; 
 Tue, 19 Mar 2024 14:23:20 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:0:1000:8411:ce48:f01a:1f52:5e0a])
 by smtp.gmail.com with ESMTPSA id
 lh6-20020a170903290600b001d94678a76csm11893613plb.117.2024.03.19.14.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:23:20 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 19 Mar 2024 14:23:16 -0700
Message-ID: <20240319212316.4193790-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
MIME-Version: 1.0
X-Headers-End: 1rmgvb-0000sU-UU
Subject: [f2fs-dev] [PATCH v3] f2fs: prevent writing without fallocate() for
 pinned files
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

In a case writing without fallocate(), we can't guarantee it's allocated
in the conventional area for zoned stroage.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: covered the direct io case
v3: covered the mkwrite case
---
 fs/f2fs/data.c | 14 ++++++++++++--
 fs/f2fs/file.c | 16 ++++++++--------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..d3e5ab2736a6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create &&
-	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
-		if (unlikely(f2fs_cp_error(sbi))) {
+	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
+			 !f2fs_is_pinned_file(inode)))) {
+		if (unlikely(f2fs_cp_error(sbi)) ||
+		    (f2fs_is_pinned_file(inode) && is_hole &&
+		     flag != F2FS_GET_BLOCK_PRE_DIO)) {
 			err = -EIO;
 			goto sync_out;
 		}
@@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+		if (f2fs_is_pinned_file(inode))
+			return -EIO;
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	}
@@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
 						 &dn.data_blkaddr)) {
+		if (f2fs_is_pinned_file(inode)) {
+			err = -EIO;
+			goto out;
+		}
+
 		if (locked) {
 			err = f2fs_reserve_block(&dn, index);
 			goto out;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82277e95c88f..4db3b21c804b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
-	bool need_alloc = true;
+	bool need_alloc = !f2fs_is_pinned_file(inode);
 	int err = 0;
 	vm_fault_t ret;
 
@@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 	}
 
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	if (need_alloc) {
 		/* block allocation */
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_block_locked(&dn, page->index);
-	}
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (!need_alloc) {
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
+	} else {
 		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 		f2fs_put_dnode(&dn);
 	}
-#endif
+
 	if (err) {
 		unlock_page(page);
 		goto out_sem;
@@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
+	/* For pinned files, it should be fallocate()-ed in advance. */
+	if (f2fs_is_pinned_file(inode))
+		return 0;
+
 	/* Do not preallocate blocks that will be written partially in 4KB. */
 	map.m_lblk = F2FS_BLK_ALIGN(pos);
 	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
-- 
2.44.0.291.gc1ea87d7ee-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
