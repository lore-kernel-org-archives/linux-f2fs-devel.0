Return-Path: <SRS0=pHl4=GP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B037C433E6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jan 2021 19:04:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963823109;
	Tue, 12 Jan 2021 19:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963823109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kzOxu-0002Wi-7T; Tue, 12 Jan 2021 19:04:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kzOxq-0002WN-V7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 19:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NM8/JbMd686Rc79BHNE3Le7AVvfwh9fLDssbJfmq9oU=; b=IJnKrcU2ugC3aMgdzU3527QFdx
 p2ak0qkdhHB6JtHhTq2Nspx/qjyQDL6ntyVLjD+dRSciSxevfvhwOKWTeMXrvsFmMpCBbYX3AI9Ba
 Bz3y5q8Hqqj58VHaWSd5h8aOZrI/E2mHEfrwNmMJV5s61HMAeCt2nPeoYLC7rW8L0tPU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NM8/JbMd686Rc79BHNE3Le7AVvfwh9fLDssbJfmq9oU=; b=K
 NfpLFep22cgbGZVMDMH6cFFANACQQ4QFgrN2cZgUqDjgqHRh386lY90arVlsEUWgGyajtixxsLg2N
 03XfcBg8kjXGEuMr+e2QEt1M2iVuULvp0UoaNVekyz6L1yWm3sEaOP9L9nF+Cw+/peb3SANEJR4au
 M/zRPiS+CsyJMQ6k=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kzOxi-00EmwT-3R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 19:04:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91BE723102;
 Tue, 12 Jan 2021 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610478246;
 bh=wf/IxZyot4z6+TGCFFl/vLYIXLEfMHGQ+R6//QMwyMM=;
 h=From:To:Cc:Subject:Date:From;
 b=akzSjn4z5K6XjtApzlhKDAKnQnPLBUtzMb2NO1IBMQIygctwbXH6QSdiOhrEcj/FO
 ECSa11/qjkHKtlesMUGXSnLGyHF1lJscZwKGR0LjeoBmvzef5MtrJy0gl3L0V916+p
 RgucWBgTfiq02xb6t4uZIEkwf9P7WbYf4GC5OGABpxgaRhcgGBGQbnhzK1foT7c/7f
 ISuPZ/2iUMvrXAg62BCAOXuZAOOdoUmX+3Aktu/i5qOv1YbqhnvW/ZwsuOzCK1x6Wg
 iKitkRj/Ykbvvto5ONlnj+0ugIQ0Cux6wTYsmn+uGkEfuW02w5WlRRYm5jMJItx5nw
 lavs9ssSRijTQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Tue, 12 Jan 2021 11:02:42 -0800
Message-Id: <20210112190253.64307-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Headers-End: 1kzOxi-00EmwT-3R
Subject: [f2fs-dev] [PATCH v3 00/11] lazytime fix and cleanups
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

Patch 1 fixes a bug in how __writeback_single_inode() handles lazytime
expirations.  I originally reported this last year
(https://lore.kernel.org/r/20200306004555.GB225345@gmail.com) because it
causes the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl to not work properly, as
the bug causes inodes to remain dirty after a sync.

It also turns out that lazytime on XFS is partially broken because it
doesn't actually write timestamps to disk after a sync() or after
dirtytime_expire_interval.  This is fixed by the same fix.

This supersedes previously proposed fixes, including
https://lore.kernel.org/r/20200307020043.60118-1-tytso@mit.edu and
https://lore.kernel.org/r/20200325122825.1086872-3-hch@lst.de from last
year (which had some issues and didn't fix the XFS bug), and v1 of this
patchset which took a different approach
(https://lore.kernel.org/r/20210105005452.92521-1-ebiggers@kernel.org).

Patches 2-11 then clean up various things related to lazytime and
writeback, such as clarifying the semantics of ->dirty_inode() and the
inode dirty flags, and improving comments.

This patchset applies to v5.11-rc2.

Changed v2 => v3:
  - Changed ext4 patch to add a helper function
    inode_is_dirtytime_only() to include/linux/fs.h.
  - Dropped XFS cleanup patch, as it can be sent/applied separately.
  - Added Reviewed-by's.

Changed v1 => v2:
  - Switched to the fix suggested by Jan Kara, and dropped the
    patches which introduced ->lazytime_expired().
  - Fixed bugs in the fat and ext4 patches.
  - Added patch "fs: improve comments for writeback_single_inode()".
  - Reordered the patches a bit.
  - Added Reviewed-by's.

Eric Biggers (11):
  fs: fix lazytime expiration handling in __writeback_single_inode()
  fs: correctly document the inode dirty flags
  fs: only specify I_DIRTY_TIME when needed in generic_update_time()
  fat: only specify I_DIRTY_TIME when needed in fat_update_time()
  fs: don't call ->dirty_inode for lazytime timestamp updates
  fs: pass only I_DIRTY_INODE flags to ->dirty_inode
  fs: clean up __mark_inode_dirty() a bit
  fs: drop redundant check from __writeback_single_inode()
  fs: improve comments for writeback_single_inode()
  gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
  ext4: simplify i_state checks in __ext4_update_other_inode_time()

 Documentation/filesystems/vfs.rst |   5 +-
 fs/ext4/inode.c                   |  20 +----
 fs/f2fs/super.c                   |   3 -
 fs/fat/misc.c                     |  23 +++---
 fs/fs-writeback.c                 | 132 +++++++++++++++++-------------
 fs/gfs2/file.c                    |   4 +-
 fs/gfs2/super.c                   |   2 -
 fs/inode.c                        |  38 +++++----
 include/linux/fs.h                |  33 ++++++--
 9 files changed, 146 insertions(+), 114 deletions(-)


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
