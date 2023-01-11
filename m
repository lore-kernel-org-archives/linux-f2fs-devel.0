Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DAC54EBC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 01:21:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFPnn-0002KH-Nf;
	Wed, 11 Jan 2023 01:21:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pFPnm-0002KB-DO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 01:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gDtdAQC8MAdFjg/qyjDmWq/IUkUCOidOvwXAvbj1kBk=; b=dyRsNgeGc+lSWzpmcX73hsoQq8
 oXDGtbNueEZPabh5XEqD1NZ0tY3k3jeD/1Isn63osc710G/xFWT42lka2/DUZvlSOx2UjOhGn4a6U
 6eOFmmXi/o1P459/HHVgKgxSsYnK9477RGw95ilP1AJxysHGBiLeKifs64rPy0U+110w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gDtdAQC8MAdFjg/qyjDmWq/IUkUCOidOvwXAvbj1kBk=; b=XzjMxr/xNvRIVdvj2uoF2S/KBA
 xyxsiZLlZZ+YDK0NaLv5snbHqe/4PkRYCOsIslGD8w+rrM5HkYakhbEPn3ZRepypZEZNWFF1VExnY
 83DJQ+4GBPvlpIIPe7rO6mLD9276/2PRBMoQKQDQpvM6ckE6ruaTJlH8ZsianvKfLazs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFPnh-00DROh-Ec for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 01:21:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 51757B810D8;
 Wed, 11 Jan 2023 01:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89D3C433D2;
 Wed, 11 Jan 2023 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673400061;
 bh=L2t71BZAowgZYZQjAiJUgHg5t13KDoB6HhVsNJIeyNY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L7JoI+MkIawQAMHxRrqPYTlHdXS1ivbHKTc5leT23+JiDvlMHtU4+kbetF/XDoZ3z
 wHx5z2mXt4kHennZKTdPXPoxDtc2Uqe4JeAU8XLPa0CthVH+S5GpUCwdgEB9QoorPX
 gKJ3wmfaUNzFZSLa2WvsJHhrThj9XXONmQ/dl4aoP/ImabSfQZRRdMumsDnNq8oyR+
 beVufNdFQgK3Ga94ViB6iQl1o9szq3b4GlJGNclfXC/pQYLJeYmEXGT3MeTL/B8mDr
 A+Wlrlw3J6mRTvf+Bdpbii9rvDMaGl1DwkT4T2HYhEOpLyHiZv0AREGs7qOQ/pxu0I
 AGH9ODalRgAIQ==
Date: Tue, 10 Jan 2023 17:20:59 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <Y74O+5SklijYqMU1@google.com>
References: <20230105233908.1030651-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230105233908.1030651-1-jaegeuk@kernel.org>
X-Headers-End: 1pFPnh-00DROh-Ec
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: retry to update the inode page
 given EIO
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
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_update_inode_page, f2fs_get_node_page handles EIO along with
f2fs_handle_page_eio that stops checkpoint, if the disk couldn't be recovered.
As a result, we don't need to stop checkpoint right away given single EIO.

Cc: stable@vger.kernel.org
Signed-off-by: Randall Huang <huangrandall@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - fix a bug

 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ff6cf66ed46b..2ed7a621fdf1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -719,7 +719,7 @@ void f2fs_update_inode_page(struct inode *inode)
 	if (IS_ERR(node_page)) {
 		int err = PTR_ERR(node_page);
 
-		if (err == -ENOMEM) {
+		if (err == -ENOMEM || (err == -EIO && !f2fs_cp_error(sbi))) {
 			cond_resched();
 			goto retry;
 		} else if (err != -ENOENT) {
-- 
2.39.0.314.g84b9a713c41-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
