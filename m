Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D0606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O2CgLU1g;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eA1QI/im;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hfgEdfzn;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWieDEds
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=lqU3wANoPdwzZzN0KtME+u6G0gb1lUKwCPm4XWw+0IQ=; b=O2CgLU1g+ArTBgvh/1YG6Mr+b6
	YPjrtigFrkKszCRNJLMg6YDYxJTOpAS/1m6GA4gXzP16yQEbYTQyvOWJiwXboQDdC8aY820bbxGCH
	b9OYg+oAyrZqzTq1KPnVM4rFqydVMNPea1smkwX/F8CDV2IDdNjqiYMW3wyE4Y8SbG0A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUMNz-0000000023I-0xak;
	Fri, 20 Nov 2026 11:02:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xUMNy-0000000023A-0ea8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 11:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkbG5LB1NV/xKpH/oha2h+NsDn7aeLKmyfn1a4faE08=; b=eA1QI/imHKc2jlHIAYJ1bZThLs
 WkVaTyWct4UeYUdqZzmyyYXOLa1O1H/I9JqJIhtKWsNNfyJlqLdN8Gsn9Six2YO2ml/MlgOQxiXn8
 3RipousJlUWCcRStqNSegBmEfheSsp7ScWSQl2jTukDjcYTpGfrtAJxjhcnY6+D9QG8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkbG5LB1NV/xKpH/oha2h+NsDn7aeLKmyfn1a4faE08=; b=hfgEdfznx1hHOnCC4yZGCWquEB
 0jhATcZ6nNTVt0zcel3HRq4FF6yFfWjqwm0CFmtfgZ5jDFyg9LnBxlWBi6cX2ok06azEHaOocTl7y
 YxS7+UsrLrhQMzXOY8go/g126mdbz+pxKmw4cdGr0aJx98w/HjSv8czfrNzQQQlsQQeY=;
Received: from mail-dy2-f9.google.com ([74.125.229.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMNv-000000004fH-1XLF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 11:02:30 +0000
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-3678f64d078so752848eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795172542; x=1795777342; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NkbG5LB1NV/xKpH/oha2h+NsDn7aeLKmyfn1a4faE08=;
 b=VWieDEdsDQ/E7DUOlrvp2jOvS0vKF8Gv+5G5Rc+v8SnyZSHhpX38mpuOuE2dEc2K9c
 POLdqQqQGUF02GKx3A3Xvz8PKiP6htJZmKJQaN5etXdbK1w8PLkgx+YD2H5uRT+56c9T
 a3nlgph0HE8wCEzCvmAN8igNXWcIEbVTCVkaDqPRaWmSadiu1uoDgOxBbdkIJwADuFKj
 BCgx/0O3kBoyFEVy5JrQ+YV3m4BfrEcj9ODfAcBL3biDSg8LSpDGT+hpPURgDlPkVymI
 P8PanzF/PAF2RpvRW6qkG9xQ7+4Lb6lKYx7SoqImSyu7wW58lFW9UqbmqUZNBlaf0deZ
 qKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172542; x=1795777342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NkbG5LB1NV/xKpH/oha2h+NsDn7aeLKmyfn1a4faE08=;
 b=WU+68pinsUGsqFlqIw8LUsEV8PEec6xzR4hTzn4BFXfzIEZzAY9I0Ur9LAG1VLF7Z8
 qLeCFDAUuLE7j9wv9bv9XyGrqYqgz3SzErogFYCX49seRRSMx6aAAcw9qxDZ3pFTUZqf
 I0tiOTytNiP2UVXAMztsXttB57musdEAnym9t1mq1sLIzSg9/20lGLGv7g4J5/FO6RV2
 p5NnB5FpcS/Z3nm4L/VIQSmJ3LEvFcKwa+ZD6RQ0oDR8TvDjrbINh4PhfDOo5nRWTgWy
 FUcQMQv6g9RxCF8167DDEzeheCLDOKKqbaIlZq8jbl6cvaa6NbWigQDJT8IJMb3osGIG
 bz4A==
X-Forwarded-Encrypted: i=1;
 AL+hErHqnrpkVrnd4xzhOdCXSlFH9F+Lt7HXQHNP7fWDuXQyWIJUvGBE+vdO+Fzk/kYC/MONSLPX1MmMXn/5p+J9d8G9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+V9kuH3lHtWpdmKFmYZRTH35ozQ2N0OlgglfE1PP9QQGsmQ/0f
 oxb0dNdhKrFsT3J0pmeNEGv0t0G5IAXZi4tMnwwTGUArGY+73zWd3Shs
X-Gm-Gg: AZFdTZdyVS8t/ylHSXZGhrCuAcga73TlgzoufMdhhhX9Xe90+sV45RMN0roqLmLD6iz
 v4nYFfe7ePY5YtpTB6QIDD3BWbw4h2vEw+alctxRwVOGuY43di2wbFDe450sB3CgmOJQCJxyy7Q
 udMlpPVpuK/FI/LZbOaA9s2OovOvjwB+LGAiMnpoHsD+6RxM1fbMKUTAHacdC/I5KR3uzCiXt2L
 M5nO5BRYiT5T1l57Rq89nNOYgntRk34M90o7EVXx0lWKSIwUmRL+4LOCSuGMf+PlXGxU71eCWis
 NWKKCoZMWnyXdwLTvb/lb4WlgAry6GEsPSixv70xuyPx1GvoNB9giK8Cs1cUUs2C+WYaVHXmW+Y
 WBVdXbXzAeXAavfQ3I3lM0ZhR/VXQKHUuCjCB+Od7O5k1y+uqtq1Hk2NzVc80yUg5/iQeo6pJI3
 LIRTuIMXohaMAxHqRJ/wtX7X9nlQ+AOtDCO+MD+Et4GX5qukw5MOUiCm/TlGpWRvRn1pUgLbNUU
 ey92j7jkP7TNP8+Mp2hhHFHwvMxAe8ftjfgUqG5qQ7ceUw3gGD6iV17pC28Z6hyXtZSzRm4TGL0
 ykddXJDEj0iQrNjGUfxc5DWokdjSQF/csd6pLf4DMItz7YVYrcdgnBAlaqRSRFHj/fDZSW79EaG
 4ES6vFcik9sd6j+AyW+Qsbjz4Kh6rbnjxQ/pk58NGgYFfo4Rmut/ElfQPb+o=
X-Received: by 2002:a05:7300:f483:b0:384:e31e:3c58 with SMTP id
 5a478bee46e88-385714160f6mr2276276eec.33.1795172541457; 
 Fri, 20 Nov 2026 03:02:21 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38577214c2dsm6561530eec.17.2026.11.20.03.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:02:21 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 20 Nov 2026 11:02:13 +0000
Message-ID: <20261120110213.68391-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xUMNv-000000004fH-1XLF
Subject: [f2fs-dev] [PATCH v2] f2fs: read atomic replacements through the
 COW inode
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, dennylin0707@gmail.com, daehojeong@google.com,
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
in both f2fs_read_single_page() and f2fs_read_data_large_folio(), so
unwritten ranges are read as holes. Keep using the original inode for
the read bio and its encryption context. Once FI_ATOMIC_COMMITTED is set,
use the newly committed original mappings again.

f2fs_commit_atomic_write() sets FI_ATOMIC_COMMITTED before it removes
the old gap mappings. Hold the mapping invalidate lock while committing,
as f2fs_abort_atomic_write_locked() does, so that buffered reads cannot
map those blocks in between.

Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Cc: stable@kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
v1 -> v2:
- Rebase onto the f2fs dev branch.
- Also map through the COW inode in f2fs_read_data_large_folio().
- Drop the invalidate lock from f2fs_abort_atomic_write(); the callers
  take it since "f2fs: support subpage blocks in atomic writes".

v1: https://lore.kernel.org/linux-f2fs-devel/20261104191621.89561-1-dennylin0707@gmail.com/

 fs/f2fs/data.c    | 14 ++++++++++++--
 fs/f2fs/segment.c |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..b006f92b3c70 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2650,6 +2650,14 @@ static inline blk_opf_t f2fs_ra_op_flags(struct readahead_control *rac)
 	return rac ? REQ_RAHEAD : 0;
 }
 
+static struct inode *f2fs_read_map_inode(struct inode *inode)
+{
+	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE) &&
+	    !is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
+		return F2FS_I(inode)->cow_inode;
+	return inode;
+}
+
 static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 				 struct folio *folio, unsigned int nr_pages,
 				 struct f2fs_map_blocks *map,
@@ -2695,7 +2703,8 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 	map->m_lblk = block_in_file;
 	map->m_len = last_block - block_in_file;
 
-	ret = f2fs_map_blocks(inode, map, F2FS_GET_BLOCK_DEFAULT);
+	ret = f2fs_map_blocks(f2fs_read_map_inode(inode), map,
+			      F2FS_GET_BLOCK_DEFAULT);
 	if (ret)
 		goto out;
 got_it:
@@ -3490,7 +3499,8 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		map.m_lblk = index;
 		map.m_len = max_nr_blocks;
 
-		ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
+		ret = f2fs_map_blocks(f2fs_read_map_inode(inode), &map,
+				      F2FS_GET_BLOCK_DEFAULT);
 		if (ret)
 			goto err_out;
 got_it:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 066b7cf813d7..b3554b27751c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -417,11 +417,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 		return err;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
 	f2fs_lock_op(sbi, &lc);
 
 	err = __f2fs_commit_atomic_write(inode);
 
 	f2fs_unlock_op(sbi, &lc);
+	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;

base-commit: b61a029304bb5531312ebc133b2a895d14dc3fee
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
