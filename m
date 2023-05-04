Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34623C7EE22
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 May 2023 19:47:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1puevN-0004Il-UX;
	Thu, 04 May 2023 19:47:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1puevM-0004If-F7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 May 2023 19:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OmLPl2eNOZInt089Vn89eZv7XYNNfavZA4NELy2AdT4=; b=ViI8juSqN09Ai7ko3XLS3NCWC3
 mm+Zrgel/USvLtDQd4SRckp+muQEK0tTGfCthCuV+v7ZgMMqssxVyVZ+yOlzpVTPgoXpI2gkPbdtK
 W+MLsd7IgIwESF8w9uErPKEhq3W4UQau6PPXyUHY64iOtdqeRB9ujS8ljAlzbg8hqB9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OmLPl2eNOZInt089Vn89eZv7XYNNfavZA4NELy2AdT4=; b=b50aUXN2XEtQxCEbkc1taZnr6I
 NQsOz//WRSsMR3p4F/KmdrBtSMMBUDsXkc+QXa8FZVP4K3cGxLRZs0PfFPpvhjrsNp1NAueff0erC
 Ra8F0JMdvc0uxh42gIaTZXZwSVDSFqV9QLH0mjqG8XZRTZ8XhnNK8V+qS+/ZrEkc/+Gg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1puevM-00EKlP-OU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 May 2023 19:47:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 614FD637DB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  4 May 2023 19:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC0C4339E;
 Thu,  4 May 2023 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683229646;
 bh=2PTBGeOsk/gS39KadSWvDtVC5Qt5OW3aSzXEn6Ld6TE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KjzHflVthCIt92GC1Z/z0iDtpbjquy17XQhKjWrtUQn6vpK4fu3AmGJHXvIIEXgCJ
 uZ3ONWEi6N9u9IaFFf4QtR/yPtPgy6nKbtErPpbmGyPdRIBZhOhYO3GlNtDIf6Sien
 a9M21uolYAjS9oHKbe5lLB8noNkYr4IS9mCXpZkjdnbtCV/qxUHC6ydogUH1zRyqRU
 eiFPsnhs+bapXbycBrZa0j/M1cFPLiAduHEuYu+JWDNp9iLCQ3qkKTOoxDaEpMqyYW
 Cr0avp/HeWactw5W5Dqk7v4yHrUkiOszkDZ3SqgxCwx3baltRh4d68vBfqYEuaar01
 dCsGmRPxz7ACQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  4 May 2023 15:46:01 -0400
Message-Id: <20230504194626.3807438-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1puevM-00EKlP-OU
Subject: [f2fs-dev] [PATCH AUTOSEL 6.1 24/49] f2fs: fix to check readonly
 condition correctly
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit d78dfefcde9d311284434560d69c0478c55a657e ]

With below case, it can mount multi-device image w/ rw option, however
one of secondary device is set as ro, later update will cause panic, so
let's introduce f2fs_dev_is_readonly(), and check multi-devices rw status
in f2fs_remount() w/ it in order to avoid such inconsistent mount status.

mkfs.f2fs -c /dev/zram1 /dev/zram0 -f
blockdev --setro /dev/zram1
mount -t f2fs dev/zram0 /mnt/f2fs
mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.
mount -t f2fs -o remount,rw mnt/f2fs
dd if=/dev/zero  of=/mnt/f2fs/file bs=1M count=8192

kernel BUG at fs/f2fs/inline.c:258!
RIP: 0010:f2fs_write_inline_data+0x23e/0x2d0 [f2fs]
Call Trace:
  f2fs_write_single_data_page+0x26b/0x9f0 [f2fs]
  f2fs_write_cache_pages+0x389/0xa60 [f2fs]
  __f2fs_write_data_pages+0x26b/0x2d0 [f2fs]
  f2fs_write_data_pages+0x2e/0x40 [f2fs]
  do_writepages+0xd3/0x1b0
  __writeback_single_inode+0x5b/0x420
  writeback_sb_inodes+0x236/0x5a0
  __writeback_inodes_wb+0x56/0xf0
  wb_writeback+0x2a3/0x490
  wb_do_writeback+0x2b2/0x330
  wb_workfn+0x6a/0x260
  process_one_work+0x270/0x5e0
  worker_thread+0x52/0x3e0
  kthread+0xf4/0x120
  ret_from_fork+0x29/0x50

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  | 5 +++++
 fs/f2fs/super.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 87664c309b3c8..550065ace7da0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4471,6 +4471,11 @@ static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
 	return false;
 }
 
+static inline bool f2fs_dev_is_readonly(struct f2fs_sb_info *sbi)
+{
+	return f2fs_sb_has_readonly(sbi) || f2fs_hw_is_readonly(sbi);
+}
+
 static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 14c87399efea2..67589b54dd26b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2258,7 +2258,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
 		goto skip;
 
-	if (f2fs_sb_has_readonly(sbi) && !(*flags & SB_RDONLY)) {
+	if (f2fs_dev_is_readonly(sbi) && !(*flags & SB_RDONLY)) {
 		err = -EROFS;
 		goto restore_opts;
 	}
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
