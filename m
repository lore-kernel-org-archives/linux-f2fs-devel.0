Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC31EA3C59
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCv0EWR4nnYAkfbPRXY44G92+be8u/OFN6uG0Ya+GBk=; b=Jvnz5JHv975Z7D0hmp20Njgl9X
	Z9iWqX/x/iCNf8ngtp8GtyYp1A273K4Jh1/0omeRsYyxDqBufV1VzkSRjL+5azYOkBu1YjQYCHWgs
	/O8/0ZZu0qgBJSXegwcqNFVsn++HWUSadSFOEAOPCt0YZrvoyxJpbtVm9ozPinIsHbdM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wApig-00081q-6N;
	Thu, 09 Apr 2026 13:46:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wApid-00081Z-Cq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TDE3Xhr6zHqJjCSWy60myHo/3qdIF2dXUJA4ZHInr4c=; b=kIpaA4Oo+SawZGnq4c+LAyamGC
 0/shk+eOKWkajCPAqj0Lo+vjsDOTjyNwke3e4F4gh7VsftFw/6Ghc7x6kxQzXuTKU+dSpyBefrL9Z
 u01H279hEZUYbo+vOels3986cpjXZUW4fE17sFg/Z2wDrh/OEUyctR5IeKAP9eCgcKWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TDE3Xhr6zHqJjCSWy60myHo/3qdIF2dXUJA4ZHInr4c=; b=J240UlhngeN0cr6I5X2hBbtmBo
 /xQqrKxnSD3hNIWQL2sq4Fyq8wbwNgSVrhMGZIZQ0njmpVgbWBVhhQc3a4L0wLeJcehR+ER8NPvPX
 HFMS7MZZObprNDWEdqI01wQDc94d8UJ5yjOH6rfE5POJvKNCQmGBEJzFT5wv9uME3hrw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wApiW-0004wO-DG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:46:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 226BB408E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Apr 2026 13:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9799C19424;
 Thu,  9 Apr 2026 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775742394;
 bh=uE4yNbpi1qeAOP/Yd/xWHfdwnj0r5DkJTAFmfXac12U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D0KLzlWg7mpY0bY1NhEJ0H35mWLi3jUzItqDb3nERA44gv0rRGoITaRTQrkr9ZfVW
 eO0Wga88Pc7hd3O0CqVblgA0DzR6o7RZiPI/7hTyOIF0yvWRIlFKjds5kzGW3hSp8p
 QDYt4lrB4/eYX7h3j5qUzqnd8PWYz6SknnBY/Wi+SARoMaPmrN2LBL6C40XJEItUOy
 0H3XeT++SkQNdH+7cuXX+o2SzN6NtASEKffazW9+jY201VIlN+FocOCUeAT/H3J0yR
 sUpLgsxT3N1nQ40HRU+HDDvJC0hvWq38ex4+GB1KqwDLIM69XT9HfjGOGXmR2ZgPA1
 bVrhkOI9G4/vA==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  9 Apr 2026 13:46:30 +0000
Message-ID: <20260409134630.3693274-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260409134630.3693274-1-jaegeuk@kernel.org>
References: <20260409134630.3693274-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wApiW-0004wO-DG
Subject: [f2fs-dev] [PATCH 2/2] f2fs_io: user O_RDONLY for fadvise
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

We don't need O_RDONLY for fadvise.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 8b9f9ef22eef..94e61b850923 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -474,7 +474,7 @@ static void do_fadvise(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	fd = xopen(argv[4], O_RDWR, 0);
+	fd = xopen(argv[4], O_RDONLY, 0);
 
 	if (!strcmp(argv[1], "willneed")) {
 		advice = POSIX_FADV_WILLNEED;
-- 
2.53.0.1213.gd9a14994de-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
