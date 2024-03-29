Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95863C6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Mar 2024 19:13:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rqHfc-0004mm-JL;
	Fri, 29 Mar 2024 19:13:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1rqHfb-0004mf-Em
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Mar 2024 19:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OC1MEhfk5zHZtmtDn8IoZmjvwG8ImnYzdrSVs5t8doE=; b=LLoGkLXWlHu+/20EGBw/L8B0fQ
 JgKHUHVNqYvD9hCM1pjC260Ko2Hspo8Sf2z9h26iWyp7yQDa5eraq8raCSoBKYoR+6dQzdZgGKipC
 Fr03uSIahc+2C6dQ+2i6s04XY0oSNq5kmm+mx25saCmg9fOm8IBs5+sIc9KjwrlfYePM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OC1MEhfk5zHZtmtDn8IoZmjvwG8ImnYzdrSVs5t8doE=; b=c
 8BTtZwPZHbRnJ4oS+vMVq7Fx0beAUArAlKmH+g2fY8ZbCV4E3xyRrWYHnwTzgrcmeHWOqnWGDE0ie
 +Jv1jFw1kjGVdlnFx1jfR3MNMDEqhv1V+huVuKBLfKj1cD7kbyJ7Oq3TEZMrWe8aBFJevhOaX9qFE
 MgTgcBn6CzbM8JlM=;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rqHfW-0001LQ-4d for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Mar 2024 19:13:43 +0000
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1e0411c0a52so19816855ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 Mar 2024 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711739608; x=1712344408; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OC1MEhfk5zHZtmtDn8IoZmjvwG8ImnYzdrSVs5t8doE=;
 b=Smknb5k+PrPjF6FNkLei5GsVCw7JLdsS0HB7of7pyVzxse/fB6ac2XPZKePyz33ElP
 AiD0bz03jh9oM0J6seKaOgmdoLuArXJFteF6UDtx8GxSfDtzv5YkvrG4fPWTca14xWxu
 CZfQEHdbMiUMyprs6lwiUsHpLX4SbnCQEjMwX2chE7MJLREla0wh3FoA/rEsSx2ShQ8q
 8lHoM9ZO+n3npFFCwFCqlTOyTy44mXAKcswpXqsHGFd/1T6U0kY8SvgMi9D5XEtouegU
 ijiYVByImC/I/tjk/LxX0ZGFuz2jRXsaEshE1jDJ+Ss/hG96svh+M31xcOuzyCP7uqUC
 vC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711739608; x=1712344408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OC1MEhfk5zHZtmtDn8IoZmjvwG8ImnYzdrSVs5t8doE=;
 b=tpyg0tpa8dRqHgDtV49S6jiof9OAPhELj/N9GF/kLxKmH9+ypfv+VzvJps1GPETcKp
 7+VavF9WnXY781uovDDJxS9Dn3vi9HdTZ/im7UjnxNRKJQMaAXyRl7h1Tl2n79ESy+Mj
 u6uRcw1J10Nt7n+jbazfxeFdI9Efa2VpyqSygqHfE6uopNHuHmhlmUWR8SaVkffpUfGp
 vA6QGYapK2vK8+9sqCR/lErZRfQzOYIapTtvBLL79e8KoMl6hmJiUGCbszU3tie2Ex+F
 trRRPvnZb2lRYrFZ+YKqyAVi6E+glsnU/cC1zZFUt1O/0RUXDyO3Q54d3ET1HYLU45tz
 8N4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHuSy9bNQlOPzWkYuqTrRPt4fCxxJLtMXNW3Mecn2bY7QkNVuJ7lZYzavXOexu1ViMoadCa+E4mnic4IwDRb4D2YbTIdSAzFyzks9fRj4Uray2o2qN6w==
X-Gm-Message-State: AOJu0YwPH+mO2Bm8cT9raJPDnNb5z0KTFf0cu1ltS+OzWPHzAFve1wku
 CgQlQFaWDZEfT1Gr6sE4Qg1lsNMxdKG2GfrLTCVDIPQzV8mUduVe
X-Google-Smtp-Source: AGHT+IEknzraJh4UqQ4FSWGhNpf8wM7e2P/YApxyqJgZzWOUOjUwadFbO+GrnpnhMgoLnPvfhVch2Q==
X-Received: by 2002:a17:902:9691:b0:1e0:e85b:b9ca with SMTP id
 n17-20020a170902969100b001e0e85bb9camr2974329plp.21.1711739607464; 
 Fri, 29 Mar 2024 12:13:27 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:0:1000:8411:c1e7:139:2884:f40d])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a170902db0900b001e0fdc6e4e7sm3805147plx.173.2024.03.29.12.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 12:13:27 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 29 Mar 2024 12:13:24 -0700
Message-ID: <20240329191324.3233324-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
MIME-Version: 1.0
X-Headers-End: 1rqHfW-0001LQ-4d
Subject: [f2fs-dev] [PATCH v6] f2fs: prevent writing without fallocate() for
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
in the conventional area for zoned stroage. To make it consistent across
storage devices, we disallow it regardless of storage device types.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: covered the direct io case
v3: covered the mkwrite case
v4: moved pin file check position in prepare_write_begin()
v5: removed unnecessary condition in f2fs_map_blocks() and disallowed
    pre-written inodes for file pinning
v6: check a hole for pinned files in mkwrite()
---
 fs/f2fs/data.c | 20 ++++++++++++++++----
 fs/f2fs/file.c | 20 +++++++++++---------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..1b02a9291176 100644
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
+		    (f2fs_is_pinned_file(inode) &&
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
@@ -3414,8 +3419,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 		/* hole case */
 		err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
-		if (!err && dn.data_blkaddr != NULL_ADDR)
-			goto out;
+		if (!err) {
+			if (dn.data_blkaddr != NULL_ADDR) {
+				goto out;
+			} else if (f2fs_is_pinned_file(inode)) {
+				err = -EIO;
+				goto out;
+			}
+		}
+
 		f2fs_put_dnode(&dn);
 		f2fs_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO);
 		WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82277e95c88f..6793c96019a2 100644
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
 
@@ -114,19 +114,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
+		if (f2fs_is_pinned_file(inode) && dn.data_blkaddr == NULL_ADDR)
+			err = -EIO;
 	}
-#endif
+
 	if (err) {
 		unlock_page(page);
 		goto out_sem;
@@ -3235,7 +3233,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto done;
 	}
 
-	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+	if (F2FS_HAS_BLOCKS(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -4611,6 +4609,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
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
2.44.0.478.gd926399ef9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
