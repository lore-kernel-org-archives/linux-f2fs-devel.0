Return-Path: <SRS0=ufY1=N5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA46C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Sep 2021 17:44:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C119D606A5;
	Tue,  7 Sep 2021 17:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C119D606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mNf8h-00049u-Ei; Tue, 07 Sep 2021 17:44:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mNf8g-00048q-Eh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Sep 2021 17:44:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LBiYYbH6LYG4ZmjQuo2rjTaMlU0Gp9G0WtfKq1aJWb0=; b=AHCaGdnYsPBgrbJsq1xb6uEaU7
 IDbbeqOt1IDb0Ecfab9tAkcHZQqrMLFvwdIUb/j8QsC+KuLYFKCT/Eltwp2U6ySbQ6FFez4rDiUbF
 rmFuO3Q3h2AVDDzxVrAGoy3hfBHoIvuSot+uQ2BwbXq6n3Kw31S9j3bFJSpUcSrEV8Qs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LBiYYbH6LYG4ZmjQuo2rjTaMlU0Gp9G0WtfKq1aJWb0=; b=Y
 5mjHcDAsi9nQqE/4Uu6iTIoq9BTHS7L4IGVfYEXSgP8+PiA/uuBUIrwoaN4TEXj4MXf5f/fnqSVb5
 PqadgR7BHfvDi05G97M3wL8dhYSgu74Fc6RGhp+hKWQKEKC0JA7L7maW6LgjArsYvYTAdPasWxNuy
 zIuwKpy1PVcCFpuY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mNf8c-001MzJ-UN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Sep 2021 17:44:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F364B61100;
 Tue,  7 Sep 2021 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631036635;
 bh=1ooFZpKqsBvjIUgPnu7sNf+hGTvO8sAO4kCwQMRgOt8=;
 h=From:To:Cc:Subject:Date:From;
 b=FlAFCily+RzvE8/i45sreE7tux7+xYNJYLWFWPIZEF3Gi0416JMvSINnTzx22Tg7r
 uLYKHAxIl8NDxcE0AcfNHpk2GkV1tkIt9elgiOeWTO5Wx1xStLpIKVATrmQ9c9fO7A
 LKkvHaLMofqRwSVoRTwvwESrG6ZUkoX/8fqzIadJrpfp9CF9Y1jA3Q0AZHP5CCN96W
 /dBtOR6XWA2WDJp2z6quJ/D+1Ubj5dtPW+ce8VF44ukgIhYv97A3EeBzBZvn98QIeE
 Ia/iPSnMRiXoP3ZpOFDudNlgEKvarJkvry9oOTMP7JeYdNWPE1hel801a97f8XAuP/
 ghIYRrZHRHjeA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  7 Sep 2021 10:43:51 -0700
Message-Id: <20210907174351.1104857-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
X-Headers-End: 1mNf8c-001MzJ-UN
Subject: [f2fs-dev] [PATCH] f2fs: should use GFP_NOFS for directory inodes
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We use inline_dentry which requires to allocate dentry page when adding a link.
If we allow to reclaim memory from filesystem, we do down_read(&sbi->cp_rwsem)
twice by f2fs_lock_op(). I think this should be okay, but how about stopping
the lockdep complaint [1]?

f2fs_create()
 - f2fs_lock_op()
 - f2fs_do_add_link()
  - __f2fs_find_entry
   - f2fs_get_read_data_page()
   -> kswapd
    - shrink_node
     - f2fs_evict_inode
      - f2fs_lock_op()

[1]

fs_reclaim
){+.+.}-{0:0}
:
kswapd0:        lock_acquire+0x114/0x394
kswapd0:        __fs_reclaim_acquire+0x40/0x50
kswapd0:        prepare_alloc_pages+0x94/0x1ec
kswapd0:        __alloc_pages_nodemask+0x78/0x1b0
kswapd0:        pagecache_get_page+0x2e0/0x57c
kswapd0:        f2fs_get_read_data_page+0xc0/0x394
kswapd0:        f2fs_find_data_page+0xa4/0x23c
kswapd0:        find_in_level+0x1a8/0x36c
kswapd0:        __f2fs_find_entry+0x70/0x100
kswapd0:        f2fs_do_add_link+0x84/0x1ec
kswapd0:        f2fs_mkdir+0xe4/0x1e4
kswapd0:        vfs_mkdir+0x110/0x1c0
kswapd0:        do_mkdirat+0xa4/0x160
kswapd0:        __arm64_sys_mkdirat+0x24/0x34
kswapd0:        el0_svc_common.llvm.17258447499513131576+0xc4/0x1e8
kswapd0:        do_el0_svc+0x28/0xa0
kswapd0:        el0_svc+0x24/0x38
kswapd0:        el0_sync_handler+0x88/0xec
kswapd0:        el0_sync+0x1c0/0x200
kswapd0:
-> #1
(
&sbi->cp_rwsem
){++++}-{3:3}
:
kswapd0:        lock_acquire+0x114/0x394
kswapd0:        down_read+0x7c/0x98
kswapd0:        f2fs_do_truncate_blocks+0x78/0x3dc
kswapd0:        f2fs_truncate+0xc8/0x128
kswapd0:        f2fs_evict_inode+0x2b8/0x8b8
kswapd0:        evict+0xd4/0x2f8
kswapd0:        iput+0x1c0/0x258
kswapd0:        do_unlinkat+0x170/0x2a0
kswapd0:        __arm64_sys_unlinkat+0x4c/0x68
kswapd0:        el0_svc_common.llvm.17258447499513131576+0xc4/0x1e8
kswapd0:        do_el0_svc+0x28/0xa0
kswapd0:        el0_svc+0x24/0x38
kswapd0:        el0_sync_handler+0x88/0xec
kswapd0:        el0_sync+0x1c0/0x200

Fixes: bdbc90fa55af ("f2fs: don't put dentry page in pagecache into highmem")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9141147b5bb0..1213f15ffd68 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -527,7 +527,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		inode_nohighmem(inode);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	} else if (S_ISLNK(inode->i_mode)) {
 		if (file_is_encrypt(inode))
 			inode->i_op = &f2fs_encrypted_symlink_inode_operations;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 9c528e583c9d..ae0838001480 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -757,7 +757,7 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	inode->i_op = &f2fs_dir_inode_operations;
 	inode->i_fop = &f2fs_dir_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
-	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 
 	set_inode_flag(inode, FI_INC_LINK);
 	f2fs_lock_op(sbi);
-- 
2.33.0.153.gba50c8fa24-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
