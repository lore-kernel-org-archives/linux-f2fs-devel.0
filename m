Return-Path: <SRS0=Iay9=LP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C06C48BE5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Jun 2021 06:50:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16423600D3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Jun 2021 06:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16423600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lvDkx-0001tF-Hv; Mon, 21 Jun 2021 06:50:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <changfengnan@vivo.com>) id 1lvDkv-0001t7-Oi
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Jun 2021 06:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OuAOxgTVHKnOpwYgL38aQz0h9zwk2n1M1z6Zz/b9lXM=; b=TRzLVs9HkaVGr3t99gBHoi+6Vz
 AZL45X/6zzT2UbUpN1vtDKwaq2m4yUbfFi02mMyg1FQ/UtxUlaD84VhxWxOXpWPNEbXHlQwAXWiaE
 FQmRP9jwF8rN4oYRpxbOp3eWoE89xPwD+ePiJr8IE08xW33unEJqeNqJWynWh+G+vYLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OuAOxgTVHKnOpwYgL38aQz0h9zwk2n1M1z6Zz/b9lXM=; b=DRlkz0c7sJGerCA++/C6hYznfu
 RexoEa+slT5r5mFgUNOhbZ66hPL1xy3tDD2V/fFzR97Q9Uf9SLcgd3kvbMVeUhWKq3TBHtxGFqzSQ
 MUhk3GQAmcw4g7Keb4dAbiKhpVFsQUc1CMKEzk/JBAquX0gtCMWz8oBoG24H/J7OU41o=;
Received: from mail-m121144.qiye.163.com ([115.236.121.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lvDks-003vC8-3k
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Jun 2021 06:50:05 +0000
DKIM-Signature: a=rsa-sha256;
 b=mWMrv9gWoIYHQ4IN20T+mQzeFJaa/b6cozu3GHaRe6eCgAfEeabW7N6q9yVZTlu9ssTdIxAa949yHXDsd0wl6b3UVduCJhOGpx4TRUZQjj+wvhiIad72ZBfTpqqGBnUuLkmvdxK5wMTivFZ/mLh/Mvuojo3M9lz9VhazqiygwO8=;
 c=relaxed/relaxed; s=default; d=vivo.com; v=1;
 bh=OuAOxgTVHKnOpwYgL38aQz0h9zwk2n1M1z6Zz/b9lXM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.25.44.145] (unknown [58.251.74.232])
 by mail-m121144.qiye.163.com (Hmail) with ESMTPA id C8452AC03E1;
 Mon, 21 Jun 2021 14:49:49 +0800 (CST)
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20210610032845.84744-1-changfengnan@vivo.com>
From: Fengnan Chang <changfengnan@vivo.com>
Message-ID: <47d96770-1b86-9af4-89e3-387f67037bb0@vivo.com>
Date: Mon, 21 Jun 2021 14:49:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610032845.84744-1-changfengnan@vivo.com>
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGUMfTlZPGU5PTB4eSBlMGExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6Hzo*PT9RPjkcNSoQT0MU
 KRoaCw1VSlVKTUlPSU5DSkJLTkpPVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WU5DVUlOSlVMT1VJSElZV1kIAVlBSUxITjcG
X-HM-Tid: 0a7a2d551b7ab039kuuuc8452ac03e1
X-Headers-End: 1lvDks-003vC8-3k
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: remove unneeded read when
 rewrite whole cluster
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi chao & jaegeuk:
   Any comments about this?

Thanks.

On 2021/6/10 11:28, Fengnan Chang wrote:
> For now, when overwrite compressed file, we need read old data to page
> cache first and update pages.
> But when we need overwrite whole cluster, we don't need old data
> anymore.
> So, remove read data process in this case, I have made
> some simple changes to test, tests have shown that this can lead to
> significant performance improvements, the speed of sequential write
> up to 2x.
> 
> This modificy just check wheather the whole page was dirty, because
> when writeback cache f2fs_prepare_compress_overwrite will be called again.
> when update whole cluster, cc in prepare_compress_overwrite will be
> empty, so will not read old data.
> when only update one page in cluster,  cc in prepae_compress_overwrite
> will not be empty, so will read old data.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/data.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d4795eda12fa..9376c62e0ecc 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3307,6 +3307,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> 
>   		*fsdata = NULL;
> 
> +		if (len == PAGE_SIZE)
> +			goto repeat;
> +
>   		ret = f2fs_prepare_compress_overwrite(inode, pagep,
>   							index, fsdata);
>   		if (ret < 0) {
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
