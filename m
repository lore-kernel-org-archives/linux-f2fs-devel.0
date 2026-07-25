Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36574C53209
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19RTRE05Lv3DKKLo4o2b4EkGEDeE8r8q+B4pv7bLkMs=; b=e5qJm9grbJfE56qhyoGSEBHiGV
	D1QCIj5qtG1iP5tUOnosfASCP30S6tcaH/UR8q5YWM5tJZQdXd68s9bcPjvt34/0m8llKaKnn2bTz
	AhjIoGfdrFGU3NA3oP+kyKt4jZW6tB8SvqItb1xzhNPQBWztAiPGUVbeaodAAmAshXWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzH-0004IV-Pq;
	Sat, 25 Jul 2026 07:39:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWz1-0004ID-9i
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/ifHRev1KZt7zJcATaDa76vriuxBeCWHVdvTL8hqTg=; b=lci+4FLAlaYtnvyS+bHLhm1gZP
 Fdv2jb4Nawj/3jcgeD5m9rftNb3378fezxlkF3UsUMDrTgvw619/L80cUCJZhEYoDCFeoweSkSOjC
 hKDt1m4v75Y6uSKPhK98D1fUyxvQEXGY0e4OhsPS8YybzkJbjXpsJLu2e7OcHh9qVTvI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H/ifHRev1KZt7zJcATaDa76vriuxBeCWHVdvTL8hqTg=; b=ZpONLXxuvUqIaMYhw1Mz+Bmmg9
 B74RcVW8XzWvEFXEBWUL1Nzh5igOvI9jFAcGLThnmPyVyX8li9KQFcK7xBCwXv7mKm1CyJTXb+DKt
 4rn3PXwhhUzusv6onGa43FqEXuw9Qqvg0BnVoaOtG4uNv4irws2zfGwwlnJ1GKtCqkzA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWz4-0002Fu-Ev for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53718600AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F31F00A3A;
 Sat, 25 Jul 2026 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965177;
 bh=H/ifHRev1KZt7zJcATaDa76vriuxBeCWHVdvTL8hqTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RKU7fcelYnCko5jUYOMQve4DorkA1qbXiJ+i7OXYVbcBLCt3EtDx7pFzbeAor+C0P
 KH7sUzDNrZ1zBWT+HEY3Gu3eegC4BYGorI3eGSB7a3wLbgM04xn9CK6MCbshToiqzT
 L9DFZos2OkjbmYObAjimO5pN/uT697pJH1+8s2K9+UIJhaMf+pfq1w9BbzYOjjB0AN
 PkeSwcpRBqWutRvQjjwbvcMut6yZxtwTnvhP3F8iUNYm2eXvq0YJfs8orVtHi/rQOy
 LrCFIIl4iZhIeqU7xmMVgBjq2D1e7VKm2R3vegb6EiRyoOrwtgIVzZTdylVNVh5BFB
 9a2HJ0BlxV0Iw==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:00 +0800
Message-ID: <09003af49b95d3b7fdf24b0d76e3ef389b44c3e1.1784949154.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWz4-0002Fu-Ev
Subject: [f2fs-dev] [PATCH v8 03/13] fstests: add FSNOTIFYWAIT_PROG
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: zlang@kernel.org, djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Define `FSNOTIFYWAIT_PROG` for an upcoming test case that uses `fsnotifywait`.

Signed-off-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index d5299d5b926f..5661fa0ec310 100644
--- a/common/config
+++ b/common/config
@@ -242,6 +242,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
+export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
 
 # udev wait functions.
 #
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
