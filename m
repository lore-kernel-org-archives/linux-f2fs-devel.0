Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0A606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NkETpRje;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Cb9xX50/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k+bwuHkv;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA9WjkND
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SCeBjapyHwGIRCXAqQi4EvQnNbLjafwrC7pD8TOlgsE=; b=NkETpRjeP/emsVH3jZAfnvgW/O
	pBzhryIiCvde3xwJYyyz03ikxOsFbhPhRRFYxzRrc2R/jTDZetMLKMognCI8H1uxncFkxy1zvr/NH
	BNYS42KA1w3vmnknzRtlej1FQ/uVYNq1pNQ8DAasG7vghf0XkzhS8puQMgRVgrgI7TgE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsI7-000000006M7-40E5;
	Thu, 22 Oct 2026 12:53:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsI6-000000006M1-31eD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yltvb7S7CsW0Y3hHn9MIuF57ZhMRPNep49yh/7UlWzw=; b=Cb9xX50/eVX+Bs5B/3yr88MzO3
 9pfqyyxTcfjFr9XsskPDwvH906k9Qu3knaVT+FC9KTGbQWQeYB72szkH4dMVwCjfp3uves9SMwv5+
 cmCA1nz7QWCez3CylqJJgIvSt+ru+kfplxvVW5J9v/rtdgOe9oGgLYJjmaBXC19A288E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yltvb7S7CsW0Y3hHn9MIuF57ZhMRPNep49yh/7UlWzw=; b=k+bwuHkv/pQo9rfHklLdiBc1ZI
 5/MEyl1P7m+4a11r42iNpuLV+cyxrsDQUPpzSdP221LnW8N+49YifsicQwRojEGADo+1MvAT1tCWS
 sy7okyEBLC6bjr+v4Gk6Ri4dai4xcjEHXaBM15aN3HANdZttW7csn2OXCmt6WKFqvaYw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsI5-000000006rG-2uPy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 521F1447F5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418401F000C2;
 Thu, 22 Oct 2026 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673580;
 bh=yltvb7S7CsW0Y3hHn9MIuF57ZhMRPNep49yh/7UlWzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BA9WjkNDjc7dr1GBsCzr0Gyg0ty5odDY/l9jcL2DgkIZlsaGQYVNWF1dd/yTK2RIX
 pvoC12SSVkgDpCZiTCRzaNRTb9MGxHgaiv0BzHeXZy+9muJBFZdlGfHx6j4Y3W35/E
 DBWSAFfRzudpzklRbndJVSpvg5nV846Lm+38XZvnfAK0nHMOoD2sW64raNumgeU6Ul
 z4pu1zrvuITUzHVUsVHWQ5d0jIHEYAf29H/d/AIGP1/rgQzulyM4HvMW5RZhQZCpeI
 50coxM8gtNdv52SGuq2miVk9BXgGAWE1bwDgSPVZWtmnRf6rP9SqYbYF2KwIvKs6X6
 GTY+3ufqpNdig==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:40 +0000
Message-ID: <20261022125244.2205275-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125244.2205275-1-chao@kernel.org>
References: <20261022125244.2205275-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsI5-000000006rG-2uPy
Subject: [f2fs-dev] [PATCH 3/7] f2fs: fix to return -EIO from
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

Note that commit e41de21d78ec ("f2fs: fix to return -EIO from
f2fs_sync_fs() if cp_error is set") only covers the case cp_error is set
before f2fs_sync_fs() is called, not the case it is set while the request
is pending.

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

Cc: stable@kernel.org
Fixes: c34f42e2cb2d ("f2fs: report error of do_checkpoint")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5c5b45d3c67b..819073671f3d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1945,14 +1945,19 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
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
