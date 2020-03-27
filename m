Return-Path: <SRS0=MQND=5M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F03C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Mar 2020 19:32:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B0E20575
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Mar 2020 19:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aOiF+rKd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ByArXSG6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIdX+zVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B0E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHuif-0005ps-LI; Fri, 27 Mar 2020 19:32:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jHuie-0005pf-FL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Mar 2020 19:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HMMyirqvp+PVUVaPvmDMQ4oNIOCk9gieu2P+uqNYyg=; b=aOiF+rKd/916xsChMdVBMAkeuG
 R5dcRglI4bjV22wethYIxkftSLgj2Z1Px5tLW38E2NHkTT0qUKBDjMK4VnG/Abm3E5S+geQeDeGoT
 xmNi5VESAPmtiiFs/L5jA06IleCCCpzzadS9/l4ZPGsgw8O/L/+sjsPU6JypLNMfdYSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/HMMyirqvp+PVUVaPvmDMQ4oNIOCk9gieu2P+uqNYyg=; b=ByArXSG6kURSFFByhm+oeDzmeh
 b1kxAri5z2Iey1EhpwsPJPlq5YxTkV0t59Iy/5isyn+SAM8qqXswE20DSV+iYquWuKUHVpO3+wYov
 sIhXHBShSijl663T1P0e6TMDBTDubVRtGLOIdfb3/t94yGsJyiwcLv922R/rF/J7CmJQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jHuid-003Fte-AE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Mar 2020 19:32:40 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F43F20575;
 Fri, 27 Mar 2020 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585337553;
 bh=wWoAjZwt2nR5X1UPX0ZZp4acCT8N6K2BluWge4uJRGQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZIdX+zVLGrFZGp9dBUOVypptkgXVWdke59yk8jKqMZpdpClIGzxKm2WW990B2Xq3w
 Ycgwyu0RSSByNv0YKGZ2hWNga+DXU4+PwFWzck9gYDldbJWpDsfE1qHVMH/JkWe4Ha
 IniH6OY7izr4MJGs8sp2auOMJRfD+eAD4WKlRqOI=
Date: Fri, 27 Mar 2020 12:32:33 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200327193233.GB186975@google.com>
References: <20200327102953.104035-1-yuchao0@huawei.com>
 <20200327102953.104035-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327102953.104035-3-yuchao0@huawei.com>
X-Headers-End: 1jHuid-003Fte-AE
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix to check
 f2fs_compressed_file() in f2fs_bmap()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/27, Chao Yu wrote:
> Otherwise, for compressed inode, returned physical block address
> may be wrong.

We can use bmap to check the allocated (non)compressed blocks.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 24643680489b..f22f3ba10a48 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3591,6 +3591,8 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>  
>  	if (f2fs_has_inline_data(inode))
>  		return 0;
> +	if (f2fs_compressed_file(inode))
> +		return 0;
>  
>  	/* make sure allocating whole blocks */
>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> -- 
> 2.18.0.rc1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
