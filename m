Return-Path: <SRS0=its7=F6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1ADC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 26 Dec 2020 10:07:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516EE207BC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 26 Dec 2020 10:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516EE207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kt6UN-0002Gf-88; Sat, 26 Dec 2020 10:07:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kt6UG-0002GO-EB
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Dec 2020 10:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FT0wdxh1FvpbTnCncJbCBxzgmoPScp58x99nLt1iOZM=; b=SP7vlY0EcXygJTXa+Hq8ddtnLc
 YXsMfI5sI2HE4oljThU8Mcm7ZG3wZi4Bb+Ip8LXI8TqwRHZYqhLhwCSn11B4esrx8lSDcnaHUnl9E
 1K7r7I4XiuFSPyybVWXD8li+oIZh5swEiTFhoqBqsg+zphxIHU54UqtJ9YAYjn8pouL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FT0wdxh1FvpbTnCncJbCBxzgmoPScp58x99nLt1iOZM=; b=Y
 BqB53d4az0SPfJFnw0Pk+pdLmsvffJN7eV0QESekcEfDZRW0i7jbjAZWA49qnJN9cLRlwUH4LYlHM
 pH2qvA64EQ22/2ptcScG8mLc/XvmYPWYMSYvPum1nDVbodh7bzCPy1pNeZlNctXYaDjmiSk6jVruf
 lnrha4/Rvm/f180Q=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kt6U5-00Ev9j-VT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Dec 2020 10:07:48 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D2zx63FVCzhxYC;
 Sat, 26 Dec 2020 18:06:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 26 Dec 2020 18:07:11 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Sat, 26 Dec 2020 18:07:01 +0800
Message-ID: <20201226100701.30179-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1kt6U5-00Ev9j-VT
Subject: [f2fs-dev] [PATCH] f2fs: enforce the immutable flag on open files
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch ports commit 02b016ca7f99 ("ext4: enforce the immutable
flag on open files") to f2fs.

According to the chattr man page, "a file with the 'i' attribute
cannot be modified..."  Historically, this was only enforced when the
file was opened, per the rest of the description, "... and the file
can not be opened in write mode".

There is general agreement that we should standardize all file systems
to prevent modifications even for files that were opened at the time
the immutable flag is set.  Eventually, a change to enforce this at
the VFS layer should be landing in mainline.

Cc: stable@kernel.org
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1ff5fc10e1fa..71dd20f7ecb3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -60,6 +60,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	bool need_alloc = true;
 	int err = 0;
 
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return VM_FAULT_SIGBUS;
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
 		goto err;
@@ -866,6 +869,14 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return -EPERM;
+
+	if (unlikely(IS_APPEND(inode) &&
+			(attr->ia_valid & (ATTR_MODE | ATTR_UID |
+				  ATTR_GID | ATTR_TIMES_SET))))
+		return -EPERM;
+
 	if ((attr->ia_valid & ATTR_SIZE) &&
 		!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
@@ -4360,6 +4371,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock(inode);
 	}
 
+	if (unlikely(IS_IMMUTABLE(inode))) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
 		bool preallocated = false;
@@ -4424,6 +4440,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (ret > 0)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}
+unlock:
 	inode_unlock(inode);
 out:
 	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
