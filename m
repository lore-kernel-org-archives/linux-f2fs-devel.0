Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67872606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QT+qw7BD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RBwmPrNW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NzW8DySM;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dV7E1/xo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=sj8RLJracueyDpRcuFXdvQsnf0XZ8UZaakAqMLr/zFY=; b=QT+qw7BD8HcYgK3d8jQ7VppD/Z
	vHN1D85kGL58Gn77x0KqwtvgqLMS6wt0F3imGbumHRmq2nY2pf886YPlVpPjpbNZxVn+Iww5PVWcA
	cnJuZcCzwQBlcu/zJQN50U+4oQc7eruqk/DwBX2vOddcQEDbjAyeCZAv/4HuPvwHhsNs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWtdM-000000002rt-0bhJ;
	Fri, 27 Nov 2026 10:56:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xWtdL-000000002rf-0kKz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixpJ8FVsaUtzbYGvKZMv3iePyio0tQ1UpoRhwVro58s=; b=RBwmPrNWYJ6qjez5u+RRL6ebbn
 stIvDsByNUI+ANW6U/s3PqcZ6nxh0h8jfmcJNgj2eHEivY1AjOGe9lS8zlPbW3r8zV5LsdRLjC9iP
 2f9COvmwFnP8eX7CGFfYvlrc67gnsgrW3JV2vKUAH/5eItbiHLiVFh+nL4ls206pBJNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixpJ8FVsaUtzbYGvKZMv3iePyio0tQ1UpoRhwVro58s=; b=NzW8DySM7weUDpNwBSMy33cUaV
 shVUebqoawZIbim7dP6o1KmxurNnhcbb8formopjheqCCRr7+0SYTQeLWUXwn6rjgckI6gf6s8kTr
 HjnQniq703fH48OnvOdyN+nzt9oLr4HJCSOWKj0ITufc7XCDkGtceHY/zxsPhsfdWTDw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWtdJ-000000001Cm-37Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D3326271D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 10:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6BB1F00898;
 Fri, 27 Nov 2026 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795777003;
 bh=ixpJ8FVsaUtzbYGvKZMv3iePyio0tQ1UpoRhwVro58s=;
 h=From:To:Cc:Subject:Date;
 b=dV7E1/xohDKd6dZZp3jQtSYpClT4BgLczWrsqp2uTk90zW4T9rl7RjRRbdBWS3dbb
 foptU5l3/U2XrmTRXAM2VWlN8LLDFQGfBkRxzlZ1RthW2PGE8oWXXhtQaFJ8LeSBuq
 wiq89m6iKeoql26dWs8Kz+CxfWTCCGHMMf9tHfbsFp4/zhaVVTxAufKEE2x8po9MyJ
 AxhYnLOsZFDVFHCpnkLdMm+kg39NWhUGtA1/lsuZ4YFhvjSjHtcHEs+1nKQ2ptpRbN
 x6Y+uBqBpt/ux2Vvj9tGAWBhVT9xPG0wQBuj1PfCotveI2I/FY39Gt5cvYrCKSMzFL
 QzZlE60psmvAw==
To: jaegeuk@kernel.org
Date: Fri, 27 Nov 2026 10:56:41 +0000
Message-ID: <20261127105640.537608-4-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWtdJ-000000001Cm-37Mg
Subject: [f2fs-dev] [PATCH v2 1/3] f2fs: fix to account entry_cnt for all
 write bios
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

Commit f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
tracks the number of entries queued to a write bio via entry_cnt, so
that f2fs_write_end_io() can offload the completion of a write bio with
too many entries to sbi->wq if it is called in atomic context.

However, entry_cnt is only increased in f2fs_submit_page_write() and
f2fs_submit_cache_write(), it misses below write paths:
- f2fs_submit_page_bio(): single folio write bio.
- add_bio_entry(): the first folio of an IPU write bio.
- add_ipu_page(): folios merged into an IPU write bio.

So entry_cnt of these bios is less than the actual number of folios,
and a merged IPU write bio, which may contain up to BIO_MAX_VECS folios,
will never be offloaded to sbi->wq, then it may be completed in atomic
context with high latency. Let's fix to account entry_cnt in all above
paths.

Cc: stable@vger.kernel.org
Fixes: f32744a8b83d ("f2fs: introduce max_atc_write_bio_entry_cnt")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch, which supports subpage block,
  no logic change.

 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..6be0cadc511e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -959,6 +959,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio_lblk, fio, GFP_NOIO);
 	bio_add_folio_nofail(bio, data_folio, bio_len, bio_offset);
 
+	if (!is_read_io(fio->op))
+		F2FS_BIO(bio)->entry_cnt++;
+
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, bio_len);
 
@@ -1030,6 +1033,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	bio_get(bio);
 
 	bio_add_folio_nofail(bio, folio, len, offset);
+	F2FS_BIO(bio)->entry_cnt++;
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
@@ -1077,6 +1081,7 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_lblk, fio) &&
 			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
+				F2FS_BIO(*bio)->entry_cnt++;
 				ret = 0;
 				break;
 			}

base-commit: 9ad6c58bfbe5882b1aa0cbe2393dbfca89d2c199
prerequisite-patch-id: 23bb28339e4f35a111279d46493ac1e04fc66d58
prerequisite-patch-id: aaf2ca8ae4a7422c58daa02714ad9a5b4578bccc
prerequisite-patch-id: 207a76a8bede95d1b0ec30dc2323963da5f6ff3f
prerequisite-patch-id: baa9eb03ece0f1f0155a2226b99946327ceb3e33
prerequisite-patch-id: 1eca125a4d02fba284eaad33e37de978ec89a7d0
prerequisite-patch-id: b4566514d95142b9291270f2b64205f69c9b6edc
prerequisite-patch-id: b8f7552919f622aedea1b119674eec9cc93d8671
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
