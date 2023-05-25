Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A083FC77B7E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 May 2023 08:25:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q26Hg-0004kS-JU;
	Thu, 25 May 2023 08:25:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q26Hf-0004kM-K9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 08:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nXPYLal8NAxTeORHNzykcZLlgcF8jGrqT7w7+4xRCtM=; b=NoW8iLUwtiMbv+qRH/kaVbPKa3
 NcQmFge6kTQ7VySOa0ztD2XP5It/ydhs6FxcxP/mDPsx9314BylIOeiQ87omc6HiEbAWRUEYEkCg8
 AB2qoj6RXxQsNyBzHny8HSHFQiTyeXyNnaDEw5JziNNCbhbXijVT2t4zIo5epkng5nes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nXPYLal8NAxTeORHNzykcZLlgcF8jGrqT7w7+4xRCtM=; b=H
 r0L+Q/9A3Fk/dY9S2DH4fUG47vj24Nr/sKgUhuZRj5r+QNgI5qWjI5SbSBIR582+txZzAGR+9U7PE
 Us42G5GkMzrSdSFjZGuH4uWcsZYhA+InraNnqa0arT6bpXD4ccLcO7WBH/929CuXXu0yOI188oZ47
 +i6dLuv6m45T2Voc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q26Hf-0000Eu-Ga for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 08:25:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0A90E60FAA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 May 2023 08:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6DDC433EF;
 Thu, 25 May 2023 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685003113;
 bh=wdwLIYaRnnHNZrYI8ePzismwEYz5I7HXxffbJWvgnJM=;
 h=From:To:Cc:Subject:Date:From;
 b=fGHFzqJYUhsyMhG5K89rik+THLbemTJ2u5RuPhWjXMTqcPz6qYmXNegWOUOUO1/PK
 6FLBlJB5y4djFMDRJjCZLbnrEqDkBNNTnwzQBrcmMWqt6cFnTmesOoujqgF2RLCLXd
 bJuRudkQKJ0oofi4hO4icVn9i8fByIIpCqzxegy96cy52af/skg8PlkfWpL1aeYkwp
 h5/KKyB0d0F6gpBWGXpiiemVuL+0LFrGjj1E1D6DldB+Kd4aJG22NYrtjxUsOGxc8R
 J5elbpZrjhM8FLb4W4IIQL0yjAQQny/XyKXikblFtSn2a4WAgZ5SEof6rnTy3271jG
 hZRchio1OJ8QQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 25 May 2023 16:25:08 +0800
Message-Id: <20230525082508.2320763-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q26Hf-0000Eu-Ga
Subject: [f2fs-dev] [PATCH v2] f2fs: fix to set noatime and immutable flag
 for quota file
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

We should set noatime bit for quota files, since no one cares about
atime of quota file, and we should set immutalbe bit as well, due to
nobody should write to the file through exported interfaces.

Meanwhile this patch use inode_lock to avoid race condition during
inode->i_flags, f2fs_inode->i_flags update.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to detect i_flags status correctly.
 fs/f2fs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..1cf84c993d7c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2763,7 +2763,17 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 	}
 
 	/* Don't account quota for quota files to avoid recursion */
+	inode_lock(qf_inode);
 	qf_inode->i_flags |= S_NOQUOTA;
+
+	if (!(F2FS_I(qf_inode)->i_flags & F2FS_NOATIME_FL) ||
+		!(F2FS_I(qf_inode)->i_flags & F2FS_IMMUTABLE_FL)) {
+		F2FS_I(qf_inode)->i_flags |=
+				F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+		f2fs_set_inode_flags(qf_inode);
+	}
+	inode_unlock(qf_inode);
+
 	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
 	iput(qf_inode);
 	return err;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
