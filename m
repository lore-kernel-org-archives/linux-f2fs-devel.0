Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502EAC04FF6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:56:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rwcjc-0005Xj-S3;
	Tue, 16 Apr 2024 06:56:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rwcjb-0005Xc-7i
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 06:56:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1rvgeptsgksYeIm6PpSXlKKXOcGVyaFa7MWfMobiqk=; b=AJb0i6cNw/5XXvdtWpEKQeJnkY
 lMtJUsslKmSrsB6vXiJZ4tREtE6MltP5bes1nNruweZ02qfOoEt6PWQ1GHwG5xfsMtDw+3CxpO+9e
 Vtp7TR/rK6HbLzPYlu3MOUoA/7rpnErzBpHMBOGSMnFRA1d0BUEotSqVmCnCubYSdb9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a1rvgeptsgksYeIm6PpSXlKKXOcGVyaFa7MWfMobiqk=; b=g
 ijd+eV4xtBl2PfFcUZdTLkkOuDUBGZqlqR4r1KkSQrQ+8O2HOlL/O1hE+sEvL+Es2se6icZMJPwaN
 t2acS3ObFFRQxqMxzdKkzGDN3QYisLqhtvtZvpMTnQxjiyAYECY5uWG5v7QyN4pcvyDwbSSbdqiCS
 8MU14bsFvcB4FMLU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rwcja-0000du-7Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 06:56:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AD69660BA0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Apr 2024 06:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F31C2BD10;
 Tue, 16 Apr 2024 06:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713250551;
 bh=MeLCyR4+OIdXgpgavDBf0FEX1HcXJPVc8EDq4HZGI6k=;
 h=From:To:Cc:Subject:Date:From;
 b=jLSoTkMicxUrJShuV21B3Rxw8y71aYAZx+K0YBQhUZHVfygEt/1p5aPorHYKAy6Wf
 Oc4O14I/b0yavp0qc0lRWtAa+CeN47xRRPwbZlJiBP0Oupktgd9kOvGFuYHiQZ32kQ
 x+uvCilpWduKkbH8aKJiqRdg3UO/4J8SEGgTtUbF5oWH5MJTJqL/INFf36kS7L5vT3
 346ISN2GKGWqgFLec9itJFuAUEeRFeBkboDYhIt4K++lk4ONQhW9kR0K7IJO1jd2Qo
 JivRvWQ1NJS4heRV84rIU7jNCHSzGvS8owaBBI8HLg6K4bI/cf/5jEkIMi6fIQg5Ja
 TMn0jlDPs6tnw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 16 Apr 2024 14:55:44 +0800
Message-Id: <20240416065544.4192106-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rwcja-0000du-7Y
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: add description for ro feature in
 manual
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add missing description for readonly feature in manual of mkfs.f2fs.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 man/mkfs.f2fs.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 0dc367b..1f0c724 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -208,6 +208,9 @@ Enable casefolding support in the filesystem. Optional flags can be passed with
 .TP
 .B compression
 Enable support for filesystem level compression. Requires extra attr.
+.TP
+.B ro
+Enable readonly feature to eliminate OVP/SSA on-disk layout for small readonly partition.
 .RE
 .TP
 .BI \-C " encoding:flags"
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
