Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE8BC36002
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Mar 2025 11:33:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1twg3I-0000Qg-SI;
	Mon, 24 Mar 2025 11:33:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1twg3H-0000QW-Hi
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Mar 2025 11:33:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CgWMlUMpPzA1sgpJXeCP4x7QC5yA98FENKnhE5qONHY=; b=YLT8uSkK3SAOyF0yM+TJrBJl9s
 gLtMNLC2E+oYbZN5jPX5FflI+UhUvEHB6Segcm+Hiy/5GCdobWi9ml4vIHDWoyD4ihyE03FDZM6WV
 +r++ZMNmus/iW4ASf7LRYl139xzj7x8gYHImuXhc8IS5l6+iTDh02EsNkNTaFIZjwL24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CgWMlUMpPzA1sgpJXeCP4x7QC5yA98FENKnhE5qONHY=; b=a
 XzH5CtbkoL4pKR7IZo3yOJFN+mLuVppgZxAC8gzfLDMKp74tX8ufDwgle0beD85KGdjoP47O62+JI
 4KaRXXewGwR8DjCna3JA9HGJegK0aPJqa2q4BnVsShAh4sbf3MUyw0pIY7RI2PeCEpPSx+JkNElyo
 yobL39QwE6nNcuMI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1twg3H-00055w-Dh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Mar 2025 11:33:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B2E9A434DC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Mar 2025 11:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA609C4CEDD;
 Mon, 24 Mar 2025 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742815976;
 bh=5Yn65Sps6cRl4jPJWN59bRCzqlR4K0otJY2F4LcuGwA=;
 h=From:To:Cc:Subject:Date:From;
 b=e4UfHK+OL8Q31jb9UOaEEVElbrxhRKASLh4wB1HYs2ZsANBQ39vGcP37D3Yl+XK0a
 aPUtIeO0y4OFyjyCFPf1JM40sA0FbNAoLjvmrw/RV4TBfZGidEBh5R52UU//R+wfyO
 wpwZGTm2p53ZBS63iBHxO8DdX4Psa2UsARRx/tuQQX+TkwaurMbojdkEnG/7WI++Oc
 5azHQxhw8GWC8PAWm2lcyOWJU3u5BVBXGZmj/axKgTHoEPffVOa6NNbEkBiFpFc0TX
 xEDeqCYDKRdd4sSPAHDH8PjxL0jmrFS3q23fuGXSmSWqnyDVqO07bOA8P0VrNd69vk
 9u4vh2ZSC3V3w==
To: jaegeuk@kernel.org
Date: Mon, 24 Mar 2025 19:32:49 +0800
Message-ID: <20250324113249.3084413-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
MIME-Version: 1.0
X-Headers-End: 1twg3H-00055w-Dh
Subject: [f2fs-dev] [PATCH] f2fs: add a fast path in
 finish_preallocate_blocks()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch uses i_sem to protect access/update on f2fs_inode_info.flag
in finish_preallocate_blocks(), it avoids grabbing inode_lock() in
each open().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index abbcbb5865a3..bb6ba3269de0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,19 +554,24 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 static int finish_preallocate_blocks(struct inode *inode)
 {
-	int ret;
+	int ret = 0;
+	bool opened;
 
-	inode_lock(inode);
-	if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
-		inode_unlock(inode);
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	opened = is_inode_flag_set(inode, FI_OPENED_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+	if (opened)
 		return 0;
-	}
 
-	if (!file_should_truncate(inode)) {
-		set_inode_flag(inode, FI_OPENED_FILE);
-		inode_unlock(inode);
-		return 0;
-	}
+	inode_lock(inode);
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	opened = is_inode_flag_set(inode, FI_OPENED_FILE);
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+	if (opened)
+		goto out_unlock;
+
+	if (!file_should_truncate(inode))
+		goto out_update;
 
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
@@ -576,16 +581,17 @@ static int finish_preallocate_blocks(struct inode *inode)
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-
-	if (!ret)
-		set_inode_flag(inode, FI_OPENED_FILE);
-
-	inode_unlock(inode);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	file_dont_truncate(inode);
-	return 0;
+out_update:
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
+	set_inode_flag(inode, FI_OPENED_FILE);
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
+out_unlock:
+	inode_unlock(inode);
+	return ret;
 }
 
 static int f2fs_file_open(struct inode *inode, struct file *filp)
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
