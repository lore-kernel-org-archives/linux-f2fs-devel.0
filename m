Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F5BCD4F3C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2026 00:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UGPF++r+DTmnqFi2YCDELKy399i61yhNo93iYvKP+vY=; b=OzLS5JvWVw1a+KLpvQwbDjIdF7
	1gfcrNm43R6LF4JbkSSwUeOnE7d6s9NENdaSqxnKLXOHvCGLwOKBPiwMk9mXpx4hQ2YvYqUfV25yd
	Ylxm14jfWro5fkS0Ntt4V88gVWWA3WvbFzbTCNaxvQSrTwukiG53DiwVyyRstqxgpNv8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOPkM-0007G1-4L;
	Sun, 17 May 2026 00:52:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kartikey406@gmail.com>) id 1wOPkL-0007Fp-4R
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 00:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Af16G8zYt4/YY8vU9QwSZfvcmcjmWzXY8R6f0FYmWII=; b=Ojdv/zKqUcCb2xujeL1dNIUe7V
 9ZvK8L6n3582p7dS0wL3od04/0CvdoBXBI+dgx6wbDG4XEqRxtFsZcxaEAkvyvgfr1uQ4fu6bBvgz
 km+bNG/rHxMHk/srBnu8NrAnSNSwdvc8Hf55nxdOsPwikVlKpNpjkM2zQiq23mCjtgvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Af16G8zYt4/YY8vU9QwSZfvcmcjmWzXY8R6f0FYmWII=; b=J
 RnFbENzbkkJe8/i/JbDqNpKF7DMyAgqCGDSYNvrM/EgTMMKYWNyf1ERSOcxZJtbO/5JTra3JHYDYJ
 WZZvNF9chL0lQq4BTqHuIgfrhQ5gsBQaHXy3xyDPFiz8GNrNXEN5E2Q+xVS8ojZU7Y+4wEqbBGbDF
 h9eriebgB1yfXwbM=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wOPkK-0008L5-QG for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 00:52:45 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c8021c8c42fso345126a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 16 May 2026 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778979159; x=1779583959; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Af16G8zYt4/YY8vU9QwSZfvcmcjmWzXY8R6f0FYmWII=;
 b=c6cMewpDUZNGVdJ7ls/d0at03wmvWO/+1Suu9g0TZCb0y6v+iF3KU5ZWbZcGOqmvPG
 aRYhQ1E1NQJD3Cl3gbSIv81z0tzDu5L1l26Vm+rWR08U6iOzW+jh+eMNAcYylsg3z2va
 At7GW+cqERRjNJYmPjBS49VkkHTkm29bZIBFjN+dDP3hddlEZGVvHbssZ9FgahM5T1eR
 HqGEWEWPNwROfWbGAXTdWDsGUlSkVqGnWbop8eKkImI486Pp/7Eqr8x8sU/B7XbKNGoj
 lTVCT4cxIj5sBEqt+kfl3tVcWBNAJUXox2h5JDE+b3NbyOiQbHKpPL7hbq/SFJm98Iv6
 oRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778979159; x=1779583959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Af16G8zYt4/YY8vU9QwSZfvcmcjmWzXY8R6f0FYmWII=;
 b=Ap2/B+CCiG/wELfXWU0bL9sw8ICp9MG2AUrFtUIUKoVB9NEkazwgV4mwBtfKffxUfY
 38qXN3e70WiGLJWF0OsU9x3iJBtOL7eVbNc17b/O07wdsWLn2qp2JdkN9TNkvdnQWsvH
 htsJK/gRv+31NQ0eoi9D2C2mA1U/1pNupw3yyQgE/YIQe2IUo5a9zWMmd8n9fdGUGubo
 lLhRh8tuzcI67G8H2a14EVH/lsELdps1Y5bVkAubwMztI4E8X6kH4KvrCbJQLVPpvfgL
 0EYCLozll1r9uUvhNk54gdSXcXGe42E4qIm3NTR2r7pJ+0hmsupDCqGWUJlOA72lNiAK
 WANg==
X-Gm-Message-State: AOJu0Yy5cZ2z2Y5EEfqnuVVMensbL9XoeeoK/+QmfyvHnqJWcWwPcdof
 WW18VtW/V282jt14CXtoe1piYweC2RfkHj8tfKWIKgs0UosfiFVu7Jww
X-Gm-Gg: Acq92OGHWlXdg0Kn4vrOOk/SKV/j6aNrLVFoL5vlcmzltqrJMZJU+NxSMJY3L7HIUGN
 qO8LJczEGVd36yG8Hald0KTJ1yITcSWemDjMP6iqcr9jk+s3ggYAMkA1lFOqh8Y40C0b5Wmgz0G
 aLpNL2cm/4wd7n27QU4ZQ/lY6rAVtQEIF4vOgGIUuK+TaLOolP7nU1RIQjbabC5TAVM6bLKAU/p
 GTkuU3rC0PGSQlKjzSHPdsKCI2rco9E5pfgW2wSQbaxQ5YDqZ3uNs79Y8WTHs1/b3/6RPEh5Ib1
 SNaEkJw9D0RQ2l/Ef6tF4JzkgcapByYmw+A/0/GRkQUcbTMN4DiH+hPFWbRxeJ89sw0orxzOU5y
 gfm8NYFlvol1Crccds2eUW640BOnPQe1istSFttwwjiM2/z0yexmcZjbnaTb88z/4gyC+XxPVeA
 bHqq/IqLJIJrgSI4bTpRSvFxXlZYMtAhXbuzNptNGJtc6LwWdJFoBv4yPX1DOMPy9pQSgpyKUjN
 x9XJkc=
X-Received: by 2002:a05:6a00:1904:b0:82f:38:a5b2 with SMTP id
 d2e1a72fcca58-83f33d835b8mr10093396b3a.40.1778979159339; 
 Sat, 16 May 2026 17:52:39 -0700 (PDT)
Received: from deepanshu-kernel-hacker..
 ([2405:201:682f:383f:29ea:98ba:649e:3b6e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c7809esm12627735b3a.44.2026.05.16.17.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:52:38 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 17 May 2026 06:22:30 +0530
Message-ID: <20260517005230.28172-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wOPkK-0008L5-QG
Subject: [f2fs-dev] [PATCH] f2fs: don't BUG on node footer mismatch in
 f2fs_write_end_io
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
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+4af46ee83100e99bce09@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Syzbot reports a recurrence of the kernel BUG in f2fs_write_end_io:

  kernel BUG at fs/f2fs/data.c:388!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 PREEMPT_{RT,(full)}
  RIP: 0010:f2fs_write_end_io+0x16df/0x1740
  Call Trace:
   blk_update_request+0x57e/0xe60
   blk_mq_end_request+0x3e/0x70
   blk_done_softirq+0x10a/0x160
   handle_softirqs+0x1de/0x6d0
   run_ksoftirqd+0x52/0x180

Commit 50ac3ecd8e05 ("f2fs: fix to do sanity check on node footer
in {read,write}_end_io") added f2fs_sanity_check_node_footer() to
both end_io paths to catch corrupted node footers reachable from
fuzzed on-disk images. In f2fs_write_end_io(), however, the
existing

  f2fs_bug_on(sbi, folio->index != nid_of_node(folio));

was left in place immediately after the new helper call. The
helper detects the mismatch, sets SBI_NEED_FSCK and emits a
ratelimited warning, but its return value is discarded and the
following f2fs_bug_on() panics on the exact same condition.

Tracing the reproducer confirms the failure path. A node folio
with index=11 is looked up via __get_node_folio(), the
synchronous sanity check at page_hit fails with -EFSCORRUPTED
and out_err clears uptodate but leaves the dirty bit set from
the folio's earlier lifecycle. A subsequent read_node_folio()
fails with the same error (footer_nid=0, ino=0), and
folio_end_read(folio, false) does not clear dirty either. The
writeback iterator then finds the still-dirty folio via the
PAGECACHE_TAG_DIRTY tag and submits it. f2fs_write_end_io()
observes folio->index=11 with nid_of_node(folio)=0 and panics
from softirq context via blk_done_softirq, even though
f2fs_sanity_check_node_footer() has already correctly identified
the corruption and would have signalled it via its return value.

A filesystem inconsistency reachable from a mounted image must
not panic the kernel. Mirror the handling already used in
f2fs_finish_read_bio(): capture the helper's return value and
mark the bio with BLK_STS_IOERR on mismatch instead of issuing
BUG_ON. SBI_NEED_FSCK is set by the helper, so fsck.f2fs will
repair the inconsistency on the next mount.

Reported-by: syzbot+4af46ee83100e99bce09@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4af46ee83100e99bce09
Fixes: 50ac3ecd8e05 ("f2fs: fix to do sanity check on node footer in {read,write}_end_io")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/f2fs/data.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d4f1e75dee3..c149b0ccf22d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -382,11 +382,11 @@ static void f2fs_write_end_io(struct bio *bio)
 						STOP_CP_REASON_WRITE_FAIL);
 		}
 
-		if (is_node_folio(folio)) {
-			f2fs_sanity_check_node_footer(sbi, folio,
-				folio->index, NODE_TYPE_REGULAR, true);
-			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
-		}
+		if (is_node_folio(folio) &&
+		    f2fs_sanity_check_node_footer(sbi, folio,
+						  folio->index, NODE_TYPE_REGULAR, true))
+			bio->bi_status = BLK_STS_IOERR;
+
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
