Return-Path: <SRS0=cknU=57=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD3C3815B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:44:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21472137B;
	Wed, 15 Apr 2020 11:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XfUaE77R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cN4GWQoh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAXJPPZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21472137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jOgSn-0003aW-HE; Wed, 15 Apr 2020 11:44:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1jOgSl-0003aP-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 11:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=al4bYb0YpHTjCg6Z8FzXwCeUddTDyjcfBp/aujCiZck=; b=XfUaE77RVXjPYM3w9T8W6/XIGb
 vpFlNoO5/Bw6ws8WyOOA7HyPW2YMFtoXtViAGy5m2PPW2tbBuMvsK+USGdXS2KW+bnR0Axzw6DuZU
 94xGxqbsTRyjZ0vDHsuWMIOnJDLCmezNFr/Wxq3XZeGRgOahngRQzUwN2iEMrPM3hhBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=al4bYb0YpHTjCg6Z8FzXwCeUddTDyjcfBp/aujCiZck=; b=cN4GWQoh2BjrOliy46jjTULjwr
 sokiMF/j9TlHMRXYh/prbXDIwmhtT0IvwbwXUQ42lDlHs2N3Ta5sqQ6P2TUiIqrro14ZtTF6hAMjY
 cPCxyRMSj8x1XVioFotundeFt4Q8tSK+IYeIkEg2U8g1cAjFyCpnTJbIq2bDOKkAvIQo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jOgSj-002YlQ-R2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Apr 2020 11:44:15 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2CAB20857;
 Wed, 15 Apr 2020 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586951048;
 bh=DrlZZnfpjcnq9LkIgSG2N2fWzqWh3eSaL4sYP7BdPj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RAXJPPZ3/PDWf/vmcqP00iKXgfC6HneK0mbd4RIVPlCuM+jnNHSeN9ZJ+O5wkQJi2
 C9LsyLneMUXcnlA9XA2To7EkggAc7Or4OFoQYxAh5d30fxvDwJSCMTHt+usaE+8kCn
 M7BqeXaDAs2xrV3wvxRGPiGtc1m+1epzzXj9ttz4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed, 15 Apr 2020 07:42:03 -0400
Message-Id: <20200415114226.13103-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1jOgSj-002YlQ-R2
Subject: [f2fs-dev] [PATCH AUTOSEL 5.5 083/106] f2fs: fix NULL pointer
 dereference in f2fs_write_begin()
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 62f63eea291b50a5677ae7503ac128803174698a ]

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:f2fs_write_begin+0x823/0xb90 [f2fs]
Call Trace:
 f2fs_quota_write+0x139/0x1d0 [f2fs]
 write_blk+0x36/0x80 [quota_tree]
 get_free_dqblk+0x42/0xa0 [quota_tree]
 do_insert_tree+0x235/0x4a0 [quota_tree]
 do_insert_tree+0x26e/0x4a0 [quota_tree]
 do_insert_tree+0x26e/0x4a0 [quota_tree]
 do_insert_tree+0x26e/0x4a0 [quota_tree]
 qtree_write_dquot+0x70/0x190 [quota_tree]
 v2_write_dquot+0x43/0x90 [quota_v2]
 dquot_acquire+0x77/0x100
 f2fs_dquot_acquire+0x2f/0x60 [f2fs]
 dqget+0x310/0x450
 dquot_transfer+0x7e/0x120
 f2fs_setattr+0x11a/0x4a0 [f2fs]
 notify_change+0x349/0x480
 chown_common+0x168/0x1c0
 do_fchownat+0xbc/0xf0
 __x64_sys_fchownat+0x20/0x30
 do_syscall_64+0x5f/0x220
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Passing fsdata parameter to .write_{begin,end} in f2fs_quota_write(),
so that if quota file is compressed one, we can avoid above NULL
pointer dereference when updating quota content.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b2f8b934d8fc5..0ed437dc53ecc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1826,6 +1826,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 	int offset = off & (sb->s_blocksize - 1);
 	size_t towrite = len;
 	struct page *page;
+	void *fsdata = NULL;
 	char *kaddr;
 	int err = 0;
 	int tocopy;
@@ -1835,7 +1836,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 								towrite);
 retry:
 		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
-							&page, NULL);
+							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
 				congestion_wait(BLK_RW_ASYNC, HZ/50);
@@ -1851,7 +1852,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 		flush_dcache_page(page);
 
 		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
-						page, NULL);
+						page, fsdata);
 		offset = 0;
 		towrite -= tocopy;
 		off += tocopy;
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
