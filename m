Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19725C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 May 2023 10:47:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3aPK-0006r6-DT;
	Mon, 29 May 2023 10:47:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q3aPI-0006r0-Rf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 10:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vcylAv5lo6He6x+S4Uq6ZLhI5gYyfJgJjz5DF/JnARQ=; b=Rr+mZGYzgKj+URS37tAlbTeEpx
 TNVdYA6oAd35L9pyM+yUsZCLjHBVJBApIlKW4IXsiryUw2FKs0bmNcWcCVxosWNcItiGeojsx/sbG
 i5p3x/1zs66mQHyu2DBWr6F9h/nLx8aPgcL3NYRQsoVLRvaugI7hEqWyHoAzm/ePARXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vcylAv5lo6He6x+S4Uq6ZLhI5gYyfJgJjz5DF/JnARQ=; b=a
 /w2Gid1aAYoea38khbNuXYyK4eTZrPBfGVYnky7mSzJYWN+UiMin8lwBmYnagG3zVKzX3lrFnXGeA
 YYmb0Yh2NfsOOtUYtwGl1vmDaBAYDiufO19O8ix2vyWfIU9QJs1bUZ9otEQ2G5WsHvc5aMOcFuO3h
 tfmE7aVIU06QN+S0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q3aPI-0006bU-11 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 10:47:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 977606236C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 May 2023 10:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AFDC433D2;
 Mon, 29 May 2023 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685357233;
 bh=p/JAPWlDlZsRf7RefrcupA6Ov+l7wpHejJQECxSubZ8=;
 h=From:To:Cc:Subject:Date:From;
 b=EpV1NHYx3TY0K+KckvIZU6XCIIYbfhNZimuoZzikenGGRC5msuC0C5KBNecdgMf9k
 v0SpoQJQKDSdR9LHvJGkJxYFegctz0o81HLAdje69jmnwemb1kWxXgoIsuOD7i3+xy
 wqNULq1TWQL+/bo7jKwHypqYtg3jpPb8ztyQzmTBMPIubVw5EQ08b1Z7UChdK5wYH3
 wx7D0jOBS1XbldBcqBpkrB93BEm5Vp8vAkXjkCqQZLl7JIp7AoV4v8dHI5OX29hSt7
 hyaTo2JNiu0jfCRIP7nN2LqMnIaBhFWm+bJYTiL7SYHaY0RzJWgCc4r/9BJOptZ1rB
 hmB05MlPfKlww==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 29 May 2023 18:47:09 +0800
Message-Id: <20230529104709.2560779-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q3aPI-0006bU-11
Subject: [f2fs-dev] [PATCH v2] f2fs: fix to avoid mmap vs
 set_compress_option case
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compression option in inode should not be changed after they have
been used, however, it may happen in below race case:

Thread A				Thread B
- f2fs_ioc_set_compress_option
 - check f2fs_is_mmap_file()
 - check get_dirty_pages()
 - check F2FS_HAS_BLOCKS()
					- f2fs_file_mmap
					 - set_inode_flag(FI_MMAP_FILE)
					- fault
					 - do_page_mkwrite
					  - f2fs_vm_page_mkwrite
					  - f2fs_get_block_locked
					 - fault_dirty_shared_page
					  - set_page_dirty
 - update i_compress_algorithm
 - update i_log_cluster_size
 - update i_cluster_size

Avoid such race condition by covering f2fs_file_mmap() w/ inode lock,
meanwhile add mmap file check condition in f2fs_may_compress() as well.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add mmap file check condition in f2fs_may_compress()
 fs/f2fs/f2fs.h |  3 ++-
 fs/f2fs/file.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9bd83fb28439..0db8b37c7a4d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4487,7 +4487,8 @@ static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
 static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
-		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode))
+		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode) ||
+		f2fs_is_mmap_file(inode))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7b097ab2f5e4..685ded62fc28 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -519,17 +519,25 @@ static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
+	int ret = 0;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
-	if (!f2fs_is_compress_backend_ready(inode))
-		return -EOPNOTSUPP;
+	inode_lock(inode);
+
+	if (!f2fs_is_compress_backend_ready(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
 
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
 	set_inode_flag(inode, FI_MMAP_FILE);
-	return 0;
+
+out_unlock:
+	inode_unlock(inode);
+	return ret;
 }
 
 static int f2fs_file_open(struct inode *inode, struct file *filp)
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
