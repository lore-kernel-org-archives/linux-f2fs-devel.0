Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300E4CA600E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Sz7mDBC0IDe5KTEDLt0/iV3O1rWk/76/6ToPwtVZo6w=; b=MTfEDbAPzMsY4rL3H53rs0p+np
	uPapyxFEmPgHLW3uo9HBFuWymvw47u+mrrX7Tp6mEmnoJmfB4fWrG1wQzodGeaQZRhRiflEmS/4Qa
	WNxqqIQQGUkhxfZMpSB5+oh6bQL7lHDo2QjrbG5adZhdfM/yN/tTs7GphgOR2NMAkZJk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEkxC-0008G3-AD;
	Thu, 08 Oct 2026 10:02:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3aGPHagwKAKkSYadbJTXfbTRPXXPUN.LXV@flex--jprusakowski.bounces.google.com>)
 id 1xEkwk-0008FW-Ao for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:01:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v7wb7Vc4+qw5NtWsgABpAo/ja//V46/BzB1YtSmuwSc=; b=XZbFdBvRrQMl/tVjz7y+IQlkTw
 ZDv3U7mMdqqXzkA6lMK8eSrHYeQS9v5Sn2uzUgjznDYyj6l1MwyPVEaqxURE6VQqzAJjZyVd7Nf+S
 kfsmS32eB/xkgryIHYIdHmyGlZQVVgslUn4wwEB8oeJOywbUcIVrjRdpBbhNpZbogOaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v7wb7Vc4+qw5NtWsgABpAo/ja//V46/BzB1YtSmuwSc=; b=M
 JEsRps8SPhgtGOuH7+rWklPnDO8dD8Iu9dLAwBJ4x1ODdsZalLzYWi3t/P8tfC6jP+UKz0O6or8XQ
 /tx3EL3M3oyDu5xKi+W4iFMjVehmxfuMekQJemiO25CCkeXBKm3u73o10YUoBrj2Q3+Q8/sb/a/9x
 V/zdi28t0xlB7mXE=;
Received: from mail-lf1-f70.google.com ([209.85.167.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEkwi-00027l-BA for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:01:54 +0000
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5ba4284e23eso3359785e87.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791453706; x=1792058506;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v7wb7Vc4+qw5NtWsgABpAo/ja//V46/BzB1YtSmuwSc=;
 b=OsNtdxtRiGWyCoLjuphOL0iwv6AWS2b32yEwwi6h8i4T+Ik4LWGC9357TMjPmkOBK8
 pJSMsPM7pVaFw1p5EEjqi+YnHAtUJ8A7UxBTFEKDNF9O0NF78N5NkKDCVvSicHKEl3uB
 QBNWA92jFdsxVnAc+uhZqATBXJIkn4xgperC5Cs/4p4lghpmEat50EedyJqLN4aE8qt/
 1lIS4i2E8seZDlClpkaxoGNHjwhScXjeOVRd3wTrgk6b+qgoMWDb4iQU6hugm/6oRc9T
 tn04kursax+pcdp9hBUiOIQl9vJAkt9Hkhs81i2xZ6y+/db/iNRtEbD2paVV+v5sCSDB
 Ec/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791453706; x=1792058506;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v7wb7Vc4+qw5NtWsgABpAo/ja//V46/BzB1YtSmuwSc=;
 b=VF8Xpue0SM3pOS4z8Q8AJoKoaacIaPwXjHNpRuju9eBukZiC82/8mWc5DeSIbF5GOA
 8RjLjrHRSM5DdG5sJiuJUOuQbLMDsfQ66Aqjp85peWkrdSiXqqj2eogE8QNFQVo3Nm+t
 un/H8tYNn5hYx6jK1+AmJXAQRYdAYB7f0+rKUxY7s1pA9kozm3CI1d8bptLGqsqDu4cP
 CVxpyA6SMyiTb1EShoWqmZwe9iu/b5rLnOKczdPy+E6csCdW9Al0TCGnPwp/1uHuNo+/
 /t180S5lkx+SxcExnqI/tmVZ/6ROXkWQBJEDyOJTrShTKal7A1/Nag5CSa5uJ/mBAY7P
 BQRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGViIEjI3H1CS1OFWgCU6Pt9+qKWkxCtxz+PuJvSFPu/1VKZO4vdL3EbuyyiUrXjxGN9j7AAwtw1jiUFGqi2NQ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLaTYPLB0wFOidL41goZ6npfWswgrQvLotKdprprUeXZhxQdDF+
 P0Ma0hKwwiCb6pbDCng9LCXi9JOl/CY6gOmfGM+V+cZHXZmiVM+sd4oBnh9cMRnXC7ESyCBIKcK
 8mNzP4WTnqCoDWe1glDB3vQZYSz8L5A==
X-Received: from edew21-n2.prod.google.com
 ([2002:a05:6402:a215:20b0:6aa:e5de:ffcb])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:518b:b0:6aa:734a:a093 with SMTP id
 4fb4d7f45d1cf-6aff4575abfmr4787816a12.42.1791452008928; 
 Thu, 08 Oct 2026 02:33:28 -0700 (PDT)
Date: Thu,  8 Oct 2026 09:33:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008093317.2792726-1-jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
 fstests@vger.kernel.org
X-Headers-End: 1xEkwi-00027l-BA
Subject: [f2fs-dev] [PATCH] generic/622: increase sleep time for lazytime
 expiration on compressed f2fs
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In generic/622, expire_timestamps() tests whether lazytime timestamp
updates are persisted after dirtytime expiration. It configures
dirtytime_expire_seconds to 1 second and enables continuous writeback
of dirty inodes, followed by sleeping for 2 seconds to allow the
asynchronous VFS flusher thread to expire the I_DIRTY_TIME inode,
invoke the filesystem's write_inode callback, and flush the dirty
metadata before the test executes _scratch_shutdown -f.

However, on F2FS with transparent compression enabled, compressed files
cannot use inline data and writes use out-of-place updates (OPU) with
higher latency in the compression and writeback pipeline. Because the
inode is only eligible for expiration after 1 second, only about 1 second
remains in the 2-second sleep window for the flusher thread to schedule,
expire the inode, and mark the inode page dirty before
restore_expiration_settings resets dirtytime_expire_seconds to 24 hours
and shutdown occurs. If the flusher thread is delayed, the subsequent
shutdown checkpoint ignores the unexpired I_DIRTY_TIME inode, causing
the test to intermittently fail with:

    FAIL: lazytime mtime wasn't persisted by expiration
    ondisk_time (...) != expected_time (...)

Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
when running on F2FS in compress mode to give sufficient margin for the
flusher thread to reliably expire the lazytime inode and dirty the inode
page before shutdown.

Change-Id: I208bf14c189b54cc209059b0fd2de9e403a073f2
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/622 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/622 b/tests/generic/622
index e8ead300..5879e85e 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -60,8 +60,14 @@ expire_timestamps()
 	__expire_inodes
 
 	# Userspace doesn't have direct visibility into when inodes are dirty,
-	# so the best we can do is sleep for a couple seconds.
-	sleep 2
+	# so the best we can do is sleep for a couple seconds.  On F2FS with
+	# compression enabled, out-of-place updates and compression writeback
+	# add extra latency, so sleep a bit longer.
+	if [[ "$FSTYP" == "f2fs" && "$MOUNT_OPTIONS" == *compress* ]]; then
+		sleep 4
+	else
+		sleep 2
+	fi
 	restore_expiration_settings
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
