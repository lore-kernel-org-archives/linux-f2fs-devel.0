Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C403C02198
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:28:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti7AA-0008RJ-WB;
	Wed, 12 Feb 2025 07:28:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ti7A9-0008R4-Ql
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 07:28:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zF6ExVwvA3mQesrpUwQJfPq+iPXUdSAeFq4r6aaLVnI=; b=Mq1qTJZegc1/Jt4s6KnlADma7M
 VuBhQluPfXDUbn/5tD75J+NDnpGUmXOa0LiTpcAm3mJMfcFbmXWBB/Ip8b78KsB6g8y2Abu+ObGDq
 ZimzfcfeZy1qBneUu4l+/rIfqXy5H70Q+12ELIUlHs8DCRIcdw2T3AvoaKTZYr0w2VPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zF6ExVwvA3mQesrpUwQJfPq+iPXUdSAeFq4r6aaLVnI=; b=B
 X5F62btya9+n+7fxrfrjmbrD+dF+5ugmR0jHK9ddId/ZzcqpulZUB+APso/TsOJF15MMLDA6hmKHI
 GnvcVlkCRmUFa4JoEDQjRnTtfIJkB/IdAnv/RofbhuGPklAJdMX8Fl3do9U9lMnZbSfEYWoFib9eQ
 LukVVV4mcSFZ+C4I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti7A9-0007CH-Hv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 07:28:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 963495C5CEF;
 Wed, 12 Feb 2025 07:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAAC4CEE8;
 Wed, 12 Feb 2025 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739345276;
 bh=sdksGRP2vixl/lXNtlPoxYaFwobAYlGWEnGCtPc53N8=;
 h=From:To:Cc:Subject:Date:From;
 b=J81eFXJ7lsepQan7xtGidQhqputQKJeEDGpWnvvU42NyDdYg4PvgnkGzHROx8+MjQ
 jD1yfR36tUfyp7dlzCkYKtWZMlrHEn4yn8HDRwTSwyeK+vqREghJu8UWuxl66QNQmD
 U0Rk6Q7Rj6nSWPpJIsiY26xHqkiGRRw17/YmwjsWm84BhCZxFqsZovZ+e5mCfw0X5k
 Wq0eTlmZWttkSKgxCiyu9hQYcbNKm51+cddlCjUdaq0WbON8w5ew+AV+ZFHkmbgaJM
 JQA6JJHggUATiDVA6UhRzKoOjmYm4x6H6Pjb2lBU1Re5IeZtAp3bIyavUD+HpwV/kw
 ZJIt/5g0IwN3g==
To: jaegeuk@kernel.org
Date: Wed, 12 Feb 2025 15:27:42 +0800
Message-ID: <20250212072742.977248-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
MIME-Version: 1.0
X-Headers-End: 1ti7A9-0007CH-Hv
Subject: [f2fs-dev] [PATCH v4] f2fs: add check for deleted inode
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
Cc: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, Leo Stone <leocstone@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Leo Stone <leocstone@gmail.com>

The syzbot reproducer mounts a f2fs image, then tries to unlink an
existing file. However, the unlinked file already has a link count of 0
when it is read for the first time in do_read_inode().

Add a check to sanity_check_inode() for i_nlink == 0.

[Chao Yu: rebase the code and fix orphan inode recovery issue]
Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Signed-off-by: Leo Stone <leocstone@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/inode.c      | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bd890738b94d..ada2c548645c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "orphan cleanup on readonly fs");
 
+	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
+
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
 
@@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 		f2fs_put_page(page, 1);
 	}
+
 	/* clear Orphan Flag */
 	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
 out:
+	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
 	set_sbi_flag(sbi, SBI_IS_RECOVERED);
 
 	return err;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 05879c6dc4d6..1c75081c0c14 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1322,6 +1322,7 @@ enum {
 	SBI_IS_CLOSE,				/* specify unmounting */
 	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
 	SBI_POR_DOING,				/* recovery is doing or not */
+	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d6ad7810df69..02f1b69d03d8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
+	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.48.1.502.g6dc24dfdaf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
