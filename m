Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CE5C3DA6F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 13:59:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZXLO-0004gQ-8U;
	Fri, 25 Aug 2023 13:59:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hao.xu@linux.dev>) id 1qZXLN-0004gK-54
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 13:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X5RgYva0uI/YfpMcRAQXXXC0hBNumZORbEO2XQnoCOE=; b=XGlkrU0DcN2IGlK+mKpU6HImjy
 ZYGsIUHGwGq7JDunGA9aT+nlK9hiptcbdtESyxtN51j4hztyS/PcELxmotFA1SEXh1Lx3iuFWBlFT
 RcBZaPwl5GaLRR9U3tUkkEjSh8AjVNpoCDXws/ok2LVCp+kUf0Zd3NUWrEuyqd+0DcRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X5RgYva0uI/YfpMcRAQXXXC0hBNumZORbEO2XQnoCOE=; b=W2yusdlzHJU3WyrC7MnRnSYMDx
 2y4c2L6F0z/vNSzw4pMr+ty7oizEYbLWE294whAf5jpvNB+EDDOPvegprleM8nLUCzPnMnMNCg5Tw
 gk5vBqcHsXsdlBXg67Kc8U6U2Snpk6umvD+F8aVeO1VHTK6mbuJ5zM9dm1CAuphtCbWA=;
Received: from out-251.mta1.migadu.com ([95.215.58.251])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qZXLM-00FHln-M6 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 13:59:21 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1692971954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5RgYva0uI/YfpMcRAQXXXC0hBNumZORbEO2XQnoCOE=;
 b=hhFKi9whhR2X2IEmGg/HYYhsZrqTloqAijCXD8QFPZxM06DdOnuDX6HZcxaVx0GnWwP31a
 M0So32b6G0CBwnmz/554zgdXEAR2EreGyRvroTNj1npSBetZMZwgSp6p2inhLbOwP9M7D3
 1+ZqQCM/k54TMM1J4bjoCTeLz5qWIys=
From: Hao Xu <hao.xu@linux.dev>
To: io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 25 Aug 2023 21:54:11 +0800
Message-Id: <20230825135431.1317785-10-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qZXLM-00FHln-M6
Subject: [f2fs-dev] [PATCH 09/29] vfs: move file_accessed() to the beginning
 of iterate_dir()
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Hao Xu <howeyxu@tencent.com>

Move file_accessed() to the beginning of iterate_dir() so that we don't
need to rollback all the work done when file_accessed() returns -EAGAIN
at the end of getdents.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/readdir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 2f4c9c663a39..6469f076ba6e 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -61,6 +61,10 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
+		res = file_accessed(file, ctx->flags & DIR_CONTEXT_F_NOWAIT);
+		if (res == -EAGAIN)
+			goto out_unlock;
+
 		ctx->pos = file->f_pos;
 		if (shared)
 			res = file->f_op->iterate_shared(file, ctx);
@@ -68,8 +72,9 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 			res = file->f_op->iterate(file, ctx);
 		file->f_pos = ctx->pos;
 		fsnotify_access(file);
-		file_accessed(file, ctx->flags & DIR_CONTEXT_F_NOWAIT);
 	}
+
+out_unlock:
 	if (shared)
 		inode_unlock_shared(inode);
 	else
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
