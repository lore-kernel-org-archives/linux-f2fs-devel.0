Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9821FCCF2D6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zfNHvJwhhub8HL97/LvtNska0y+o13Oi98Ebkj2GLig=; b=c639ggbEk6P6GoEsiMm7LUf/4G
	X4xIRoy7pRGEss2upi/CnQ0V5Sd5kwIE1gl2X+AhJsRZ9rNGqk0XqagyNYfos1sxUsS6nQMa8Mg7Y
	jITgD3tMGyawZK+7Z/52CveDyzJznWbk4PQGxLF2y0vnf73M0V1zog6vwRl8mzf6bIHE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIn0z-0003cV-AX;
	Mon, 19 Oct 2026 13:02:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <39xTWagwKANYBHJMK2CGOKCA8GG8D6.4GE@flex--jprusakowski.bounces.google.com>)
 id 1xIn0x-0003cF-U9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tfewtHe0RF/RFkGE9CYlrvaqKRem/t1cV4TMGTUJaIU=; b=aaZOxdJK06DqABDkQqyQQ7/3ir
 PrWCApHK5MTgKOJD2Lo+TunXUj2JxlZDR55nNAhRNWc+ZQ2AAyFGmoiUEYwIzE2HxpyKiffPN/L3d
 fLncaZN7va5N/0jONLR+u5Q2sP8Q841TCmPnsLGuYsYOwE2xBLUxPr28OKl14UUpPfVY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tfewtHe0RF/RFkGE9CYlrvaqKRem/t1cV4TMGTUJaIU=; b=Y
 gi0oj7tv1bUawjae719Bq/aHI9H/Z+0kkcfEQ/OBmFshLYxN+juxiby/IRIovxhqqTChmNZCEFtWd
 Gqeo502zsyG3E3mtBFPYNIGU90IRI5cYnWuN78vk5NWhfFDZ0Wjms2JwmLJrPGGtnAWexMmKzH9Qg
 xTB6Hks7RB8AGelY=;
Received: from mail-ej1-f72.google.com ([209.85.218.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIn0w-0002Bm-5i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:02:56 +0000
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c41b03cd1dcso175655966b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792414967; x=1793019767;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tfewtHe0RF/RFkGE9CYlrvaqKRem/t1cV4TMGTUJaIU=;
 b=NWd/pam4PX4pMNsC2GkvM/nLVQns+VHC7SslOAwsVj7KEHnE7TbVKc17Fqs22C/0ZW
 waHiapnnlBChyUL28qBNLfgJMmkp/Jt0rAiM0T2nhaM1NcoCoxbNSQFMsK4GEkrVSU2a
 yljcM5MMSiWdgvK9KJ7zYb4gIJ/vpjPv/CNXCfTF4WpcrgD/JeiPRbtwuajfDCDHASsp
 FfROmwe9RXndT7mU1USPAImpmkyczXyQPkOE7SXcoVb3eOiwvpyvmrZAs19VlXjcFtM1
 jzTxkPx7XwSX+sXo4u3EITEQwfzRpASLigohHd7A3GIM7IzhxWafbsvamE+gA794Ond9
 agDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414967; x=1793019767;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tfewtHe0RF/RFkGE9CYlrvaqKRem/t1cV4TMGTUJaIU=;
 b=GA14d02BrShRMFQvhS1a/Eg4oBABrvPFz18yXzYrs4asFwo/1lO8zAgndHT8BvolpU
 /534LNrnTr1IP7ePCLkH07eCfo5a9CFC/Fb8jgYgVzMdWJqeTbdEGQVrLfvv2jb2wlXb
 Q1Gbt8E6rPmpIHIObSFeLEMwarfzFgcVOKylrOcWQ9fELznxc/S7D46Nf3Won8YNTSq+
 2IQWpSzIIDpa7qmKZ14rXbqXSJ7GPlag1DUk7NFGfAk0Vw1prWJqIcPGktHMQx99QBhR
 1px+FicVFLWUoOxsMkhVD90ogmgS8ZA2eekgDbu0pobxoCLf6VG+tZGk4vJTBHGxsM7Y
 VO9Q==
X-Gm-Message-State: AFq9FYJhYHfnEO/I57TvEsB8emLbznMQzuK+2u2WIC2WnJwTVz1jLZHj
 rEnOmI+6qPvvCig1okSVbW5S7WE2LywJP4q+GkIvTf1wToa/ELEsm1tlc7eOp1whJ86pFGS+g2e
 KhF5qeIK422ldA5tzRPqYCFozdev/Tg==
X-Received: from ejblu20.prod.google.com ([2002:a17:906:fad4:b0:c34:dd5f:126c])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d92:b0:c29:4490:50d6 with SMTP id
 a640c23a62f3a-c41a08e6a7fmr555511566b.47.1792414967175; 
 Mon, 19 Oct 2026 06:02:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:02:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019130241.3751829-1-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1xIn0w-0002Bm-5i
Subject: [f2fs-dev] [PATCH] f2fs: fix stale extent cache in inode page after
 truncation
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

During generic/475 (fsstress with dm-error), orphan inode recovery on
remount can fail in sanity_check_extent_cache() with a stale on-disk
extent (ri->i_ext) whose blocks have already been invalidated in the SIT
bitmap:

  F2FS-fs (dm-0): Inconsistent error blkaddr:212341, sit bitmap:0
  F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=14f2) extent info
                  [212341, 109, 1] is incorrect, run fsck to fix

This happens for two reasons:

1. In f2fs_drop_inode(), when an unlinked inode has I_SYNC set by a
   concurrent __writeback_single_inode(), f2fs_destroy_extent_node() only
   frees the rbtree nodes while leaving et->largest intact and without
   setting FI_NO_EXTENT. Concurrent writeback in f2fs_write_inode() ->
   f2fs_update_inode_page() can race with f2fs_truncate() and write a
   stale et->largest into ri->i_ext after blocks have been invalidated in
   the SIT bitmap. Call f2fs_drop_extent_tree() instead so FI_NO_EXTENT
   is set and et->largest.len is zeroed before truncation.

2. During truncation (including f2fs_evict_inode() -> f2fs_delete_inode()
   -> f2fs_truncate() where I_FREEING is set and f2fs_pre_evict_inode()
   has already destroyed the in-memory extent_tree),
   f2fs_truncate_data_blocks_range() clears ri->i_addr[] directly in the
   inode cached block (marking ientry dirty) and invalidates the blocks
   in the SIT bitmap, but does not call f2fs_update_inode() to
   synchronize ri->i_ext in ientry. Because igrab() returns NULL for an
   I_FREEING inode, both f2fs_sync_inode_meta() and flush_dirty_inode()
   skip the inode if a checkpoint or node writeback occurs before
   f2fs_remove_inode_page() completes, persisting ientry with truncated
   ri->i_addr[] and a stale ri->i_ext.

Fix this by:
- Calling f2fs_drop_extent_tree() instead of f2fs_destroy_extent_node()
  in f2fs_drop_inode().
- Updating the inode cached block via f2fs_update_inode() in
  f2fs_truncate_data_blocks_range() when truncating blocks in the inode
  cached block, as well as in f2fs_do_truncate_blocks() and
  f2fs_truncate_inode_blocks() when FI_DIRTY_INODE is set.

Fixes: 3e72f721390d ("f2fs: use extent_cache by default")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/file.c  | 4 ++++
 fs/f2fs/node.c  | 5 +++++
 fs/f2fs/super.c | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3b5ad281b518..b7a404d0efc6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -796,6 +796,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		f2fs_update_read_extent_cache_range(dn, fofs, 0, len);
 		f2fs_update_age_extent_cache_range(dn, fofs, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
+		if (IS_INODE(sbi, dn->node_entry))
+			f2fs_update_inode(dn->inode, dn->node_entry);
 	}
 	dn->ofs_in_node = ofs;
 
@@ -885,6 +887,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		f2fs_update_time(sbi, REQ_TIME);
 
 		f2fs_drop_extent_tree(inode);
+		f2fs_update_inode(inode, ientry);
 
 		f2fs_put_cache(ientry, true);
 		goto out;
@@ -892,6 +895,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 
 	if (f2fs_has_inline_data(inode)) {
 		f2fs_truncate_inline_inode(inode, ientry, from);
+		f2fs_update_inode(inode, ientry);
 		f2fs_put_cache(ientry, true);
 		truncate_page = true;
 		goto out;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 424e95ca5878..27ccc175c282 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1315,6 +1315,11 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		nofs += err;
 	}
 fail:
+	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+		f2fs_lock_cache(entry);
+		f2fs_update_inode(inode, entry);
+		f2fs_unlock_cache(entry);
+	}
 	f2fs_put_cache(entry, false);
 	trace_f2fs_truncate_inode_blocks_exit(inode, err);
 	return err > 0 ? 0 : err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 773b12ea29c0..acefc1378a6a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1888,7 +1888,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			spin_unlock(&inode->i_lock);
 
 			/* should remain fi->extent_tree for writepage */
-			f2fs_destroy_extent_node(inode);
+			f2fs_drop_extent_tree(inode);
 
 			sb_start_intwrite(inode->i_sb);
 			f2fs_i_size_write(inode, 0);
-- 
2.56.0.176.g3575e65682-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
