Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D9606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PYMzeZz2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KkhnA7qv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NGczSUji;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QWofwikh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=bqhFdAwCjrYGE8YeIQC3Kq9AEJeBC5uMxUMUJCHYbUk=; b=PYMzeZz28VMeumsK0uwEoT7q5+
	hA5+ztVTGfSCc5tF+udoxJ9s1mKdkyHKnM7y81619uerZkxA+1oV+mAeyJZ6HyMycfPKBOxv+TojS
	lVxVo3ZwULUV7vG+4kV/ZEqZ09yMGYbfqzAjHxG3UB6h4L8zJeK7f+3dHA9mw5M8PjRA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSkEj-000000000RW-0QiU;
	Mon, 16 Nov 2026 00:06:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSkEG-000000000Qj-23C5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 00:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=; b=KkhnA7qvRs+56Jcvn0or34FSf7
 SdIa89Q0LM30en8ue8RnD6xOqwncsUrQSA1AwHFnJ6itf6dlkjMetGz32dQR6kpJdUtPwGf7iU4dT
 JBUD/ZnhG02iSNJKSQ4QdLFQQ6D6jsrCPb/+arGioH3XUnPLb1UcLzJO/6Hhq4jTqseI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=; b=NGczSUjip9XxC7W+7xgHeRaowO
 tcTozsh3lzONCMsFbbijRcLSLAGLA4bs5K+D+dUhn+V/9io3pVeqflde2jhsaLD2b1s2geh1XnAAF
 CNrj0evLusZefV9s4PbK+BmSLy5Vf5DqzBgJWgGZJi8VvM9xbHJMEUP9RxBc4aVM9tJc=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSkEF-000000003vp-3VEz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 00:05:48 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso1163660a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 16:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794787542; x=1795392342; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=;
 b=QWofwikhqnaH6V0uHKIeB3meNYi5PMS0zH1r0VeJrzHY3lK0K3g9l2RIIKjbyMqoz+
 L/qujcwIvqZKxE389Z/REYbP+fuMrRz21DJefWqF3o4RIfsZzSe883WNzyltZw293EsJ
 fauHPUY1mNpssn0maX4DB07w7axXObBV5t6YbPLZvQHSttjeLZHxlLano1LEsHctjDui
 B0l/9S/7Ulo4gcr8NA0gD3VUSkxML51j8nEeOBWOCG9CAdBKqqDAW3dPDsaPiwZre90n
 9POR94PcqYqdAOP4iKA5mwjpTRF5H+cZLWkYSsLdIA/WVfdyz83xsvK+2gFKEOmvCYgj
 disw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794787542; x=1795392342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mu33zRxTLj/T8n79JxXB0QUEhj/+4hEOSMdZCp71jRQ=;
 b=LKqbnLcn/6i2toZfZvqYMMUrOy9RfStacS68i1mohuxwekO7ZTb/FqIsrINO04f6+P
 R4G1Oo0vkyma7lfFLy3gmXOHMJp5i9mUUL4mdTBFL/boNv9Ryh0ndZzAhTeiodKzD8w2
 IWM6bhEmPT57ioGfOx5YJjxSTNf7K6CxB8XFg/OJhsPM1LDMGZPriitYFP+OYyZwqJzw
 Uyh1Sg9bBv6MCPDTa++/uhOwn+MtOxewEM0cDx8tKDBPZf99VkHHrQKyzb4jBK42NzyS
 83U9RJC5Ha4qpURDqHznh+L8gf79c9KaUR2uyJvdldPwKTeFhdtP4XdWZcXBsH4lrb2f
 pWlA==
X-Forwarded-Encrypted: i=1;
 AL+hErFUGxKg5PprqA8w6ySyZyPzabW5rOwtVMar0MzJsU33R3vFDBo9Ifb4ZYkCAOUkaA0ZO1AbLDMrQYbGjOIne3lU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9ivbBndZi6tYZM3b0Ydgvbjx5F5J8AHvELJeUpH2OEVA/4H6VE
 eM3UvnipRMnQi83Dd/ismEnR6sxuxc3MAHO1cJcTh9mo8l/rdOHt7iOA
X-Gm-Gg: AYBFou1ImlYt+tjO72TvU3z8YxYushDyKqMiVVcB0Zd3vNAHPfy55j0BV8almvg0ScC
 Sg/zlLh63/jczGPMFwlbhU7WkecrSv0pMVJj0pJCeHqIJVUtCJ8s2u6uHlzNiEcU9LPyTAK75Vf
 v9MdlmusCIeOCUh+oifv8ioIN1mosTjF1a61LWaFrPa40cMGUcFWPY7ZxRHAA4krxlKdu+4hglx
 5CbQBIkYxj5wQXSmhOppwBLBXb6oyRUzFGOpOz/FMJznIaTPs7RfK/awtZOX/c+0t7iAM9Ev1ef
 3DQlqJELmY/w7rHla2l9eVDBdckUHbC+t2O9rMjQGYxIP1BKy/sh8ph1UqViQYBtGMAXKbKQvzv
 /LAMK4sch9WriHlTIosaGsF/7kvX5PVR/0LABh44RrSXK3sGme50GzME+qT6qGAq72ZN+KeEQeY
 h9dg3bJEoL6j4gkvh0FFXae9XZackAA/QdW8NB5ndQOiwzB6txzbr/bd3pwaR1+jqAPf2Ide6mj
 8hHKAyfn3RcMJkAoqCjXWjvxg0vKT9oDfEQx8Z4sS4LhEwh2a6SqF4xCmJ5/Y8fAQ9S39uM/Xkz
 ieIf5gelgFkckM3d1UHRn/oToB/IVFBvcbLMotRJEkJGFKloxfKDqQSvJnZoX7qnQDcXQjh9qT/
 Xof7n+GderESak1RzYPvJ/D6eAZUJ1jLVGCZMzIQhFGY2N9s=
X-Received: by 2002:a17:90b:5585:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3b1b0b88263mr8081903a91.44.1794787541921; 
 Sun, 15 Nov 2026 16:05:41 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197c6c9c5sm18881187a91.1.2026.11.15.16.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 16:05:40 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 16:05:34 -0800
Message-ID: <20261116000534.2303800-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSkEF-000000003vp-3VEz
Subject: [f2fs-dev] [PATCH] f2fs: don't skip the inode update for a size
 grown within a block
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

f2fs_skip_inode_update() lets fsync() skip writing the inode when
FI_AUTO_RECOVER is set and i_size is block aligned, relying on roll-forward
recovery to recover i_size from the position of the fsynced data block.
However, do_recover_data() extends i_size only by a block that starts at or
beyond the recovered i_size, so it cannot recover a size that grew within
the block holding the old size.

For example, on a 4KB block filesystem:

  write(fd, buf, 14KB); fsync(fd);
  write(fd, buf, 2KB);  fsync(fd);
  <sudden power-off>

  - the first fsync() writes the inode with i_size 14KB.
  - the second write() makes i_size 16KB in the same block. If it is in
    the same timestamp tick as the first one, the timestamps do not change
    and the inode is still clean, so FI_AUTO_RECOVER is set.
  - the block is already allocated, so the second fsync() updates it in
    place and writes no node. f2fs_skip_inode_update() skips the inode as
    well, since i_size is block aligned and equals last_disk_size.
  - recovery finds i_size 14KB in the inode from the first fsync() and has
    no block to extend it with, so the last 2KB is lost.

Repeating a 2KB append and fsync() up to 16KB and then shutting down the
filesystem left 117 of 1200 files with 14KB on a 4KB page kernel, and none
with this patch.

Set FI_AUTO_RECOVER only if the old i_size is block aligned, and clear it
otherwise, so that fsync() writes the inode for such a size change.

Fixes: 3a3a5ead7b6d ("f2fs: do not recover i_size if it's valid")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50a5f845176d..b328e678d295 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3676,8 +3676,9 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
 	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+	loff_t old_size = i_size_read(inode);
 
-	if (i_size_read(inode) == i_size)
+	if (old_size == i_size)
 		return;
 
 	i_size_write(inode, i_size);
@@ -3686,8 +3687,16 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	f2fs_mark_inode_dirty_sync(inode, true);
-	if (clean || recover)
+
+	/*
+	 * Roll-forward recovery extends i_size only by a block that starts at
+	 * or beyond the recovered i_size, so it cannot recover a size that grew
+	 * within the block holding the old size.
+	 */
+	if ((clean || recover) && !(old_size & ~PAGE_MASK))
 		set_inode_flag(inode, FI_AUTO_RECOVER);
+	else
+		clear_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
 static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)

base-commit: b9d7379d10d43386b59082da8c9a0b111e054781
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
