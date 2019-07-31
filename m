Return-Path: <SRS0=mgX/=V4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D4C32751
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:44:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F165F20659;
	Wed, 31 Jul 2019 20:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Zs8MyS4N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Yg5TlWkN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ygEk5xZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F165F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsvS9-0000rV-Fc; Wed, 31 Jul 2019 20:44:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hsvS7-0000rE-LF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jul 2019 20:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ghhxL9ZIP+IGtfy+lcLWAWto9CYpvXTQy6H6qffeDz0=; b=Zs8MyS4NdDe7muEXBWDzSUEynr
 5vFsxs8zZj0CsT6eRP6WMtVX1fI0wCDB74yVorSn9pSiHQN3YrLt1kch8/JuOFpi/jbrARC3qpQS2
 pR6QwwstzogWnE6R5Dx3WbuO+2xpbqOU2hB3HOYBFMKSZ1X9SfKUHOyt0CQG4wqN2lqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ghhxL9ZIP+IGtfy+lcLWAWto9CYpvXTQy6H6qffeDz0=; b=Y
 g5TlWkN7KkQU3+CVRsZ+GvxHzGWSSCBuVlVCeZw9CNqAIblCmNgIFIVuNzTJf+ViL49YfZcV87HvQ
 cIlJ1vNpfqFaMDhL0EfhMWVM8RReDsqr6w22QDokDwE8727FH487YVCAoC4inNB7OxeQLx+lS80ll
 ROPvddAisGPAoXn0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsvS5-005dXI-Cp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jul 2019 20:44:03 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BAA3E20659;
 Wed, 31 Jul 2019 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564605835;
 bh=gD9RpDnMmrZvN3MAeeKsnZtmfLwzp6SDLMO8X0spRww=;
 h=From:To:Cc:Subject:Date:From;
 b=ygEk5xZc0PN4SZE7yA22ZauWL7SJvnRQ4TD7y8IbtikMcsbXi0PSbbDhKFXf12TZ+
 hEZFRzDKr3k8pMnYMrJ4i2t8AvVSzRM59DAIbYfVGciA2ASktUnMiiUekc1OtS/LSV
 gPJ2b3H+r8P6t8VI1og/txOs7dPq60NFDRdqax8A=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 31 Jul 2019 13:43:53 -0700
Message-Id: <20190731204353.62056-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
X-Headers-End: 1hsvS5-005dXI-Cp
Subject: [f2fs-dev] [PATCH] f2fs: fix livelock in swapfile writes
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

This patch fixes livelock in the below call path when writing swap pages.

[46374.617256] c2    701  __switch_to+0xe4/0x100
[46374.617265] c2    701  __schedule+0x80c/0xbc4
[46374.617273] c2    701  schedule+0x74/0x98
[46374.617281] c2    701  rwsem_down_read_failed+0x190/0x234
[46374.617291] c2    701  down_read+0x58/0x5c
[46374.617300] c2    701  f2fs_map_blocks+0x138/0x9a8
[46374.617310] c2    701  get_data_block_dio_write+0x74/0x104
[46374.617320] c2    701  __blockdev_direct_IO+0x1350/0x3930
[46374.617331] c2    701  f2fs_direct_IO+0x55c/0x8bc
[46374.617341] c2    701  __swap_writepage+0x1d0/0x3e8
[46374.617351] c2    701  swap_writepage+0x44/0x54
[46374.617360] c2    701  shrink_page_list+0x140/0xe80
[46374.617371] c2    701  shrink_inactive_list+0x510/0x918
[46374.617381] c2    701  shrink_node_memcg+0x2d4/0x804
[46374.617391] c2    701  shrink_node+0x10c/0x2f8
[46374.617400] c2    701  do_try_to_free_pages+0x178/0x38c
[46374.617410] c2    701  try_to_free_pages+0x348/0x4b8
[46374.617419] c2    701  __alloc_pages_nodemask+0x7f8/0x1014
[46374.617429] c2    701  pagecache_get_page+0x184/0x2cc
[46374.617438] c2    701  f2fs_new_node_page+0x60/0x41c
[46374.617449] c2    701  f2fs_new_inode_page+0x50/0x7c
[46374.617460] c2    701  f2fs_init_inode_metadata+0x128/0x530
[46374.617472] c2    701  f2fs_add_inline_entry+0x138/0xd64
[46374.617480] c2    701  f2fs_do_add_link+0xf4/0x178
[46374.617488] c2    701  f2fs_create+0x1e4/0x3ac
[46374.617497] c2    701  path_openat+0xdc0/0x1308
[46374.617507] c2    701  do_filp_open+0x78/0x124
[46374.617516] c2    701  do_sys_open+0x134/0x248
[46374.617525] c2    701  SyS_openat+0x14/0x20

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index abbf14e9bd72..f49f243fd54f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1372,7 +1372,7 @@ static int get_data_block_dio_write(struct inode *inode, sector_t iblock,
 	return __get_data_block(inode, iblock, bh_result, create,
 				F2FS_GET_BLOCK_DIO, NULL,
 				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
-				true);
+				IS_SWAPFILE(inode) ? false : true);
 }
 
 static int get_data_block_dio(struct inode *inode, sector_t iblock,
-- 
2.19.0.605.g01d371f741-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
