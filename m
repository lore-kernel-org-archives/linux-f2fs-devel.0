Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE00C9832A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7TQbGY/1/6oDX1V5Ig1bZcshP/8jj2Ne6utwjuotS1Q=; b=L2eYp/+mnnnYVNN0tVVXBAGBBJ
	GP6VuhvlXfO4z4GWLeyZbtkE5Cp9i+cD4Lrud4uoJkVcfjvHvIij47hOcpOXKIDvb/1UZ9SdIF8kR
	W2aIn+d+kowJ4XoMidXz66ep9s+FHuNAUYso2x7QjN6QWsCrE7Vlr2hfuCkbpgkzrRx4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBZvE-0006f9-Hr;
	Tue, 29 Sep 2026 15:39:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xBZvD-0006f2-7X
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 15:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4PcGmW4OknE9lShUDrZZfYNyUZ1IRuzxU3cRcRXt4Zk=; b=WNTw0rO/tI1nbfoeq9+xH7gM7t
 xIKYlJWi9O2byr8wvIVjhuxxsn5PlfY3WFone0WcQ9FmeyR3sl3Yixe64U20tcSH+uWOJU/R6NXWC
 HKA6XsTTjDUjP+OWfGv9MBwAaZVYgQ+84lLtk8YbqmT/KuQ4mEvunrsbaa8ejIEG0ZO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4PcGmW4OknE9lShUDrZZfYNyUZ1IRuzxU3cRcRXt4Zk=; b=K
 6tn/mmtDjGLeg014gBPKwZjlhoD0Nt+SHIl1d2LZU9+vnFeWVz2dZJUCwJ739j4QQbVF8YXv/O3GG
 yAfkOZdxaTaEkewkX74mBRubVZDM6Tod/wJhEHEO4nQJVHuHP8/1jUz2WAdIgjtW0qMODcgtpL5AU
 jXBGkSF+keyzSkRk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBZvB-0004Hr-Om for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 15:39:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E53360008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 15:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27231F00893;
 Tue, 29 Sep 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790696343;
 bh=4PcGmW4OknE9lShUDrZZfYNyUZ1IRuzxU3cRcRXt4Zk=;
 h=From:To:Cc:Subject:Date;
 b=XBWUg8BocvwNWk6qA1F6JK/fo1meAAJdCjPESgdUmGvGEnucaf6tzM3NbvZS+10f3
 u6HcIlhD5MOAhWnZbNk7dZgZ26yZuowE+gs+o3LJEumu7DCyT869VIu1sf1ivsTI3A
 4u3EkFo5WUhE1DbzKRwijEWx7/7/eCmLRULP5+cSNwrNqs7V/AoOdA+ZbYHjLE0F6n
 Wj2tbAqB+fiAzDwC21p/Cd21cBmMMLJCe7mgwyCeVOmO89zXqYlminkpGcfSoo8JFE
 mYFVrHM3bPT31iJiFML0ArIuhswjNVGhhGe+Zt630GY0l4ier3YU3cNUfsNqlkRjD6
 7WSyltzbsw2JA==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 29 Sep 2026 15:38:59 +0000
Message-ID: <20260929153859.3936490-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xBZvB-0004Hr-Om
Subject: [f2fs-dev] [PATCH] f2fs-tools: upgrade version 1.17.0
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 VERSION      | 4 ++--
 configure.ac | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/VERSION b/VERSION
index bae2e2c9e202..95414ea41dd7 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1,2 @@
-1.16.0
-2023-04-11
+1.17.0
+2026-09-24
diff --git a/configure.ac b/configure.ac
index 4d91605f8106..b82653f70650 100644
--- a/configure.ac
+++ b/configure.ac
@@ -279,12 +279,12 @@ AC_CHECK_MEMBER([struct blk_zone.capacity],
 		]])
 
 # export library version info for mkfs/libf2fs_format_la
-AC_SUBST(FMT_CURRENT, 9)
+AC_SUBST(FMT_CURRENT, 10)
 AC_SUBST(FMT_REVISION, 0)
 AC_SUBST(FMT_AGE, 0)
 
 # export library version info for lib/libf2fs_la
-AC_SUBST(LIBF2FS_CURRENT, 10)
+AC_SUBST(LIBF2FS_CURRENT, 11)
 AC_SUBST(LIBF2FS_REVISION, 0)
 AC_SUBST(LIBF2FS_AGE, 0)
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
