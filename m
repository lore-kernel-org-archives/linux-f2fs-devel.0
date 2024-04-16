Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D7C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Apr 2024 10:17:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rwfsX-0000RS-Tc;
	Tue, 16 Apr 2024 10:17:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rwfsW-0000RF-LL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 10:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n6f7i1qASJwKLrPTo0i3pjOAxS5JH/p9kvuuXeqy1ic=; b=lcoY1nOPHOQw3NlDxcD/cK8wgJ
 rfl8xsmSP02LCjOsZ6/EI7N6L7oyDPS1Vuvxz61hmtCXdYd8Kgnz6VLbNL42pn2403lDyGTef/K/g
 OE4reZeGRyqdtNOiTbHspx/6Xfsak+kVh9Jo7ZgUbLm3iz6AobYVZg9BOBaXntDJR5d0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n6f7i1qASJwKLrPTo0i3pjOAxS5JH/p9kvuuXeqy1ic=; b=b
 +s0/FH4ROYJUsQPUISFtAXHcPJcLv4Uvuw41WpETSQ3e9lUyekVzeFp3T2QqMrQMffGrD057/QASe
 uMXWhQ7PmNRJLNuAvpfe3eiMb1EOpPp70NNuAcAMFkC6pl1IOiJz18kEgIemf5RbTX77DvuTtCpAB
 VSCEdRXYbPnWo7ZU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rwfsW-0001eq-Th for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 10:17:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 669876113A;
 Tue, 16 Apr 2024 10:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805EBC3277B;
 Tue, 16 Apr 2024 10:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713262643;
 bh=niqDEdS2YIw7sdPWeFN+Ymj6+SKkFG3ZVVWcVrQ1eb0=;
 h=From:To:Cc:Subject:Date:From;
 b=QZZ0OJT+Qfzuo5pqWx26IFAVHSPWyxzYmvpbJUdYA+/QPpxWYdWTlrN16tLO5F2ak
 QhP7GQ9YDOH0/ohFkwqu8uHiUBfV1Awsrf11tFlgJmVC/xvxHuA4ZtP2oTQc4T47kP
 +NQ8d+hZg6eUNVHHCIFuskGc0ZFvM6mv3tQmWYh7KWJK/eJFhpTnJq5MGHVTr+Sewo
 6+BQBYjPm4OlTt9Q13bbBW++FHTmmeqib6Y+qe9oKLWqzkC4DT4PeKCyljyJrUlOTb
 qsCaV0G7gL7AaSBukk+cqZ8ObqB7R9TEh7ReLSrtr97lJ32hGrWswXqtRNtM/2W/wd
 yYFzgSSEbZeNg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Date: Tue, 16 Apr 2024 18:16:50 +0800
Message-Id: <20240416101650.53078-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rwfsW-0001eq-Th
Subject: [f2fs-dev] [PATCH v2] common/quota: update keywords of quota
 feature in _require_prjquota() for f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Previously, in f2fs, sysfile quota feature has different name:
- "quota" in mkfs.f2fs
- and "quota_ino" in dump.f2fs

Now, it has unified the name to "quota" since commit 92cc5edeb7
("f2fs-tools: reuse feature_table to clean up print_sb_state()").

It needs to update keywords "quota" in _require_prjquota() for f2fs,
Otherwise, quota testcase will fail as below.

generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc

This patch keeps keywords "quota_ino" in _require_prjquota() to
keep compatibility for old f2fs-tools.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- keep keywords "quota_ino" for compatibility of old f2fs-tools
suggested by Zorro Lang.
 common/quota | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index 6b529bf4..4c1d3dcd 100644
--- a/common/quota
+++ b/common/quota
@@ -145,7 +145,7 @@ _require_prjquota()
     if [ "$FSTYP" == "f2fs" ]; then
 	dump.f2fs $_dev 2>&1 | grep -qw project_quota
 	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
-	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
+	dump.f2fs $_dev 2>&1 | grep -Eqw "quota|quota_ino"
 	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
 	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
 	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
