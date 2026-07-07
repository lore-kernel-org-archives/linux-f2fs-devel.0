Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8208C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dhxRGaE70uO8r9UqfcGhwH5SQoSRrLBd4CWGFUGCHfI=; b=QDHkqU4Z0/HPELgunGb9TKSxGJ
	yF8fn1p1MPTTZC664+5fCr86PlKlAoXJp1LN1UsHT28icDSLZiK7ZIrcKlNN2wjkMhoZe/Wqs0SCn
	43w1XHlBZftwNJjtqOsoHfwOZ1dTqmz8dtb59u9SnsyT2gYSmlXgups/+0YCollsAGiE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wh49g-0004qZ-EM;
	Tue, 07 Jul 2026 11:40:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wh49c-0004qL-Rf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 11:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hv6ECuVxgmg/zj45Tp0KIT0r8U/VUnKGooGk8kRCb8=; b=g7HlSBc41/HHUSll4AKuF1YKJG
 izePbwp4uzzVRB4G/dH6pVOhySjpr+DMTYg9Rf/42evwQGgGFDHBNBk+Zlkk6RryAYuE978ecYs2m
 mBgg5Ynf526SA9mshsxwUz2HOGEH2NtNkMPPiMBP5GAUAP301mErkqexwdu+B738BRPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8hv6ECuVxgmg/zj45Tp0KIT0r8U/VUnKGooGk8kRCb8=; b=D
 FD1rfmHvPSmTJO8xQhQ5cTILTZrVzcoQbxxeEj2dJFSgZmpMpO7jzZhynKfeqZEk2aTBLDwQUAPjO
 rE3xbWdNaqRm+iHBeryW+UVoyA1hy0aB4+KfAzeLY0ov9UPU8cxFjS4E2972nr5VjjfoyeI1yWghX
 D7lE5eEQNv3rzhNk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wh49b-000529-BW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 11:39:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 381846001D;
 Tue,  7 Jul 2026 11:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9144B1F000E9;
 Tue,  7 Jul 2026 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783424384;
 bh=8hv6ECuVxgmg/zj45Tp0KIT0r8U/VUnKGooGk8kRCb8=;
 h=From:To:Cc:Subject:Date;
 b=Ull28zYrWWnV+VmDkdFti2SgXmWMV3Ny1lLQLrhqN0RgT50WeLJ1jVh/VAXvtD5I/
 C8cZSJslEOkxpx2F/xr7I1OpgUGPpNZWqK6mgDIyq7D+EMUz5+dP2WuhJiQ7h07xr0
 dwMIwr7xS4jtEhLdjBvlWHL+MaEig2mQEJFbLCpPcj+57GKuE0GF8FUUj7if7jNN4b
 cMmzNGql+IbKvFlsQIhSmJqtM/xrsTD8z6cDX8p57PjR+55/EKKeBIltTq6ENIG35/
 ti19bqrQU9mViZxsAUg6D0RDFY/rp1pinH4aFK185PIqk3Rr5QoLA0vqdJFt6TzEd0
 dR1uJ5Q4GmoOA==
To: jaegeuk@kernel.org
Date: Tue,  7 Jul 2026 19:39:33 +0800
Message-ID: <20260707113934.3003158-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
MIME-Version: 1.0
X-Headers-End: 1wh49b-000529-BW
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: quota: do not use GFP_NOFS in
 f2fs_quota_read()
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
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in read_cache_page_gfp while doing
f2fs_quota_read") adds GFP_NOFS in f2fs_quota_read() to avoid below deadlock:

- do_sys_open
 - vfs_open
  - dquot_file_open
   - dquot_initialize
    - dqget
     - dquot_acquire
      : locks &dqopt->dqio_mutex (VFS Quota Mutex)
      - qtree_read_dquot
       - f2fs_quota_read
        - read_mapping_page (GFP_KERNEL / allows GFP_FS)
         - __alloc_pages_nodemask
          - try_to_free_pages (Direct Reclaim)
           - prune_icache_sb
            - evict
             - f2fs_evict_inode
              - dquot_drop
               - dqput
                - dquot_commit
                 : tries to lock &dqopt->dqio_mutex again
                 ==> DEADLOCK (waiting for itself)

As Jan Kara mentioned, quota system has fixed this issue w/ commit
537e11cdc7a6 ("quota: Prevent memory allocation recursion while holding
dq_lock"), so this GFP_NOFS flag should be relic, let's use GFP_KERNEL
instead.

Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to use GFP_KERNEL instead of 0.
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index da468df058eb..b1725ca68010 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3168,7 +3168,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 
 repeat:
 		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
-				GFP_NOFS);
+				GFP_KERNEL);
 		if (IS_ERR(folio)) {
 			if (PTR_ERR(folio) == -ENOMEM) {
 				memalloc_retry_wait(GFP_NOFS);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
