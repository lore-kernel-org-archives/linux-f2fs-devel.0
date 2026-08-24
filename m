Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BBBC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7aWqr+mQ7bfyLvAalv5bJoasUTYKhdHucVhd4mrm66A=; b=W9TP7ANTjXVopI4u6sP8hiyZJM
	65jY6LwKjzUbOuZ13VuGFeMQ1CdsyiCfF+OyaQ9yXpG6FYU/Rp5G5Or2rIOh9AA1NO+DkZPUchjQ8
	0kMVQP96DqcTXjM7CM6oafVMoS4jRlIb30csiE1lPgl6rN7qpEt+MFmnJkeXzgPEyjCU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wySHW-0004lu-Nt;
	Mon, 24 Aug 2026 10:51:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wySHV-0004ll-I3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=; b=lrOp8lZaQXgVEUIceKgAfsqvvv
 moMzJpfRy4yHP2G1vSvuIduhc8KxWMCunr6DF3sznt79XVPEUq+bQMybWY7rD69S5MGs1eRgXwg8S
 9L7zyXQsc2kIIip6rMjDIEVLiF+v7cNrWFe7KSygUogpOUyYXnFnDLpkAK/uv+ncCEes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=; b=Fn6TFzw8iisLQ/0qGkk1uLxhTj
 dTkzMgzwhjJdrPRLLcQ1o1UytpPH6eNdXobPud9lFE7K9lmCb5tPzvqyJ3sLmmdSg8WrAWlzgaSta
 iR83Rgb/ErNkpplHi/ZWoRI3Cze+2m8q+lMzI/uJFY7CpqIYVhDMy74PfXllxjZVH8us=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySHV-0005Gq-4u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:51:57 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ccf2360620so28553045ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787568711; x=1788173511; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=;
 b=Pr6Wxx+S5XwWmKBxTiZSEjqZDd8CNhN8OtlmP4zgXj9WIJte1HYDjzEEJ7Vsy72OlM
 oxlEuLzDdx2l17LMGyaJivNIUK6bCaS1yZyZOo53+XAZVq9CbXoEd+uwlsRSa+BeSlzX
 cWetg5mbbI1NfpC/8VuQwl6yjQYvEVWyR2thR3/7hP+0hC6EF3lzv8708hS4HkUX6QpZ
 GwA3h1OHbqC4PLr2Y3/uKYINP4aB6wZo4gEos3b2Te7aZI1+XyigCmsdmoayPIccLBiH
 v6Lp/pEmaS8xNqct0LaSq8+GhRZM6dJU9nVY8Fmrz8xs4OLPbQCjeLVd4zlD7Eom9/ev
 HvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568711; x=1788173511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=;
 b=qsGobVQrKMZCGxJaOWxugHJLJV+94W19jj6Vyvvq25CV9ZRoh2ka3/KaeoBj/r23cx
 E00y3worCNRDua7kLZtiguD3F8UZxanfvoi9UWuJjXtPvEpfM44w+LKwP+adCsZ9sm4g
 q8WYdcQviyTusM8NB7+DNJES+9giciN1RxB37FoqOlnOX+g8gZj7Gue0G/naKhckSBe7
 Lq5c54O5CezXrJ5+RhXnonOq6zUs7xsZVLj8yu/E/81o6EqTw5VscQ/AHEIyVtnlXrxW
 FXwaoFxmgzG0Ec4zIVHTHQgTXEMwbRKueSwjxkjX3hUSfC3Y6WNcMH8wS6DP78nlCY5d
 jZrg==
X-Gm-Message-State: AFuF++nqQ+0m0XxRVbn+2lVI6fiXfoVRkaTbHVgDLJO0y1F8qOfzoy6k
 BKtXC8ZNnbQDxuazmEEUyogVeF048hqEKoV0muJ3Jf7zQlJVmjH4kTbT
X-Gm-Gg: AR+sD12GfEcZeW41dGP2E+GvVxWR+SM60WfoF3/qAKPtSaz3XkK9IZJ+lRoFJfhveG4
 fUDjHimPBwa7iLnHtzYCWe0DRiZV7tHTnB+vLcNWO9CGdOnjyhq/H7CIvfVPQpWsDBJ1eA4Whdg
 glSh8eFErMmnRNUshr/9LN6l+chgANsYYId/CRzH602b6RXSbkk3d5NhDJHampktTkLk1pJJrOR
 uL1IdM6qiOgmarzJIdktG7m/gauOVel+BK/Yw/G8DTIr2AuRfsY29kZ0x4ncgJn2yUe6k600Ep9
 3DXIVo5g/uZwWzlXvwCkUx1hG+hLGWhHc3EX/cndj93fevkosu4/CFQpA8r1Xi4xt+DSzUmxU6t
 YxHxG/iUdE7T0HTp5ZGgIm1ICLZ/oMCxW9zdwhS589cUD3tc/BvQowN3iZNOBL2Z7ipWt5H/gAd
 jUNO1ptQ8jAJcJgnLmdnJXuurO+5h03b4Kg3Ca5A62D88X5eFvlGW5cM6CyixPhERgYvtXJJCDO
 KhSG3aJt2zOO4gAMxTTBcq+
X-Received: by 2002:a17:90b:2d91:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-395c39cd288mr49656738a91.14.1787568711410; 
 Mon, 24 Aug 2026 03:51:51 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af6e88sm9708996a91.9.2026.08.24.03.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:51:50 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 24 Aug 2026 18:51:37 +0800
Message-ID: <03790070c828924d98ba6d78e909391fb0014c7a.1787568046.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787568046.git.qiwenjie@xiaomi.com>
References: <cover.1787568046.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wySHV-0005Gq-4u
Subject: [f2fs-dev] [PATCH v3 RESEND 2/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for IOCB_DONTCACHE
writes and advertise FOP_DONTCACHE.

Keep the F2FS-specific lookup flags because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 774a3e2d8e3..ebd9dc582f9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3981,11 +3981,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
@@ -4031,9 +4035,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	folio = f2fs_filemap_get_folio(mapping, index, fgp_flags,
+				       mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d82be8c1502..8e9d86dd42c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5912,6 +5912,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
