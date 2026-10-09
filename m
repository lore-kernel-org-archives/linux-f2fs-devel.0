Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A947CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Egz3v2e1AZmS8JpE1+HSXmQIGy8OnAd4iTPaj6Gm0gA=; b=gPnJfawdWo+E31zI6Znj3pQ/jC
	gDWtq56uzaQJBkW1Mj5xpSYM4xQ8sdheDlCLhpkqaedZWVCPa5rs4qJ2Ce0o7HTe3QXMvXmAtDUGn
	Fw/StpOUmTlW3hDVmCGrGKRRrcLEfc2A/h+QEA4YwS6E60s1BBtelmm6kFzoJD/F0bok=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF6OZ-0002oQ-WF;
	Fri, 09 Oct 2026 08:56:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3G6zIagwKAPIdjlomUeiqmecaiiafY.Wig@flex--jprusakowski.bounces.google.com>)
 id 1xF6OY-0002oI-It for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:56:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XkufVygYf3das1AkCg5Yl8KsorAKzoeCOi7nexNmHV0=; b=LrmSIIGOY7322npfcGkZVAmPb5
 o7HvuOITYL8WPgYGSWqHzR0+nSu0423Elv2dZnQBY3FiI5XC8LVpJpMSHkCPJ17jNKYJxxfndXZO6
 VQSTFJZi35ha7fsI8yB+GRvRd/KS/h3YEXkMbExRTTIHLLq2bZmDQqVKqjF/dVYs/5Hw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XkufVygYf3das1AkCg5Yl8KsorAKzoeCOi7nexNmHV0=; b=I
 ZwYZ61tBK92b4mXzt5ujA7PbXHfIvSD4OkAABAa6yothN9qtAyecIf55Mo1tKPVZh4FBSLiKOjBzc
 O5xtTc4iARExWQz8YBIUkjB99tFMx9Ilr3M7dgeVhq8FYOAdk2kF+7S0sAPbjfVoTRNDTJDjfQHVJ
 GyqHlMZdjYruGabw=;
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF6OX-0002EG-V8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:56:03 +0000
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c2d93b92937so611065966b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791536155; x=1792140955;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XkufVygYf3das1AkCg5Yl8KsorAKzoeCOi7nexNmHV0=;
 b=HTjsZHOvx3fxaIWiQ1Zz8IQvtmWq3IG1aV8lJwhwLfg2yKvyiSqSGIbgxPQLOtCc2m
 slAChOiitDf4BIi9gCX2O+RN7uVEZEAd1uMswWOGoCW3FguTRnJNVh4EjWB5lRsvFHzY
 5SYWZcceu9Akq8ZrrUelmPBUv/1QM5BBxgZhOUG5E7aAdgxA4XfPXhsZCS9nd1ndLczq
 5bnLHGtIN1oP3vzpPUo7kmjoEjqz0KnSfaqeQWqrhrI1630NSqg4dOMRnRuCWl9Sz2mL
 Rjm+xHxH5HfcmDd1zSTgnguWe6N8sZlAhqGWgVteoMlMEGSPxZoktJTv68uCc6sodpN7
 65fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791536155; x=1792140955;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XkufVygYf3das1AkCg5Yl8KsorAKzoeCOi7nexNmHV0=;
 b=pB0xMydQV4B6IQ6QY9r4V22QHDvUwOQCuVMBoEQkBvSE+x1A/XocgbiWIkD+tLSVsT
 owjrH/l3diLT/9GwCr6LP91m98MK0o1YM0CaTHVGQnveqYJkNu+v9MGI8HzBqt9BIwhy
 iodXFJ+/snRcKn0nJulxqNFznr23pfeGDAlobKjj1jQIT7+Yt8DteHXueHVETlmhH/lT
 4VSKv783xxF3iBJ2xTue1vwsY1WbZla8DV+qu8JiAaPfBw6e1Z1Cpaj2oY37JfthwimC
 o43U8+PuC6aQKUqTMmM/b7zqH3MepdxbPtDBqFUjpFbR40yVkftp4ecPKBt26iIhuHI2
 XWVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwwh4F5wi6uwDSuVix0N+q7FvK3afTEBkhioNQfVHXFSl7IaBXS/80f/zYE564C6qDufYVkGv1NpRJetGEuFTa@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI1eSu8TdFtXSd48yUyC8yvPmY2SMnlIUxlunJgIxVrkO4qndDT
 M+q0x8zEKT6Qw7p5tH/vcUVwDGShiuXO0mJFIIp82Q+v2aa0nSZ0VBWzZ5N3ZphEOIQn6lyx8c2
 P4Ywr4UxSX/3FY2iLT1WdpxPZ/9MjHA==
X-Received: from ejcxk3.prod.google.com ([2002:a17:907:d803:b0:c2a:e413:97d5])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:961a:b0:c25:2a78:15ed with SMTP id
 a640c23a62f3a-c31a9a04e08mr114472166b.6.1791536155187; 
 Fri, 09 Oct 2026 01:55:55 -0700 (PDT)
Date: Fri,  9 Oct 2026 08:55:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009085544.2450966-1-jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
 fstests@vger.kernel.org
X-Headers-End: 1xF6OX-0002EG-V8
Subject: [f2fs-dev] [PATCH v2] generic/622: increase sleep time for lazytime
 expiration
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

However, on filesystems or configurations with higher writeback
overhead -- such as F2FS with transparent compression enabled, where
compressed files cannot use inline data and writes use out-of-place
updates (OPU) with higher latency in the compression and writeback
pipeline -- the 2-second sleep window can occasionally be insufficient.
Because the inode is only eligible for expiration after 1 second, only
about 1 second remains in the 2-second sleep window for the flusher
thread to schedule, expire the inode, and mark the inode page dirty
before restore_expiration_settings resets dirtytime_expire_seconds to
24 hours and shutdown occurs. If the flusher thread is delayed, the
subsequent shutdown checkpoint ignores the unexpired I_DIRTY_TIME inode,
causing the test to intermittently fail with:

    FAIL: lazytime mtime wasn't persisted by expiration
    ondisk_time (...) != expected_time (...)

Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
to give sufficient margin for the flusher thread to reliably expire the
lazytime inode and dirty the inode page before shutdown.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
Changes in v2:
- Increase sleep time to 4 seconds unconditionally with an explanatory
  comment instead of using an F2FS-specific conditional.
- Remove the non-standard Change-Id trailer.

 tests/generic/622 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/622 b/tests/generic/622
index cb0f5828..16088199 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -60,8 +60,12 @@ expire_timestamps()
 	__expire_inodes
 
 	# Userspace doesn't have direct visibility into when inodes are dirty,
-	# so the best we can do is sleep for a couple seconds.
-	sleep 2
+	# so the best we can do is sleep for a few seconds.  Because
+	# dirtytime_expire_seconds is 1 second, sleeping for 4 seconds leaves
+	# enough margin after expiration for background writeback to finish even
+	# on filesystems with higher writeback overhead (e.g. F2FS with file
+	# compression).
+	sleep 4
 	restore_expiration_settings
 }
 
-- 
2.56.0.360.g66cac248cb-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
