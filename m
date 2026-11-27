Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0754606A32E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JDWJIk3D;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S/WlHUqM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aBqBSRr3;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJXmwguW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VTrIHiUB66jGb8q6WvkZTYN/EN9aCj4p9x2V/L1GPPQ=; b=JDWJIk3Dei2BbZbpBYTVqzwuTC
	+yos93/5yAQRHyJYQETqXd6mz5jhuhjayfvL1sOkgt30Nw/j4PQaZi1RD7/355rZSkvqOO0L6teZq
	yh0xrozTwXMHMkcR85mZPtm7LySWHAyyOODf2Zj7A1ESwLjUYgJiQau32mP1Tzx1fH1Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWtd0-0000000080F-1aJb;
	Fri, 27 Nov 2026 10:56:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xWtcy-000000007zy-1rCr
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Csl98uTqktOParQt31V+Vk9bWjMzRE/Hizj4IlxonY=; b=S/WlHUqM/AyUD5mU39gdVEI+8i
 7UNJUX+ObsgHPTVmSa7sS4EduG90E+s7mfZ0HecYgJoBz91lU0rsfElLt/EN+YXejL5Od/6pgt2Rj
 X8Yk4BeCUAY0Y8oNEYNtU4AN5uMq6oPbBgSNBgztPRlOA5UbouM9rb1TOLhz/p/eD/gs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Csl98uTqktOParQt31V+Vk9bWjMzRE/Hizj4IlxonY=; b=aBqBSRr3k+S2+xO7OlCcE7X9lQ
 5JFh2N9twmS5WjUTefei48LIxkchJ2f49KCKKtnV2QO1mwXDS6ddbVIJwgBb6XFcb3c0AjgfyB7L4
 dMO0R86wUVJtuRtrGcqkmDzL/BDOkcnMTYliQQWMHCXHE8y0PV4TvOFN+WnIbMXeDaxk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWtcu-000000006AG-0eXA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96BBE62796
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 10:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DB11F0089F;
 Fri, 27 Nov 2026 10:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795776978;
 bh=1Csl98uTqktOParQt31V+Vk9bWjMzRE/Hizj4IlxonY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lJXmwguWiFNMdKuBrR3+HdSlFRwkKGQvl5Rat++CYNR/qYAj5W29G88XdUu2tuaTy
 1iotMw86/uYtwMEX1Bvdv7x2tYr2W7HkwGRmRl4OUlAtm2bsBwL/SacFB3us6igum4
 D6OwROAH/7BGtGSZDfB02FKo1vj4qTqxyQjIM0PJXec0JM16cRvmvve5tiMKx2aukZ
 uso4uUTiITNLFJCuIaPl4IxxZ6NbYYwEUDG17Yt2sV3LWgr4wmeQk8i4Wu5Wnmy9/B
 Cwcx73ww9J/FniuB2BS1UU2xqYEg9/dwJOlTeSh5zV/qrbAOsE58/VTw+QOa0ItMx3
 ZsXMWAjbd7xXw==
To: jaegeuk@kernel.org
Date: Fri, 27 Nov 2026 10:56:10 +0000
Message-ID: <20261127105608.537148-10-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWtcu-000000006AG-0eXA
Subject: [f2fs-dev] [PATCH v2 3/7] f2fs: fix to return -EIO from
 f2fs_write_checkpoint() once cp_error is set
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

f2fs_write_checkpoint() skips a CP_SYNC/CP_FASTBOOT/CP_DISCARD request
w/ err = 0 if the superblock is not dirty, and this check is done before
the f2fs_cp_error() check.

However, do_checkpoint() clears SBI_IS_DIRTY unconditionally, even when
the checkpoint fails due to cp_error (e.g. shutdown), and only returns
-EIO at the end. So a checkpoint request which was queued before cp_error
was set, and waits on cp_global_sem or in the checkpoint merge queue, will
see a clean superblock once the previous checkpoint failed, and returns 0
w/o doing checkpoint.

For a file which relies on checkpoint to persist its fsynced data, e.g. a
compressed file (CP_COMPRESSED), f2fs_do_sync_file() -> f2fs_sync_fs()
then returns 0, and fsync() reports false success, whereas its data was
neither covered by a checkpoint nor by fsync node blocks: after recovery,
the fsynced data is rolled back to an old version.

Note that the previous patch "f2fs: fix to return -EIO from f2fs_sync_fs()
if cp_error is set" only covers the case cp_error is set before
f2fs_sync_fs() is called, not the case it is set while the request is
pending.

This was reproduced by the f2fs consistency test (verify_consistency.sh
--init zoned -S 64 --mode consistency, w/ compress_algorithm=lz4 and
default checkpoint_merge, under fault injection): fsync_verify.py randomly
overwrites 4K blocks w/ a generation number and fsyncs them, the test
injects "f2fs_io shutdown 2" in the middle, then verifies the fsynced
generation after fsck and remount:

  FAIL: file 2 block 510: rolled back: gen 17 < durable gen 18
  FAIL: file 2 block 561: rolled back: gen 22 < durable gen 23
  FAIL: file 2 block 955: rolled back: gen 12 < durable gen 13
  FAIL: file 2 block 3986: rolled back: gen 23 < durable gen 24

w/ debug logs (trace_printk) added in f2fs, the ftrace log of the
failing compressed file (ino 438) shows:

  python3-346519  2267.558508: FSV SYNC-BEGIN f=2 fdatasync n=4
  python3-346519  2267.558519: ino=438 FSYNC enter datasync=1 dirty=4 cpver=14c8edcb
  f2fs_ckpt       2267.559876: CP end reason=4 err=0 cpver=14c8edcb
  python3-346519  2267.570549: ino=438 DOWRITE OPU idx=510 old=a21bc1 new=ae4af3 hdr[f=2 b=510 g=18]
  python3-346519  2267.571478: ino=438 WCACHE exit ret=0 nwritten=4 dirty_left=0
  bash            2267.571810: iteration 4: injecting shutdown 2
  f2fs_ckpt       2267.573403: CP start reason=4 cpver=14c8edcb dirty=1
  python3-346519  2267.579576: ino=438 FSYNC wait_range ret=0 dirty_left=0 append=1
  f2fs_ckpt       2267.589393: CP end reason=4 err=-5 cpver=14c8edcc cp_error=1
  f2fs_ckpt       2267.589413: CP start reason=4 cpver=14c8edcc dirty=0
  f2fs_ckpt       2267.589414: CP SKIPPED (sb not dirty) reason=4
  f2fs_ckpt       2267.589415: CP end reason=4 err=0 cpver=14c8edcc cp_error=1
  python3-346516  2267.589431: SYNC_FS sync=1 err=-5
  python3-346519  2267.589503: SYNC_FS sync=1 err=0          <--- false success
  python3-346519  2267.589507: ino=438 FSYNC cp_reason=2 sync_fs ret=0
  python3-346519  2267.589510: ino=438 FSYNC exit ret=0
  python3-346519  2267.589567: FSV SYNC-OK f=2 D=510:18,561:23,955:13,3986:24
  [shutdown -> umount -> fsck -> remount, recovery from cpver 14c8edcb]
  kworker         2370.028185: ino=438 READ-END idx=510 hdr[f=2 b=510 g=17]

- the checkpoint which should cover the data written at 2267.570549
failed w/ -EIO due to shutdown, and cleared SBI_IS_DIRTY.
- the next merged checkpoint request was skipped as the superblock looked
clean, and returned 0, so fdatasync() of ino 438 returned 0.
- after recovery from the last valid checkpoint (14c8edcb), block 510
has gen 17 instead of the fsynced gen 18.

Let's check cp_error before the "superblock is not dirty" check in
f2fs_write_checkpoint(), so that a pending checkpoint request returns
-EIO once cp_error is set.

Cc: stable@vger.kernel.org
Fixes: c34f42e2cb2d ("f2fs: report error of do_checkpoint")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- commit message: refer to the previous patch rather than a commit id
  which is not in upstream.
- rebase to the latest dev-test branch.

 fs/f2fs/checkpoint.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c059022413be..a8c98a2acc53 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1975,14 +1975,19 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	stat_cp_time(cpc, CP_TIME_LOCK);
 
-	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
-		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
-		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
-		goto out;
+	/*
+	 * Check cp_error first: a failed checkpoint has cleared SBI_IS_DIRTY
+	 * in do_checkpoint(), so a following request would be skipped below
+	 * and report false success.
+	 */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
 		goto out;
 	}
+	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
+		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
+		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
+		goto out;
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, CP_PHASE_START_BLOCK_OPS);
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
