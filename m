Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86955C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LPUCWqvtJXKd96pN6opBE1+AxZuIS1At2ZXdaIXKNFY=; b=cVVvOBtWQPHSZRfDgYewYYkcE1
	nAk1W0yv6osGIgukj3YksKZraGTXmm3Ijcxc2Mn1FkpJjaHx/fsytTN+BUCT98Bv8c0DFvq5tT0jD
	JsHSjzBOknk4GvT4AmBAxvHIY2PtYy7Dn0EH3u2AHsIbDgag0i+69cfppf6C1SC0Bw+E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgd3g-000525-1z;
	Mon, 06 Jul 2026 06:43:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wgd3f-00051x-7l
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pn/v4mi91yPi1z8my42KU//6VlnVSyj7cZh1HgSNcRQ=; b=V1GtZ9sSyTlsgfjJ4wVAv2ou/U
 Nby4ZjAaj1jgSHZEbp+wyHm0kb995x2p/MAd5q3VsS2DivXwcUD/XOxOAnmO/VI4z1bxP+OpKqplc
 BThuzGd+2aYXUHhmqUn1fjkwTDtkD8MPbRMSqPcxgRecxInaYI57SVFBIxxhYFlG2HmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pn/v4mi91yPi1z8my42KU//6VlnVSyj7cZh1HgSNcRQ=; b=K
 nY24Kp1VrPmu61UoL20U6YdgHMYYGialED2I0iz/8dahEq+o/4oC/xRRkMdmrhOt70Da11m91w7QL
 D+cZL5WKVBrx98iBV2C99sbbuas65ODIb3PeO3IdD7Wh8WQRU2M7uPB9EVDYySjjGLqdA5IUgUF/y
 wSLn2YyTOa2a//6k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgd3Y-0002lC-GF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:43:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A4F9341A39
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  6 Jul 2026 06:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609F71F000E9;
 Mon,  6 Jul 2026 06:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783320222;
 bh=pn/v4mi91yPi1z8my42KU//6VlnVSyj7cZh1HgSNcRQ=;
 h=From:To:Cc:Subject:Date;
 b=K5YwCuI5rEz4Kx4rJTvU1KZ9KXelowowpw/QMeiDp3ZtAf8hJeJIXoQqQGrFM2Y5o
 Ud+wp1tsh/uT5ihDkkMMIr/ENChpxH/2j76Tix7c04MmzasDwNE90Ni+SrY6fALGER
 5PQNlX6cbByQPlNFWIYoorYQfHrDqF1naLWpq47vwTqJeBJcWgyMN5dFotYGaGoTsF
 7+plrwqOccuXRKQqB3AjzE5krhTTINGmrx00PCk1wNF6o1H4tDcsaNOrT3bzEqQzle
 UGYlF5OcyPHTdz3YRFoFujJlgIesJAC109AdOJReXvhJsrqku0Lxum/B7ZVHjGtEBh
 9AIos5rAH0qDg==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon,  6 Jul 2026 06:43:26 +0000
Message-ID: <20260706064326.3657995-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
MIME-Version: 1.0
X-Headers-End: 1wgd3Y-0002lC-GF
Subject: [f2fs-dev] [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs has supported to report fserror, this patch adds support for f2fs
in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.

Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 494725547..f51ad59f3 100644
--- a/common/rc
+++ b/common/rc
@@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
 		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
 		test -n "$x" && return 0
 		;;
+	f2fs)
+		x="$(cat /sys/fs/f2fs/features/fserror)"
+		test -n "$x" && return 0
 	esac
 
 	_notrun "$FSTYP does not support fanotify ioerrors"
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
