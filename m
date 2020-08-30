Return-Path: <SRS0=NE1+=CI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0917C433E6
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:56:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF76207BB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="d7etgCWn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KgGU45mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF76207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dlrobertson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kCBe3-0001px-3M; Sun, 30 Aug 2020 00:56:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan@dlrobertson.com>) id 1kCBe1-0001ph-HN
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Aug 2020 00:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Date:Subject:Message-ID:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iNy74DJ8ZqaYSfNCS0u35zueJlzuqVUyyiZqdiPh6JU=; b=d7etgCWnFVjpEgerJoMpogr+gg
 9KANk+5apE22vengk3FkCevVJ+ka4QlIXc0SO20cqtSrJgGHQmUIxX0wHD82WRHyaE6Lkvq9LjQDL
 nqDX7p/ksuimYbP2WUjBVmjBLfwoIkBWsGV+/Z771GNru3HNxqXDw8KNw3T2GsWWrhFY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iNy74DJ8ZqaYSfNCS0u35zueJlzuqVUyyiZqdiPh6JU=; b=KgGU45mF6eTzD7depIi8jIfLcx
 OjvNy44YZkJMFXC7nO288WHHELJ4fmSebMBvz/HKdbIJ6dFYzCvlCYvkxP5IfZ6C0nwEx9hdG7AVH
 P/BK+41NZvmRujqOLwqE41/HkkHhUBFbMufDvizhXUtxgNBZGyzCFUKXKWmZcvdQdRII=;
Received: from sender4-op-o14.zoho.com ([136.143.188.14])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.92.2)
 id 1kCBdw-004xrQ-2y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Aug 2020 00:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1598748959; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VjsoE4PHxYJNPpP2v98pdxjXaX2uRcOLsTitmYAcK6pKYU2x9u2o/1Zpjv3KwWkmro/SOK5eLrpPy8euedzaceObUiO/gGdpNwrpLiGTldHp3PwDRFhE5KvGRL60g4hz0lZ2G8S98upLa8OfkqCIa46ki9hVGU/Cdblmw7QuujI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598748959;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=iNy74DJ8ZqaYSfNCS0u35zueJlzuqVUyyiZqdiPh6JU=; 
 b=b10hKTjK0w2vYMy3tQZsYC9Y1y6zFD0kAHSoSy9j1D26e9oVEtAt1t9McSxW5ObbntQEMTJmLEZ1sWkfkO6jhOlh8+4VDjqLTfeFDlbPz3zlGuaIlEaa1ECNrPcurZ0OelyjA+I8G7XVukSdpGHxUwGAk8L/ZHU0o7T4EmpF0QM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=dan@dlrobertson.com;
 dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from localhost (pool-108-28-30-30.washdc.fios.verizon.net
 [108.28.30.30]) by mx.zohomail.com
 with SMTPS id 1598748956420185.5213940988209;
 Sat, 29 Aug 2020 17:55:56 -0700 (PDT)
From: Dan Robertson <dan@dlrobertson.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Message-ID: <20200830003520.6542-2-dan@dlrobertson.com>
Date: Sun, 30 Aug 2020 00:35:20 +0000
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830003520.6542-1-dan@dlrobertson.com>
References: <20200830003520.6542-1-dan@dlrobertson.com>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Headers-End: 1kCBdw-004xrQ-2y
Subject: [f2fs-dev] [PATCH v2 1/1] f2fs: check output position in move range
 ioctl
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
Cc: Dan Robertson <dan@dlrobertson.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When the move range ioctl is used, check the output position and ensure
that it is a non-negative value. Without this check f2fs_get_dnode_of_data
may hit a memmory bug.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8a422400e824..650ae0dc7cdf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2783,6 +2783,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
 		return -EOPNOTSUPP;
 
+	if (pos_out < 0)
+		return -EINVAL;
+
 	if (src == dst) {
 		if (pos_in == pos_out)
 			return 0;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
