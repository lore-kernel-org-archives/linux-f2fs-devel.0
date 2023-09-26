Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F25E7E656
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 Sep 2023 17:41:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qlC3T-0001PR-Ar;
	Tue, 26 Sep 2023 17:41:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qlC3S-0001P8-6W
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 Sep 2023 17:41:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vs5a9axwAb1t1BthqXwpxjGzVJW4lzDCcpHepD1Sef0=; b=U820IiI+PwdZkHQEOc+oK8+nRv
 qCWZo0gdnQoQnjKUsc70aguzGe1/gIGVDU3oZlp9qFqPkMm+x4RMRPomVHIiUkZP9cBVzA27gU/1Q
 +chf7x68U+g8xUrJufW57lBC9cmuA/I8dSTw5/lnuzH83OHx77QFzEnrOKujYYfzqZcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vs5a9axwAb1t1BthqXwpxjGzVJW4lzDCcpHepD1Sef0=; b=UILMCyoggQaXCWqfo7UJiZR+tB
 9k6f7LyG73yR/dgP8ERevebtuqXxK+lYJRmKhHR6R0BewV9UKWs3zNbYJkN4PpLPuCS5fSYpjpx0l
 XT9+G+Vey8S2/Vv0Zwh6dJMqRkeVos7iWXS4RD7SLIhfkYYUXba0z0YnHCBGrwIsGjBY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qlC3Q-0004BG-7Z for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 Sep 2023 17:41:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D9AEE6148D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 26 Sep 2023 17:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668C9C433C8;
 Tue, 26 Sep 2023 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695750054;
 bh=qFXQCm4wpcI+yE6fWi21khMp5yp/w8GEwvQJeve1l4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QZqrKXQ/29eH0ORwoNR/vO2H3ERnP5dsLMynI8cR7r+gTzuLcsmsy7IZ9wpHf4XbU
 oQ2pdsG+FlHra08pFeMLIv9TtF/pwkpfodsVCrJ3eQDTUgv34dDdAGe27af+etrrVx
 +JvN/rnMKtWyDzHNmgwPT6KbghH+d2Wp9g4Tf6wXd8pIkpM3N2lZM0eHpcvwe0A6vs
 PWp17ammmMcGK3hHt8hfQJE8rWRMTeO6EzjBkUD10DmdSg2qeyTDaclZgmsKMVJTwT
 dMhjd21cdkuFqrsQAEj+VMWPXQGKxIy+V4Hev3PX6TbwAfd8iMpz5FqJSNYJOwmgHS
 5k0HxdNT47OLQ==
Date: Tue, 26 Sep 2023 10:40:52 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <ZRMXpLyT7OcQ/jYf@google.com>
References: <20230920004645.1462354-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230920004645.1462354-1-jaegeuk@kernel.org>
X-Headers-End: 1qlC3Q-0004BG-7Z
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: preload extent_cache for
 POSIX_FADV_WILLNEED
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
Cc: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
more useful for generic usecases.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - load it at offset=0 once to avoid reloading for all the calls

 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 09716127e107..161826c6e200 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4858,6 +4858,9 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 		filp->f_mode &= ~FMODE_RANDOM;
 		spin_unlock(&filp->f_lock);
 		return 0;
+	} else if (advice == POSIX_FADV_WILLNEED && offset == 0) {
+		/* Load extent cache at the first readahead. */
+		f2fs_precache_extents(inode);
 	}
 
 	err = generic_fadvise(filp, offset, len, advice);
-- 
2.42.0.515.g380fc7ccd1-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
