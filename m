Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72712C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Dec 2023 18:05:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rADK5-0007cy-Rd;
	Mon, 04 Dec 2023 18:05:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rADK0-0007ce-QF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 18:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HG1CNJnpPUlkDrsPt6amTonclUxN4+/BtlTyq8ecSeU=; b=PO6vMO8kjKgZP9yQCTKxz1rmP7
 1fxSYNQpPyHZ/jsYOAn4wfFnh/CTkL4m66HYU/wC2yfQKaHdBUx447sKEz5/7EOeK0oEyl2gF76nS
 26pAoViWt2q2cH31aVyPk/6fZDnV2UjKj3bSFU9zdwh8N4fv3kVyIGsEBA7SUUTBwm40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HG1CNJnpPUlkDrsPt6amTonclUxN4+/BtlTyq8ecSeU=; b=Z1sEA5sNrgW571uzxEgjvcNZCc
 tnwWmxKtru2Kuatv6TmVD6fs1C4/496ef5hYXdp3Qu6AECGRkMHu7nJRvovnSf8Om7zr2ZZzzFvfb
 NumCjgpmy8aXkFXT/lbczRagpkg+wThyrsGZgIiKiFFVJfMGmMshdHTpJmcL5rx6Gw0E=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rADJl-0003Tx-Ng for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 18:05:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 93233CE1275
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  4 Dec 2023 18:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FCCC433C7;
 Mon,  4 Dec 2023 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701713071;
 bh=5uILUttJEnB7yuvoHAjCIDDFlCw2Yu+1VyECoAyrkIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Px+gBEtB5gOIxbUSaHIJWKJfoWuoWSWnf7cNY1RJkYdRobSfs0sVl4iE/qxgEtBeC
 5EkByepKhfdqd782afxg8sn7qQ9SgjZqXqgTD1CmLpXx5NyNMIINjUeXi16A6M1Qud
 S2t0nAjbzFCinfGqKkxBKhqXqWMKZfmG0lBUkIl+zn7TK5Y0kddtUEukKPNSgRDwu1
 C1XqibzWN3PfcchsBmRftLKw51hSZMR8IwVhMNlSjq0l++nP9xOGm3IMwqrI8j9dj4
 Y1htIwkHuZKcIZToWAm1OTPtzVntKrS5hS1ol1m/eIpqrBo8bnZUXlfmCty/tS+wVj
 E1rYcTfM4OFBQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  4 Dec 2023 10:04:26 -0800
Message-ID: <20231204180428.925779-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rADJl-0003Tx-Ng
Subject: [f2fs-dev] [PATCH 2/4] f2fs: fix write pointers on zoned device
 after roll forward
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

1. do roll forward recovery
2. update current segments pointers
3. fix the entire zones' write pointers
4. do checkpoint

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 16415c770b45..d0f24ccbd1ac 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -917,6 +917,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
