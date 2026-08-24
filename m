Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4852FC5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 02:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iQrQ4gr64ILYGuTC113GBUVeNEH4WqHhdMK/NABY4zc=; b=c1GCmTJ7212BRhuTqThkOpbuNU
	39bP38VgdROFzCO5Jf+zVYIM8aIIK2z+QR1TKhuxvOvtGZ2XPXf9dTmkYfKN2eL7laJjG1ESrCgaN
	TnN66H0pVVc+WaVfNt/sjajGnmiPRUgvb/LwiMdAvlIK2Mi+RPw2yfkdwJq6xQ+g1u6U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyKVR-0006JX-Fj;
	Mon, 24 Aug 2026 02:33:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1wyKUv-0006J8-1a
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 02:33:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2W3X3/X9OGpB4hHUUielWb4210XDqU18448NB33jQxk=; b=N7A6tXgRSJ4SOPv12HvX+fLiPq
 M8y6lXr7/lpjXE08LIKccMQpstTDER5HWnD0m0Ucwa1/IxxiKYOKD3WfHe/w/utDGekRBmjNL09Cw
 VvBZ4SX2FVjbcOVdKkzCc6zUv7QkNRQGKjhPr0Yx1h933FrjJnftxL3pngaS4fn5rx9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2W3X3/X9OGpB4hHUUielWb4210XDqU18448NB33jQxk=; b=G
 dBf1T2RJi/K9UcocCdCxpH+ZxFZJ82xiiM0E/CTECZDG0D+q8oF0VPvjjdi1uDGvsJLz3Vsrk7NZD
 OM3wtMBvcVwESA+72DnUlZZNMyoRtror/jdbktsk2ozYGBovjOJ76du61SXqpWCZAvzYA3Xq9r6xY
 3M8mjovzdntvgJkE=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyKUs-0004h5-4d for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 02:33:14 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d5335cf904so22196905ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787538788; x=1788143588; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2W3X3/X9OGpB4hHUUielWb4210XDqU18448NB33jQxk=;
 b=a18tJRHPSB3vqmTGYBn5jIWTe/xUWke9OZL9qf7FTUvf2U06IEbzD3ryMupaGKzWQh
 C0686FK8YJ5fX/9it7O/ImBcgqdeyLp0nFJcAdZKkVuhQfLgvbh2bMAFsk/BmDAszbyL
 koFxTaPpEMR9cUWn0LBbw6xj61Od/glbw/sbNAd0gVmEqVZ64Vqe5Mjc9e8/xsUTp1se
 q1taDm1CMzrRxQHbtd8glA1kB+Qo1tLbRPTEshrDVzwWlmZG6xdOk+FvPRMlvLeil1fC
 m844Lqu3S8mPLs9Su98OBsNsh91yhYGYIRAQsEjZIsAo5u2yuZ6EF0hPAdMXmw1k9tMk
 hSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787538788; x=1788143588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2W3X3/X9OGpB4hHUUielWb4210XDqU18448NB33jQxk=;
 b=GwD+0b5/+1QFa7GsQ219My7/rM4AELsk/sP5jjCgAeFnLXjOMv8eSp7S17osJZsRD4
 N85xXzyjRR0edu3Yv8Nvzv6ExEwTADXy3XwZUlsv+6fO/Gkicn/V3a7zyQaQIK86L3QN
 bRErglngxVWxlYzxKxuh+IqTQd8iyIHOFHqVHisOXFeNmlsAn3V3h+P0+QiY1Kl1plKc
 2Kw8LwqttsGu3lq9MMS9/yqtOFBg0T/NjFKDV9rkyviSHcK0FBHitMEYKYSgQwKxwWyI
 9UvFlQOXN0Si1PXaXXbPec1VPlgx26k7UuBDs+4XjuEcQrGIznLOANiTtvQrEzLDGosw
 iJeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIivwkKnTnCnxBCOVUtaPqf++NZ9vLYxajRpnzpPYQmUObhmbW7ARj6vP+C1IQFOL6er/2ifCqDIYEKoQJOGNf@lists.sourceforge.net
X-Gm-Message-State: AFuF++kr44/opU5VRF2EhQkQnbcffHJqkkJFiapKUTbczLd9i2K7LaE4
 6DGWIdsgY4gPDOq61JydMTsS6ygi+UJVGHWrxfpLJyU5LzVJtFTvA9JE
X-Gm-Gg: AR+sD11EANAGJ5g4KApwxkItcwsFODufKuKo0JUL01EyyELiV53FFFM9DyViCQiIhjY
 f3B9THjKXVOGNsqJMYJdeauixHdywb/Lo6llh26XcHpjXFvUFrnOqQmv9rw1EqeBOR+NpgKEEYu
 9im061AusgLjucZSBBobjAVlYqcmdvkEIv8cdoCa3q7G8h32ug1HrNvFWQHlp6z0JZcffV5Rokq
 Q9g2egRKda740xSNNM7m4WdWDY5Wi0/qRIw2SZElzWxPJGerhhW80CQrNmrry52M9h6ZP82IFoJ
 zAYHKCkWQbXBw7m61IqfAHplVxSZ0pcsQ8UYHcTBquvd30l3jrbgzMF+RCCSUYf0F4NTGE7n7VG
 30LmOvMwhXqumSLb9JuG9c1cx8JK1A863h15FkrCNL+dY1jQDl79MhHef5Qx5viPghSCBpP39bc
 aFfD/5oPm52H5JsCI/J1qozyzrzUa9cqKFFwM4adDCDWZ+6C6BB1YXCargiNhXQkk+SBNuwLyJV
 ateVGE+3ra/nzbokQtmbDzXyvx1So5VlGn3VkS0NMRcGrG4YqlFT2NFy68pR2udHrFB/j17BQ==
X-Received: by 2002:a17:902:da89:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2d64ae18c43mr417897145ad.6.1787538788312; 
 Sun, 23 Aug 2026 19:33:08 -0700 (PDT)
Received: from
 codespaces-2362ac.3gx5x4kts4veljes22u4ri2f3b.ix.internal.cloudapp.net
 ([23.97.62.152]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676761c35sm12684135ad.15.2026.08.23.19.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 19:33:07 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 24 Aug 2026 02:32:31 +0000
Message-ID: <20260824023231.24616-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1wyKUs-0004h5-4d
Subject: [f2fs-dev] [PATCH v2] f2fs: use adjusted write range after
 f2fs_write_checks()
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
Cc: Seongjae Jeong <jsjlee1020@gmail.com>, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

generic_write_checks() in f2fs_write_checks() can adjust iocb->ki_pos
for append writes and truncate the iterator to limit the number of bytes
to write.

In f2fs_file_write_iter(), the pinned-file overwrite check currently
uses the position and count saved before f2fs_write_checks(), so it
can check a range different from the actual write range.

The forced buffered I/O cleanup also uses orig_pos saved before
f2fs_write_checks(). For O_APPEND writes, this can make the cleanup
flush and invalidate the wrong page cache range.

Move the pinned-file overwrite check after f2fs_write_checks() and use
the adjusted iocb->ki_pos and iov_iter_count(from). Also save the
adjusted write position and use it for the forced buffered I/O cleanup.

Fixes: 3fdd89b452c2 ("f2fs: prevent writing without fallocate() for pinned files")
Fixes: 92318f20d703 ("f2fs: preserve direct write semantics when buffering is forced")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
V1 -> V2: Move the pinned-file overwrite check after f2fs_write_checks() and
use the adjusted write position and iterator count

 fs/f2fs/file.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d82be8c1502a..d440231b8cb9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5641,9 +5641,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool dio;
 	bool may_need_sync = true;
 	int preallocated;
-	const loff_t pos = iocb->ki_pos;
-	const ssize_t count = iov_iter_count(from);
 	ssize_t ret;
+	loff_t bufio_start_pos;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
 		ret = -EIO;
@@ -5664,15 +5663,17 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock(inode);
 	}
 
+	ret = f2fs_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+
 	if (f2fs_is_pinned_file(inode) &&
-	    !f2fs_overwrite_io(inode, pos, count)) {
+	    !f2fs_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from))) {
 		ret = -EIO;
 		goto out_unlock;
 	}
 
-	ret = f2fs_write_checks(iocb, from);
-	if (ret <= 0)
-		goto out_unlock;
+	bufio_start_pos = iocb->ki_pos;
 
 	/* Determine whether we will do a direct write or a buffered write. */
 	dio = f2fs_should_use_dio(inode, iocb, from);
@@ -5727,8 +5728,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 */
 	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT))
 		f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
-					  orig_pos,
-					  orig_pos + ret - 1);
+					  bufio_start_pos,
+					  bufio_start_pos + ret - 1);
 
 	return ret;
 }

base-commit: dafb84f092a6387748b2df4c8f647d46873bc1a0
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
