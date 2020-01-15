Return-Path: <SRS0=YOv7=3E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14DDC32771
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:40:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FB4222C3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kC5qW3TA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="FzCakW+g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3+FghMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FB4222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1irqOi-00028A-Dv; Wed, 15 Jan 2020 21:40:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1irqOh-000283-A3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 21:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ibrXP7gq/tBSIb20EPhZ4/bnGj4Osg0RaF+wRy6c/8M=; b=kC5qW3TA9Kfz7nfHl7PW3p30jT
 lDaw7BAVxn0LVVGd/4adHlDhvHKpYS4Zo+QrpuNDfioUtT+oju8HTgcDweKMvv7Stm9U9BBeUdXsN
 kTsC+dKv7ZKSImBlil2BDjWprUp1lxhAXEO09TQASpx+qZGkrBb3NdcaqP4C1jJz1yAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ibrXP7gq/tBSIb20EPhZ4/bnGj4Osg0RaF+wRy6c/8M=; b=FzCakW+ggPdb1yjdkATcrbxrr1
 B7CSM8C2uR30Jd+580+XO/9CAiIZvweqkDZN+8jj28WTrz2tRfXTqkhV+2SjWmOUEab3wkDat4f42
 2oJDaeNuTtJv3OZ2lPstNIaoXOHndb3fgj2Dlmi7jmWiMIkC84I/2bVqJrlErV1d2eV8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1irqOd-008B0N-Nu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 21:40:19 +0000
Received: from localhost (unknown [104.132.0.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20716222C3;
 Wed, 15 Jan 2020 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579124410;
 bh=abqmjt7XeAUImGyuahFybucRYFCSbTgZtlR1Pzp1dsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S3+FghMGM+cljd+Cs0s/QuUmk6mTmIDzpXnoncfYVrDB2ZyfIit0d94MmRWvmx4Rk
 EudI9yCarLjUKtaafI9xskzh+PZ0HOmppTPdB5eNvKKUDoqWaQU/0u7DFQVsS4AunG
 heluFnopqMAXrFHSBTrBsoPT6lBqWC+qujWVz6h4=
Date: Wed, 15 Jan 2020 13:40:09 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Message-ID: <20200115214009.GB57854@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200115015424.41496-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200115015424.41496-1-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1irqOd-008B0N-Nu
Subject: Re: [f2fs-dev] [PATCH] f2fs: Make f2fs_verify_pages static
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

I applied this in the original patch.

Thanks,

On 01/15, Zhang Xiaoxu wrote:
> Fix sparse warning:
> 
> fs/f2fs/data.c:187:6: warning:
>   symbol 'f2fs_verify_pages' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2576d7dd047d..b27b72107911 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -184,7 +184,7 @@ static void f2fs_decompress_work(struct bio_post_read_ctx *ctx)
>  }
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
> +static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
>  {
>  	f2fs_decompress_end_io(rpages, cluster_size, false, true);
>  }
> -- 
> 2.17.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
