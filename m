Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48F606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZMWorvw7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hCP1tJUv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DrBVQNJZ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPy3rvES
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ipDDMRKQPrYh4PCteMfIOSsVXBkiBm/BEW7ssOMaJ2I=; b=ZMWorvw70b1HOf2Gmx/CvNo5QE
	InR5oglSd2U008CVQBLSgFCQ/GwWZ1tsBw7TikqRLAmsRQJTdWUniUdP1e0/pBlOLviAF5fj9EE+Y
	RXm1SQUBli4C+OVQ1SKSAwZqT9TqAptlxLdOWXHp4tt8fdmI4xBevmn1WL2WTYNHZz+I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsIC-000000003oG-2xTF;
	Thu, 22 Oct 2026 12:53:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsIB-000000003oA-2yVL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTdxIjwF0CBphPx6QBICzBF4QJdGWk+rlqebDhD0eR4=; b=hCP1tJUvpf4oU6IyxINUGxa8OM
 P11BQabxMs7yqX47ZJf1bFP2LXQDm4tQf/SCyV562uvOunBbGqe/22H/uHHARLTPnIUCSsT90efbM
 cw0TgTvetXShuZ1LSfaKsFZLhdaDIuPXXhK/eiyYCQvCfj25MeySfU0BMsv+6uAHvIoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTdxIjwF0CBphPx6QBICzBF4QJdGWk+rlqebDhD0eR4=; b=DrBVQNJZN1n95U0gNnqh8bm0rk
 rnw7wCw/Y9xpZMhJdToR3zv6JzckJKHDvt99oFJ7Rnve+QaMvDqSBN4WI9xCmbM1imigXbfwHRP5J
 69Rsz7nEw9VjHPlaobmPLpD88FvwcpmJkq9XmAlf4NnextrRXPBVylXzTlaz4PwVmai4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsIA-000000001GT-0HZ7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E6236057A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4163D1F000C5;
 Thu, 22 Oct 2026 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673584;
 bh=qTdxIjwF0CBphPx6QBICzBF4QJdGWk+rlqebDhD0eR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JPy3rvESoWrcsCOyr6huaonU7SSQUACKLwnlV9CO8i0PIBbgQoX8GUv07efy94s2X
 DvyV5B3AAvXXpTRfp997kRA2Sj6yMe1aEA7biPYJ2MguZdexCOutW0bx3zlpSekwOa
 Q0BkfKtXWl9wScDxw0VE0R4+mYk4y7zTsZ6WZ8KCsGBnx4jdZ9rfsdEvPmC9eBfovN
 8Vnt5v24z1VLKlgqVr9+9mhzpPoN/NOadhuR/8s30NcHXNtPvXvEh0NOPfm6KgSRse
 aURBOMfXpWEPhMWVyJnYy9tT4hGIp1UsaoZp/exFGEe12FmmjOtkI1mbgoBbOcxTwK
 V5SiyiBMJ+MfQ==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:43 +0000
Message-ID: <20261022125244.2205275-6-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125244.2205275-1-chao@kernel.org>
References: <20261022125244.2205275-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsIA-000000001GT-0HZ7
Subject: [f2fs-dev] [PATCH 6/7] f2fs: fix to serialize truncation of COW
 blocks w/ GC
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

GC migrates blocks of COW inode w/ the COW inode and its i_gc_rwsem,
however f2fs_ioc_start_atomic_write() truncates blocks of the reused
COW inode w/o holding COW inode's i_gc_rwsem, it only holds the
original inode's locks, so the truncation can race w/ GC.

Case #1: GC caches stale data of a freed block in meta cache

- GC (phase 3, cow inode C)		- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
- f2fs_down_write_trylock(C's i_gc_rwsem[WRITE])
- ra_data_block(C, j)
 - f2fs_grab_cache_folio(orig mapping, j)
 - f2fs_get_dnode_of_data(C, j)
 : get P
 - f2fs_put_dnode()
 - f2fs_is_valid_blkaddr(P)
 - f2fs_folio_wait_writeback()
 - f2fs_wait_on_block_writeback()
					- f2fs_ioc_start_atomic_write()
					 - f2fs_down_write(orig's i_gc_rwsem)
					 - f2fs_do_truncate_blocks(C, 0, true)
					  - f2fs_truncate_data_blocks_range()
					   - f2fs_set_data_blkaddr(NULL_ADDR)
					   - f2fs_invalidate_blocks(P)
					    - f2fs_invalidate_internal_cache(P)
					    : nothing is cached
 - f2fs_grab_cache(META, P)
 : cache P in META[P]
 - f2fs_submit_cache_read(P)
 : SIT of P is still valid
					    - update_sit_entry(P, -1)
					    : P was freed
- end_io: f2fs_cache_set_uptodate(META[P])
: META[P] is stale for a freed block

On superblock w/o encrypt, verity and compression features, checkpoint
does not truncate meta cache, so META[P] survives after checkpoint, then:

- checkpoint, P can be reused
- writeback of victim's atomic write
 - do_write_block()
 : allocate P, write victim's data to P, META[P] is not invalidated
- GC phase 3: ra_data_block(victim's cow inode, k)
: META[P] is uptodate, skip reading
- GC phase 4: move_data_block(victim's cow inode, k)
: META[P] is uptodate, skip reading
 - memcpy(tentry, sentry)
 - f2fs_update_data_blkaddr(newaddr)
: victim's block was overwritten w/ stale data

Case #2: GC reports a false inconsistency error

- GC (phase 3, cow inode C)		- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
- ra_data_block(C, j)
 - f2fs_get_dnode_of_data(C, j)
 : get P
 - f2fs_put_dnode()
					- f2fs_do_truncate_blocks(C, 0, true)
					 - f2fs_invalidate_blocks(P)
					  - update_sit_entry(P, -1)
 - f2fs_is_valid_blkaddr(P, DATA_GENERIC_ENHANCE)
 : or in f2fs_submit_cache_read()
  - __is_bitmap_valid()
   - f2fs_err("Inconsistent error blkaddr:...")
   - set_sbi_flag(SBI_NEED_FSCK)
   - dump_stack()
   - f2fs_handle_error(ERROR_INVALID_BLKADDR)

All other truncation paths hold i_gc_rwsem[WRITE] of the truncated
inode, let's hold COW inode's i_gc_rwsem[WRITE] during truncation of
COW blocks as well, then GC will skip COW blocks due to failure of
f2fs_down_write_trylock().

Cc: stable@kernel.org
Fixes: f18d00769336 ("f2fs: use meta inode for GC of COW file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 363039da3ab2..3a7093a7c12e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2445,11 +2445,20 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		struct f2fs_inode_info *cfi = F2FS_I(fi->cow_inode);
+
 		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
 
 		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
 
+		/*
+		 * GC migrates COW blocks w/ cow inode and its i_gc_rwsem, so
+		 * hold it to serialize truncation of COW blocks w/ GC.
+		 */
+		f2fs_down_write_nested(&cfi->i_gc_rwsem[WRITE],
+						SINGLE_DEPTH_NESTING);
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		f2fs_up_write(&cfi->i_gc_rwsem[WRITE]);
 		if (ret)
 			goto out_unlock;
 	}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
