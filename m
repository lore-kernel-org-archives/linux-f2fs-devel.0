Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5A0C19F32
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Feb 2025 01:43:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tnpPO-0001vf-Fd;
	Fri, 28 Feb 2025 01:43:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tnpPM-0001vN-Fm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Feb 2025 01:43:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SVW7vZ2fOWgCm866Phot8Dy+8xxKvbdTVHOK8F2W2S8=; b=VLiw8a1lTKTF0FfoKkZtPnTZck
 gLSSYZsIoep36qfGuwlPS8sPIChr8GbphtP5NBU/P1jIwqGfqTntj5TPXjtLAuEmiudl+pAxnWiya
 12XAWU3n4dNVMMpa6Bb8rVD7vEY4Vk4F4uxG9iTV3XD8u3GJ4oZdcXAnsjY96I7DrZg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SVW7vZ2fOWgCm866Phot8Dy+8xxKvbdTVHOK8F2W2S8=; b=H
 vdHyV7+i9xzHPO9cZ98yDBRvk5gsabQE+ax+3qxCp9MSGXzm5mVuQbCyuLe2Css/D03q2bVYpGpwm
 QOwYpRoEa8kMTaFqc+aPvjQ5ifzpoFVM22yMcAeNPGdw/BH+QykA7p6IFRd06map0E/TxQDEgbE4N
 zoWFDnxzYBOx9wLY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tnpPL-000872-I0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Feb 2025 01:43:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 23D8061138;
 Fri, 28 Feb 2025 01:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D18C4CEDD;
 Fri, 28 Feb 2025 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740706988;
 bh=4bxHTBKUgXhyLP5114/1Rtwa8qJMLVErQlbUUaq298Y=;
 h=From:To:Cc:Subject:Date:From;
 b=aXMnK34lixU/3T7P4eBmggcjLP8+w4YFbd8Y6WF19U+wtDSjjrr4JW4P/EJRBWCK7
 Oyn3KaGELp480PUPQbApkSTWHm2r1SklCZZOTiIN4Cdvu4SSz1Nk4zl1M1mpKarm02
 ESdWNJIodv49ItHHp9lhuY87bgV2Re9Htg/xPtz4j3adGv66Mb5JQHB0Hm/YmGkJrQ
 RkZjXVfLmm7XbJVLv/dcF2mdoRHhE7wmrt6wJi9EjxFiBh5zt6CuW9hqXIOoCcddIP
 5LmMRlhJyDxp+UgByKwp6Gpoi/aZe7zYH9gNMcaYYzIIiGqMZfw8WExDG78uJT6xMQ
 7RojYi2ibN45g==
To: jaegeuk@kernel.org
Date: Thu, 27 Feb 2025 23:54:20 +0800
Message-Id: <20250227155420.48885-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1tnpPL-000872-I0
Subject: [f2fs-dev] [PATCH v5] f2fs: add check for deleted inode
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
v5:
- only check i_nlink in lookup()
 fs/f2fs/namei.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 949621bc0d07..e39533482b45 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -502,6 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
+	if (inode->i_nlink == 0) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+			  __func__, inode->i_ino);
+		err = -EFSCORRUPTED;
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+		goto out_iput;
+	}
+
 	if (IS_ENCRYPTED(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
