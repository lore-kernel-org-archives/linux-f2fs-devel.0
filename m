Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BB3C3DA7F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Aug 2024 01:13:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sZKO9-0002zk-NG;
	Thu, 01 Aug 2024 01:13:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sZKO7-0002zc-Ub
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Aug 2024 01:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9TPJLESTFTFqozLhemeKI+MrUZ2TUYWmmnVUN4822S8=; b=Sacs4HlcH2uiIH7oAZxdLfq1Di
 5WdCNh4deZLQ3+K8z4yi6S/RKIUfog7YbdfW+9wgNMYtEHhNN8I6FSvv0EI+jRyoEDCblKi7Cs6pL
 6dqrKX8yMDdGWNQr9oMBB5JMTC1zR8ba60mF3a/Lln+s1l/bUeYXKLRe+lfJie8S0hGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9TPJLESTFTFqozLhemeKI+MrUZ2TUYWmmnVUN4822S8=; b=W
 smmpDed7X8ianaORry9bo9+PRE9N4SvHtCy6XkqPpZIqgVZKPYHbzafFSdNb9Cbtmuj6taiLsHcuv
 hK/nYjfxdvVs40idbeeBYlSBOx0mi5fJRGJQj56my2kPmiaJcVG8bKvY63WRqNr22MR1Ng0Den6ow
 HYMqW3RMZs2c7Qvc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sZKO7-0005Kt-2D for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Aug 2024 01:13:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2BEE5CE181B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  1 Aug 2024 01:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AD7C116B1;
 Thu,  1 Aug 2024 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722474823;
 bh=iCaY9gvrzLDG4TQIuFc0e8gdyx5az7aETYFhapG+6hM=;
 h=From:To:Cc:Subject:Date:From;
 b=FRykYGspBkyvG+rqUcywUTjNX3prk4q2/jRufiOKTukRhyAowsZ0phbLGSeYyjixy
 BX0cG3ZfFMJ4Auf71b9NJ2z32isp0mtkUVkN/9ejwjwhxrs1TzZ9HDqePyFiAx6wzt
 h3Kqp3wpne08KlcuEMEH2qoIbAT0aSZRIuBpxJicUopYGXq5ItCcyf6rqjz7CmoQMC
 BApx8h/FX4C0pvBhjZIVXKiAXuzgHdFtm+IyiKgNv5bu5a9MbFeys/DAcIAxj3ebF+
 PGeQHpnLxD+gOlUBgNe3VA46BKvQvYiH6R2JdKQZcw7S5GKonnVLLMV8bqnrlmWzn0
 /kMJgbbHW3H+Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu,  1 Aug 2024 09:13:37 +0800
Message-Id: <20240801011337.3772536-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sZKO7-0005Kt-2D
Subject: [f2fs-dev] [PATCH v3 3/4] f2fs: atomic: fix to truncate pagecache
 before on-disk metadata truncation
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

We should always truncate pagecache while truncating on-disk data.

Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- check dirty page before truncation
- use invalidate_mapping_pages() instead of truncate_inode_pages()
- set i_size to zero after truncation
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac61c88f7688..a316c21539d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2199,11 +2199,17 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+
+		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
+
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			goto out;
 		}
+
+		i_size_write(fi->cow_inode, 0);
 	}
 
 	f2fs_write_inode(inode, NULL);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
