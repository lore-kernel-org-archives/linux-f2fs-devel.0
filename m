Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B14FC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jun 2023 20:37:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6dQN-0005uC-8w;
	Tue, 06 Jun 2023 20:37:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1q6dQI-0005ty-Sm
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 20:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bZlwSCjTyONyM6BfdlEEszOvDKo4//CkyOFwKo/Rm5w=; b=SPi1C1SXZ/2Pimf6nAEtd72UbO
 f4qoxGPHWrmlpr2C8S+G9//48bmQrohZ0oB/Gf6s69VqMKye1uXTi9Y8vuM6g+uv8kqhcUFYFaFNk
 v1TfxgXzjY1YQ1HeAV3nS1B9KzfCYv4n5g5uYLu4qvJw7L5wBeerlEQYny/pfbdB4oKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bZlwSCjTyONyM6BfdlEEszOvDKo4//CkyOFwKo/Rm5w=; b=D
 hZNTkHmNEK+meBcK7p6dL5m9efRPC1W84GA/rxVFI3lgdpDgH81rXNkBey5717FgV/2ISXIHZed4x
 ArwlBBjED98O7BSPHaGXNOAYtT3brUmgt8fudGApEHLRuHdIB+lq2uHo1NaQ7pNmEtKYaTqQpq8x1
 netBx3fLJGvjvM+8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6dQE-00D3Rm-Q5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 20:36:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6386563802
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Jun 2023 20:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A6C433D2;
 Tue,  6 Jun 2023 20:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686083808;
 bh=0cYUz6iSpj0eGwIL3jk2KHuInnAfLbouhLwJjaUDn/U=;
 h=From:To:Cc:Subject:Date:From;
 b=grmxwQPihJZONINOr57RH3NFIbNisnRHwKJOkoK1+XFzKQ9/U8SF/YIRWEKwBCVNK
 KYuGs7WfGbxp9X+IqWMqiRBsXKGhAO8uFUzWX3sZ79ppoEH9pypErF1/wXxfbWF9mf
 gqQtV/VZE143HcdJwoHokLSMb8ZmUjZnzSy1ZhINqnH0NxOPgDLhoOkX5NpI4mIkKZ
 WccMw5QkjpTROKGyDNqBMXYB8OX7Qu1IcNssR3BVROAaCW3RiFWUf8QUWczS1fgUz2
 xZVBmhQnXAKOOWJpg/vys8Jl4FlzELW6Hfr+i7wPT4BGjk/mjIoAM59IEXZFknDB1B
 Y2QAwpiuFRmig==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  6 Jun 2023 13:36:45 -0700
Message-ID: <20230606203645.3926651-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
X-Headers-End: 1q6dQE-00D3Rm-Q5
Subject: [f2fs-dev] [PATCH] f2fs: compress tmp files given extension
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

Let's compress tmp files for the given extension list.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3e35eb7dbb8f..cdc94c8e60f7 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -161,7 +161,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 
 	/* Compress wanting extension. */
 	for (i = 0; i < ext_cnt; i++) {
-		if (is_extension_exist(name, ext[i], false)) {
+		if (is_extension_exist(name, ext[i], true)) {
 			set_compress_context(inode);
 			return;
 		}
-- 
2.41.0.rc0.172.g3f132b7071-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
