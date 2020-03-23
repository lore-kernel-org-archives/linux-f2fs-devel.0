Return-Path: <SRS0=IH0A=5I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E02C4332E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:42:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830EE2070A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hC6fhkkv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WOPEmTCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830EE2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGKXA-0001Tb-3Z; Mon, 23 Mar 2020 10:42:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <joe@perches.com>) id 1jGKX8-0001TK-NC
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 10:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CVg2Sx9rAstC32JJ2NrvxjHMCdgYOTJ42VH9vrIERqQ=; b=hC6fhkkvyIVyU1+YiAX5JEl30c
 Nrs4Rn2Fknv2W78V96ysP5Fw+rKIDR1tGJbaLxZVvjQZIXW8qmqCE/+9LzsCwVUQxl5wcPn7IdQgd
 5L/E+SrTjV+e9NuBsRxaxUsVy59DZXkXPmKd5+6m4ljjrPrsTiYUQb87WTRezWrtOrSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CVg2Sx9rAstC32JJ2NrvxjHMCdgYOTJ42VH9vrIERqQ=; b=WOPEmTCMH96mZyis/veaXxs/iz
 JSrECKOHycA674mhAAuCBsAnCEplBxRkO86PNSRPWlZ81UB/yRM03AAz7SaHnaunbLJD1SCEZfhTF
 lqH8xOYakCJipP/XFB4NNtsn/3qGDmxrAjSZyyOqKzR4FiR4Vo76efxmY8LCzcyNFjDc=;
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]
 helo=smtprelay.hostedemail.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGKX7-000lM3-3g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 10:42:14 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1FBD8100E7B47;
 Mon, 23 Mar 2020 10:42:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot70_125bc865c5d12
X-Filterd-Recvd-Size: 1557
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Mon, 23 Mar 2020 10:42:06 +0000 (UTC)
Message-ID: <afa74570dacebb3b93d4b9c27d6c8a87186cef2d.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Date: Mon, 23 Mar 2020 03:40:16 -0700
In-Reply-To: <20200323031807.94473-1-yuchao0@huawei.com>
References: <20200323031807.94473-1-yuchao0@huawei.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Headers-End: 1jGKX7-000lM3-3g
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: fix potential .flags overflow on
 32bit architecture
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

On Mon, 2020-03-23 at 11:18 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
[]
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
[]
> @@ -362,7 +362,7 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_flags = le32_to_cpu(ri->i_flags);
>  	if (S_ISREG(inode->i_mode))
>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
> -	fi->flags = 0;
> +	bitmap_zero(fi->flags, BITS_TO_LONGS(FI_MAX));

Sorry, I misled you here, this should be

	bitmap_zero(fi->flags, FI_MAX);




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
