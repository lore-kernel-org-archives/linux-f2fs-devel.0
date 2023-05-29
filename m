Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E953C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 May 2023 10:27:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3a5x-0006cE-6K;
	Mon, 29 May 2023 10:27:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q3a5v-0006c8-LC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 10:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8p3IxKKvyciyXqNDAZWoatytAWdJ2r5FxZ6C28uwR4A=; b=Mi7bK7tlRPWJD+ORZlkvIenDBE
 EBoDdIsU5TLkV9TTnzpvTKFAKi/Xt7y95jRCbKbbN5YlE6cUHHrJBUEtgDJvT5T0uwzRDsIZNR3hT
 WTupE6VPvkflpqbfBFbQtOU0x1etCxY3TaWPUFT28XtV53Xgq5hzxdGKYNDrzF26aGzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8p3IxKKvyciyXqNDAZWoatytAWdJ2r5FxZ6C28uwR4A=; b=D
 J/LuzC9K36JqcaNl6c0Qwu2aaou7cCUAGRjXulB+6F/bzvJvJd3PWVoDLulY74OBUA1Rfdv0GFfxp
 VqoRMF3dOdCQk5z8gmdyDZmkqlUDDBU1XczqrUFIUrv2SsLLLPdS+kbY0/Bb6lYjA1kL5h6ZJd2zu
 qA63sks6N873GgtE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q3a5v-0005ZY-EX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 10:27:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 115296101A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 May 2023 10:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBF9C433D2;
 Mon, 29 May 2023 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685356033;
 bh=2J0FBu1GLBGRIwQwggebk9BRVoGLrhgLuRFIuckJHHI=;
 h=From:To:Cc:Subject:Date:From;
 b=ZzFpUyN1Y0Elgj3/GK6QytCMNyzm0lSghJfxOy4B+QZ/2pqiGQ83xBbFFnHlXHiYA
 SMT8UDDbDer7ud8vybF0cqIpRgm2pXLgreUXkf0pH5Y9RlgQmUUmskM2cS82BuD/2w
 HOaUpc9Q7V0vhnlXtXpgNrxcs6moh/qGjifY6oWcerz6hcdnRwliMhH9r7DR0Hn9UW
 uOJ3rSuWyfktLvl1l9solrbXJBjU0brN3YP3nWKWZAvmWMTBC8d821h/aanUNUDpX8
 J+woCbqvJ7iYeXfpg+B9JrlpktwQGGJIKPTq2r8jDzPxo1AhdszwXdFsno+IAj4AWz
 d/aXcc1S5PzGA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 29 May 2023 18:27:05 +0800
Message-Id: <20230529102705.2546993-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q3a5v-0005ZY-EX
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid mmap vs set_compress_option
 case
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

Avoid such race condition by covering f2fs_file_mmap() w/ inode lock.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

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
