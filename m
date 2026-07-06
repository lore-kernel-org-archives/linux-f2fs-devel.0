Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8B0C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEHcXKOYDaE/fii8Ap8gEQN2pXMKMxZylscM5BGIdZ4=; b=TZq7fTO8cYmyEnFrMx0A64mb6r
	2VCrF3RJ5AR9ZOz84PSjjMz6Muv7liA+b2dj8ZsRcwzdTgHlelmr7+/qlxqOpneFayDjnd9H5DRGk
	bKwtLARv8/7sjhQIJuVkBnv51bxXvuHdZDyrvCwpCAlvoYBoHJJer7Z6kwMAiio3HKQs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgg7o-0000sv-E6;
	Mon, 06 Jul 2026 10:00:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wgg7U-0000rS-NG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 10:00:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wf7Dq7ZqF+IRc2k6+6jGgcdA/x5diupooyaJLVZLXnc=; b=KcmAlorU8nGVhbdHWvaFCsMEvO
 Tu+JacsyLVeNYqS0gV99M1NREUA7bF17PBPQzSQKiZRQT6U4voC+pqBecfySw5O/1v/fF3TiGuX8D
 n6ziMkW4YZTZSuoUYYqQGufA83UxF/OJSAiPqPQNu/XkdPNP/Y0Q37rqSiLHbcIdZ9X0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wf7Dq7ZqF+IRc2k6+6jGgcdA/x5diupooyaJLVZLXnc=; b=cfwp3FdOvyY6mmGSYWZOHw+6GR
 Adh6CNA/F8DmfAexY6BFWdvcu63fRCJ86o8592YydmXQhs3FyC0DFcTfHLPYjAB2XVUrwBNnMoCpt
 ATZ1YMDPjm1DzpZAc+jMItTYJiE8aWz+zmZ5RZsuCfnnR8oJsYBZcOFgMkLvlJaY+rTk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgg7Q-0005d4-4k for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 10:00:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03E18600C3;
 Mon,  6 Jul 2026 09:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8744D1F000E9;
 Mon,  6 Jul 2026 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783331993;
 bh=wf7Dq7ZqF+IRc2k6+6jGgcdA/x5diupooyaJLVZLXnc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PatjLqz2mTLY0lljSlcPYbNFfrh2RdF0MTVmVLFGoXRxdAwgaImraeFlJvzrNpxKh
 gSCZ5CNu/krOBa+tRAeuWOQfeRvhei+7sqImPwzIoRJSdpfr1RP5mVN9HVkx3vi8Ji
 UAMfLdwdTFKoRQJK7tN+lf8z2rJNiApaPZz01qDr1WzKj01Q+a9z9Ny37KoZ70sJ9t
 5wcH9pxuRdtJypH/hzZ9ySn3U/6hXCSmhkDz81VeOUuX0ZGuwRIZmuEXVyoYMvBl0z
 d+nXjnJhm5CjO0pjUYXqRe2lXcrzFESYid+5mTGnTdg4AHbOGx7riXqwaw4IX1B3qH
 XhWiBayIgwtgQ==
To: jaegeuk@kernel.org
Date: Mon,  6 Jul 2026 17:59:43 +0800
Message-ID: <20260706095943.2560208-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706095943.2560208-1-chao@kernel.org>
References: <20260706095943.2560208-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wgg7Q-0005d4-4k
Subject: [f2fs-dev] [PATCH 2/2] f2fs: quota: use memalloc_nofs_{save,
 restore} instead of FGP_NOFS
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

FGP_NOFS could be removed later, let's use memalloc_nofs_{save,restore}
instead, which is recommended to be used to avoid potential deadlock
when memory allocation in f2fs_quota_write() will call into filesystem
interface again, e.g. .writepages, evict_inode, shrinker due to
complicated lock race condition.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/super.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac1cf4de3d62..be4c1d4ed6b2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3994,7 +3994,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Will wait that below with our IO control.
 	 */
 	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_NOFS,
+				FGP_LOCK | FGP_WRITE | FGP_CREAT,
 				mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fdfd6a7203dd..d28a93657658 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3215,13 +3215,16 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	void *fsdata = NULL;
 	int err = 0;
 	int tocopy;
+	unsigned int nofs_flags;
 
 	while (towrite > 0) {
 		tocopy = min_t(unsigned long, sb->s_blocksize - offset,
 								towrite);
 retry:
+		nofs_flags = memalloc_nofs_save();
 		err = a_ops->write_begin(NULL, mapping, off, tocopy,
 							&folio, &fsdata);
+		memalloc_nofs_restore(nofs_flags);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
 				memalloc_retry_wait(GFP_NOFS);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
