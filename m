Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBC3CD11C2
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Apr 2024 07:26:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rtMvB-0003tZ-SR;
	Sun, 07 Apr 2024 07:26:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rtMvA-0003tI-Kk
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 07:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nXeLSyqlm0ofgMBuASoQ1jIp3rLB1MkJQmGdlpCX63A=; b=jZR83nILYoWGx2no9mT9+0FmIo
 VtL/xdaRCPSRK6vJvSTanscVLEz2I0cBNlmYuuolQlNswIv96BUF1yDg0emc2SetKhPAOH/6EoRT1
 zDb3i4l2GnkLh0F8p7C4RcyP3TC+hj7AI8mfdJlOZweYKWWhrpzLFXMHAoE4nNYC4bTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nXeLSyqlm0ofgMBuASoQ1jIp3rLB1MkJQmGdlpCX63A=; b=FrOt0epK6Ehi/JpoylnNp7si4k
 ig52V/bFgLeyjlmg7xk20CQQZKpPSxPbcb1oon/WLDzEaHO9Hni1FPO0TF1ILlTgr7MXnXtRBOiO6
 hjvMH225uOyD6eNv7Or01lWUEZK+nIWPEB4cSJ1BTFGbARJg6tp4AUqHYopJaBo3O41k=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rtMv7-0001Hu-Dq for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 07 Apr 2024 07:26:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E3FE9CE0ACD;
 Sun,  7 Apr 2024 07:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DEC43390;
 Sun,  7 Apr 2024 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712474777;
 bh=M0/dwoy3n4OuzNbOOGe4V4klmcbe/S0AlwHuaNRNolw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jiKKm2z1nI2lPSoS8JXqg29xDl3qEuJBR0uZ7KUwK7FNDx5n1Q/JtYFuPbdNxPkHE
 kI3Txf7+vJHAVmg5nNVYfpfMKIVBlVgX9ZBKa8RQcHwnhGxqoy5ZG73S/p2762tCEL
 bB7KlyirZFgt2KdxNLY8DbG/G8zBPMypytAQmBXeeY5ZT+PSLkya0dDAA6XgDNRFXV
 QiOXWf8PkC9hxamEBwGTmGLRItScqapqPx7POTCyXdXnU/tCt3ZQXKkknEXlkNXXyK
 r3b47ADfPaBday+P7h4tSGmzr6y1BZuaQJ+SfK4NfIxOfvUCxIMfi56d+zziSZsugz
 kdvI8SuzaDl5A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun,  7 Apr 2024 15:26:04 +0800
Message-Id: <20240407072604.3488169-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407072604.3488169-1-chao@kernel.org>
References: <20240407072604.3488169-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rtMv7-0001Hu-Dq
Subject: [f2fs-dev] [PATCH 2/2] f2fs: compress: fix to relocate check
 condition in f2fs_ioc_{, de}compress_file()
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compress flag should be checked after inode lock held to avoid
racing w/ f2fs_setflags_common() , fix it.

Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca401cf8152a..232dd5fc8ab3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4142,9 +4142,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4155,7 +4152,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4220,9 +4218,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4233,7 +4228,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
