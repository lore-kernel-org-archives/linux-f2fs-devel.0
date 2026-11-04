Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CD606D804
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iQ5eYzud;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ap3IKEDB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QluK97AQ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kIL2d4nn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=J4v+sKmqcDY0xq5iYIxAtXrwK+mLgEZWPjtxjLyeZ6Q=; b=iQ5eYzud08b52vDv9Bt2TkfA0U
	ArbYioTPRq/L8C75uRQqtGYngCeTYE7iHCFUqcNUYrlQSrrysKKEZ3ZZS9y+gTDpiUPWzEoRpKLdH
	Tc4xpQzR+Hh/cVTGyYaxVD3T42M88Q/PHgZmzYSgYbzOLf3Xbcs+Mhidn8sEscEFtWBY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOgTb-000000000bQ-1ZgY;
	Wed, 04 Nov 2026 19:16:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xOgTa-000000000bJ-0iQD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=; b=ap3IKEDBpn9VnVLeQ5sAZLIBcH
 nWe5Lr/OvWVK1tYJ9ip59+DDI0xA4prRki1Apvc6xkFHeLLQMPsfNB4cbtMUH3qn/pxEPhh73DZet
 2KQ+hFgWHk5rmKgJRnNjhtYQvOPPVFph+z25272DENRAiTlFG4rmTIGp1exDHu7LetgA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=; b=QluK97AQ+FZKWy5jfdYV8vQcdB
 L4HOns0duW39vApRkaf7DSuaql2kIhJGBeDIBcy6Nip8t30F1BBFH4hV2M7EMGTvmTU2ZmCOcB/gP
 VgmbHxlMtFfiuLg575OfEpRXD8oNLzCpLA7WVDJSEnuG4Nr65uew1JV3LfUZwHqdijJo=;
Received: from mail-dl2-f3.google.com ([74.125.229.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOgTY-000000005ql-3SVa
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:16:50 +0000
Received: by mail-dl2-f3.google.com with SMTP id
 a92af1059eb24-1afb6473195so54297c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793819803; x=1794424603; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=;
 b=kIL2d4nnnTWV9WGcYEVYc2Q46MG37HhkKqALUqUMmFIKot43ExjQT/lLEXWiEawQCV
 d5odPCM23A/uknXPf9ChVXFJAsSLYa19gr0Co4YbaWpAarH1RyFUbpOxHeW1lQzQ9jWM
 XpzBHckBplaA0GkHYW4k7c8nAkgRg8P3JxzOZJIgAp1daS3sgRhFqWMUmuZNZRd8VDUZ
 8Ygwn0UcXzJZ2y9TNRpdVZG04wp5lfMvWq0KELtK7kvYXEpl1F7xf3srqfC1miAzveeW
 VHQgLJsvuTXrX4eKF4qDpCy0MWXh77b5VK83v3x9fseMqbuveTN0nPkunQFDY3yWs5Pe
 Vstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793819803; x=1794424603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eSNiR/u+jF1juXBbpc/UT4G6ygT/mwfkEaeSc9JG4Bo=;
 b=tBXnVtEB/uv3NsWfZSyHXphMmSakN+5D0Cxw2xIw01CN280slpFUQlV4fdBttwy4Aq
 zsbD5hAESn5+ebHOKRg1XqcI9FEfy1VI2tLYOpRdRZh11rgAytjHwMA/qahPr9sbEcMl
 MVhohQoKQNCDWQUb6B9T21qw6QGOXJxdacTUGx/x90ZEcXTxCT8rh48TUpuSSrp99BDX
 gKOecFZ4zsd+/5+eML5m1SDpUQO1F+N46iqTGrvwOLmG6yFrNOkbxDliays0tn9ROMlq
 I8R/v7880RyRthW7Wdn7C80jlx0zNwOp7mYuTs3XpALcAfResrCR2fPEyk49LK28a3AE
 8rCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWAgHYgh+FmrEcRpFBgv4L8tuyWS25Xv9zvxxD49YOWy/7RJhaoIpb3oP3CcIuZzi/1n0MelghLBcdP3lROHpU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9UBVO3rlw36z8xsJY+sKOm2vXnA4oEHmlZCBbzFyEMNE4P9NFY
 JUCioqkQJ/YOlmL7EIWDjM0u5jKMDIwva/v8yQp0ApWXZoCDCf1LiX1n
X-Gm-Gg: AYBFou0CXwHp1s387eeaW8ulg5gSDOEJhwEtHJO7AF4NzYo47Q4/WKjyxRQhf8Y++Xf
 TvnfoZDJol4LSbiHhekts1elO3lh3fm502yofGugxSMNfVqCdmaIQSRO9tXuxUWmUFQ+KKpLvk3
 mS/uFQQpt1sYVvwkSeymIM2eu1CBXviITHit+QTTGETtlW0oObcJx7GQG0WMwpEuQgdhF72xeG4
 UawYasT/mBN0yj5bYu97cah8EF1C3LI8CzZ9maOBJh5b2UE+P14iDc7jtTJfjgJxjjEk+kTn5Bo
 L1QiNWPB70nwEmhyKzlrRM7BUOcd4QTTpvXdC48TJ8Z5XZKrMIMNZRO7LH1u3govR4AH1Xr/faq
 /D4ocpQ14qlvdoXiIii6LIrIcwN0LqfMB2iXkH6Cit0J+dnCeiP3p+kwmjZpwF41jJp1djKHtEp
 mQXvs3yFHzpHvHVF1seijWEoznzCUGApqtpoHoU9+3CA5CdPX6bzETlYmD2tNYOWK5C6E8Ye176
 t+xofHPhEdU8GH2WTCw+e3jBhYjbBSBqe7uwg8qGmBykEMvbAkaX4W0c08p8FiuTIq4IgMlNbOQ
 azW+XWAS9HO8b5nGVr2uf9aUEKJR5akWyao6sjBuocRsLtohvzyB5Xuv0hlimT0iJj8/Ly3hjI3
 Yl5934LI26EHJfATV/2SgyiIldW2ocpN5DpUoww==
X-Received: by 2002:a05:7022:1707:b0:189:d6bf:7eaa with SMTP id
 a92af1059eb24-1ac5c3699f6mr22489147c88.16.1793819802794; 
 Wed, 04 Nov 2026 11:16:42 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c2c2f7sm10017000c88.9.2026.11.04.11.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:16:42 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed,  4 Nov 2026 19:16:21 +0000
Message-ID: <20261104191621.89561-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xOgTY-000000005ql-3SVa
Subject: [f2fs-dev] [PATCH] f2fs: read atomic replacements through the COW
 inode
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Hungyu Lin <dennylin0707@gmail.com>,
 daehojeong@google.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Starting an atomic replacement drops the page cache and resets i_size,
but keeps the original block mappings so the operation can be aborted.
After a sparse write extends the replacement, buffered reads still use
those original mappings for the skipped range and cache the old data.
Commit removes the old gap mappings, but the cached data remains visible
even after reopening the file. A subsequent partial write to the gap can
write those stale bytes back to disk.

Resolve buffered reads through the COW inode during atomic replacement,
so unwritten ranges are read as holes. Keep using the original inode for
the read bio and its encryption context. Once FI_ATOMIC_COMMITTED is set,
use the newly committed original mappings again.

Hold the mapping invalidate lock while committing or aborting the atomic
write to serialize these mapping transitions with buffered-read faults
and readahead.

Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/data.c    | 8 +++++++-
 fs/f2fs/segment.c | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 28fd8afff5d..89c4de3640d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2489,7 +2489,13 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 	map->m_lblk = block_in_file;
 	map->m_len = last_block - block_in_file;
 
-	ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
+	/* Original blocks are kept for rollback, not for replacement reads. */
+	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE) &&
+	    !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
+		ret = f2fs_map_blocks(F2FS_I(inode)->cow_inode, map,
+				      F2FS_GET_BLOCK_DEFAULT);
+	else
+		ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
 	if (ret)
 		goto out;
 got_it:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 43f40071576..f45b5ad78fc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,6 +193,8 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	if (!f2fs_is_atomic_file(inode))
 		return;
 
+	filemap_invalidate_lock(inode->i_mapping);
+
 	if (clean)
 		truncate_inode_pages(inode->i_mapping, 0);
 
@@ -218,6 +220,8 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	/* avoid stale dirty inode during eviction */
 	sync_inode_metadata(inode, 0);
 }
@@ -409,11 +413,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 		return err;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
 	f2fs_lock_op(sbi, &lc);
 
 	err = __f2fs_commit_atomic_write(inode);
 
 	f2fs_unlock_op(sbi, &lc);
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
