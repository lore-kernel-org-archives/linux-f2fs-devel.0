Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AE606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DULSYcbt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EbMX/4K0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kjn7pckr;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VXmogLkz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=odHcPS4/8z0uaZsrvTFAMINjX0PhXDhRX8+lRsNuZCI=; b=DULSYcbtnnI5SZgdrVh0zvgSXG
	+w9IHLlrbZNefZ5o8dgu7wCAtA+p4CFeS1maIcEM6PR1mJCl9bZK1PRIioBXQaGzmpC+n98GAf82j
	7tNYUl7PLKja5kiIXWie51twjg6IG+b/yFd10ifcADQFNK9cEyZakadgoWkhjfq570+0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOQWh-000000006qi-28nS;
	Wed, 04 Nov 2026 02:14:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yangguikun19@qq.com>) id 1xOQWd-000000006qa-2PT8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 02:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XBfDJz7gRmZu0nchIG89qaHRCgmqXtIjg6YwdCNMrB0=; b=EbMX/4K0/nkTYWmmgcI+re7Dky
 7NvoAt/1a4cTs15nUambcjmTf5IGNAuGll6HYpI3LV0Dy8rKot8XRMesHDG8CqP0CmxXMiihgBHNA
 XmXPbtpxr3rSNKoCH0zeQ2qctG+a/i0nhXvebSB8QLZXev1UZrEKQBz7DYqxP46IZ4fk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Subject:Cc:To:
 From:Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XBfDJz7gRmZu0nchIG89qaHRCgmqXtIjg6YwdCNMrB0=; b=kjn7pckrsJyV7n/erSAoJg4Dje
 U9uj4z8YUWXj/LmD1zwbQdyXfatK6uFuXfV9JtdD3oBJ08afQqk8w69Xf7rnS0fu7Ehs+N1t+xVKM
 yZ9si+YDAHJ6WXFOhzsnESIgkWFpi6uojMOQqvP2bkg3vsnh2uWYwMEHFGsKXiae81+U=;
Received: from out203-205-221-245.mail.qq.com ([203.205.221.245])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOQWc-0000000017Z-1ogo
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 02:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793758484; bh=XBfDJz7gRmZu0nchIG89qaHRCgmqXtIjg6YwdCNMrB0=;
 h=From:To:Cc:Subject:Date;
 b=VXmogLkzIGclfhHNxBTDQ4LZnVs90i7g9cM8cBEwJOO/w0ydA04Hl3T0asDBbBixz
 5FItUqEl4M3M+0RZsgPdla8P0yc3gUnYuyXX0urb1JEh3uOn//ErJ3/79UCCLqlZj4
 f54XbsGB5upQIX+6VOYM87pTBB99aZGoFATh6O2I=
Received: from [172.18.4.77] ([61.136.26.103])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 3AA3AA30; Wed, 04 Nov 2026 10:14:42 +0800
X-QQ-mid: xmsmtpt1793758482t5umfjkl8
Message-ID: <tencent_B30A444DF94444D1A63A7D6F8E2039F1990A@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+TI9SJW93k+F4Nm6gBclOCQ6YEtUfR+kPyYOdsLRR1VC0akUk4P
 cvyXtL8eG/J5VhHqmsxOoRL+KTnvVXNEVAC+JrkJH0DVMg4rsmsmGpQab17+haxylgstI/eMpsAV
 YyjZYO/ywG2xwf1+MhXq0wshhSlw1d9VHbf3snqxD/ifdZKxqqZrWZBquireZdj6QBbyXd9sTYHZ
 Bk2gBRrswfDSDn6Z45blflUgxQt0s9vJsjkuYScHZt81GC9nwVbJkbjcuaP0uBhja7+6xBaMti8J
 ZZDkWC8MyAkdDXrxt2TZtC7fUl5p421TOYlr+wIREWThvg0HTepbAmw26rft8aFKSTSNIO+/cEBd
 GP6Vi8SjbSJNEf0YG+Y52pqVqqHee+pEYKQ/s+nEXz4YlmPtnPANAPrvcH+2G1rtMovemBNotqDV
 PlnzIVRzl2b79ucaYz6YhIYDBW+NwSnz408dXV4Q9tvV6UhUvXPjEHp2MEpdVJInMJW+3AYUyChp
 PlgNDIxbPzIa7pn5IPlvgHpNXh/padZMlcHwOTxUnxqULbyCjSwu7KqsIAdybqMOhB3V9QPQalIt
 tdW3jcbmtqJq/FHVclZ6SXFi6XDtekhSB5ujVuZkpYcEEjU6R4NKGUvqNNyi87Vfc94Ar05MB54h
 HtcM1g1Uxmqag1OGIoEC9BP1P2UAEwpdqGr+Zt5v/2qy5phtwpUHdcV//IIh9c+vvwtxB6Yh37FW
 Vi5Gv4kuoTYMPX4jO9PscwuB6guVbsHf4VT0/qfdBl9+OcCd0q/Vw7cjvfLNnvB5oB7MDCZMD8Vd
 aqmzT1BzoU+FNMirUZnqZgWiIY/MrNSJRX4buO77Wrvry6ApdXTLBICXGtXW5trUtXNm2yWkcnqb
 eZjpO/fGG13V8sX1w4P9jWNLgH1go9f+bDdbyhQ01D99Q5HNqM1PmRpXkNMx2z+syIouf24ZeCpg
 nQtb56ow0ZGLNykSA1/h2/VADezbqdPjACA8GEInkRijjKu6XH0HgY83v4DoceudkyRnTFw1mHDd
 hr2N8z71qz4OJIZc7skEXUA5sja7cmyPGAkQc4hDO0mm+qVV0hVH44AWm2kkY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-OQ-MSGID: <c17-f2fs-orphan-enoent-bug-20261103@qq.com>
Date: Tue, 03 Nov 2026 16:00:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.9 (/)
X-Headers-End: 1xOQWc-0000000017Z-1ogo
Subject: [f2fs-dev] f2fs: orphan entry pointing at an inode with no NAT
 entry triggers f2fs_bug_on() in recover_orphan_inode() - kernel BUG at
 mount with CONFIG_F2FS_CHECK_FS
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Guikun Yang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Mounting a crafted f2fs image ends in a kernel BUG during orphan inode
recovery, before any syscall beyond mount():

  kernel BUG at fs/f2fs/checkpoint.c:988!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  RIP: 0010:f2fs_recover_orphan_inodes+0xa1c/0xcb0
  Kernel panic - not syncing: Fatal exception

The BUG is in recover_orphan_inode() (fs/f2fs/checkpoint.c):

  inode = f2fs_iget_retry(sbi->sb, ino);
  if (IS_ERR(inode)) {
          /*
           * there should be a bug that we can't find the entry
           * to orphan inode.
           */
          f2fs_bug_on(sbi, PTR_ERR(inode) == -ENOENT);
          return PTR_ERR(inode);
  }

The comment assumes that reaching this branch means a kernel bug, but
the ino values come straight from the on-disk orphan area: the only
validation before the loop is an upper bound on entry_count, and the
ino[] array entries are never checked for existence. f2fs_iget()
resolves the ino through the NAT, and a NAT entry whose blk_addr is
NULL_ADDR makes it return -ENOENT (fs/f2fs/node.c). So an orphan entry
whose ino has no NAT entry - or has one freed to NULL_ADDR - walks
straight into the f2fs_bug_on() with no way for the mount to recover.

## The two configurations behave differently

Under CONFIG_F2FS_CHECK_FS this is BUG_ON, fatal at mount. Without it,
f2fs_bug_on() degrades to WARN_ON(1) + SBI_NEED_FSCK and recovery just
returns the error; the mount continues and the orphan is dropped after
"recover_orphan_inode: orphan failed (ino=%x), run fsck to fix." - the
orphan cleanup silently does not happen. The missing existence check
is the same in both configurations; only the reaction differs, and
neither reaction matches what the on-disk state can legitimately
contain after a crash on a fuzzed or corrupted image.

## Reproducer shape

The clean way to build it is to let f2fs write the orphan state
itself: mount, create a file, unlink() with the fd still open, sync()
to get a checkpoint with CP_ORPHAN_PRESENT_FLAG, then crash (sysrq-c).
That produces a self-consistent checkpoint with a real orphan area
(one block, entry_count 1, ino[0] = the unlinked file's ino). Then
only ino[0] is changed to an ino with no NAT entry, and the checkpoint
version is bumped with both checksums recomputed. Four payload bytes
plus version/checksum maintenance, nothing else.

Forging the orphan area layout by hand instead (e.g. rewriting
cp_pack_start_sum to grow the orphan region over the summary blocks)
breaks SIT/NAT journal lookup and the mount aborts before orphan
recovery - the self-written orphan state is what makes the target
reachable.

The reproducer (image builder, ready-made image, crash log) is
available on request. Tested on 7.3.0 with CONFIG_F2FS_CHECK_FS=y,
deterministic 3/3; the f2fs_bug_on() and the missing existence check
are unchanged in current mainline.

Thanks,
Guikun Yang



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
