Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB8C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Jan 2023 13:25:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pHPUb-0006HO-0a;
	Mon, 16 Jan 2023 13:25:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pHPUa-0006HE-DE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Jan 2023 13:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jtcVGe9FM3mo48SkhSpjKWmluIe8i3HnRRbl3ofR4l4=; b=GRBoFo3FumxIWzXJLkMIBwI9mo
 bsxa8BiZ/bi4pu9oi+iZTTmsneV/Qt7nV1tzE4w1HhSUgW+kOsmaze3Sseyd7UZSF85/g7NgxLCdY
 YPN611AucrWthfpTFvrS4HvanZd7jQvFvcHosAl+nQqrd9m2gYeYDStFJOtV6YNvNSjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jtcVGe9FM3mo48SkhSpjKWmluIe8i3HnRRbl3ofR4l4=; b=YfiW06YYC09tsmfZ7bZJfNr6VR
 Ivzk2Squv6foicR3AR0IOPlXFw1b/y7Sxs7fDIVluz3Diir0y9YdevgyzNQ8mabCWbvSXGGdxtq+w
 OsB0IkBFqHh55c1UZUwUUwYfmlzquKznRxV2cC5XxIP9vDzt6drovlbYqTgKOJhC8N2I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pHPUY-005iC3-CE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Jan 2023 13:25:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F35FF60F9B;
 Mon, 16 Jan 2023 13:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0746CC433D2;
 Mon, 16 Jan 2023 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673875532;
 bh=p01qBNFuoRosyJRMgusqGBN2al5abVi9iUdEfRMkO14=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=El6v5sqRwtmF5AicWZxXQXvxXFNVWhBLdadi3O+p9L9T3NzZJ9enyDpHtw5AncqfS
 s0sMG8tGLlHovcTti2XX6xbdaxFi8OtZx+UkCq/ru+MuWvw6DjzBdFLiRdvbS33JZA
 lAZYHQPR3RFsyXwHbFo9zfOwcsX+eDJ9CmtbOfwBY3iqDXfO6pvhwAVRStJTdS9BEH
 2rrobyJwrwMojSeVVyERZkHP5OP0Y6YB5nlH6woPMw1XvwERl9xvOQQMetq6o8tfhz
 7dQ3u4AUU/0EOw3ttjIHWP5eQamSp7agGKHh180Peh87hnkjmD7KbjzVa0Peug7n5M
 UOx4DKt46gQ3w==
Message-ID: <da57fbad-8242-eb1e-ab2b-322d61d0762d@kernel.org>
Date: Mon, 16 Jan 2023 21:25:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230116130210.34490-1-frank.li@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230116130210.34490-1-frank.li@vivo.com>
X-Headers-End: 1pHPUY-005iC3-CE
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix to avoid potential memory
 corruption in __update_iostat_latency()
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
Cc: kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/1/16 21:02, Yangtao Li wrote:
> Add iotype sanity check to avoid potential memory corruption.
> This is to fix the compile error below:
> 
> fs/f2fs/iostat.c:231 __update_iostat_latency() error: buffer overflow
> 'io_lat->peak_lat[type]' 3 <= 3
> 
> vim +228 fs/f2fs/iostat.c
> 
>    211  static inline void __update_iostat_latency(struct bio_iostat_ctx
> 	*iostat_ctx,
>    212					enum iostat_lat_type type)
>    213  {
>    214		unsigned long ts_diff;
>    215		unsigned int page_type = iostat_ctx->type;
>    216		struct f2fs_sb_info *sbi = iostat_ctx->sbi;
>    217		struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>    218		unsigned long flags;
>    219
>    220		if (!sbi->iostat_enable)
>    221			return;
>    222
>    223		ts_diff = jiffies - iostat_ctx->submit_ts;
>    224		if (page_type >= META_FLUSH)
>                                   ^^^^^^^^^^
> 
>    225			page_type = META;
>    226
>    227		spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   @228		io_lat->sum_lat[type][page_type] += ts_diff;
>                                        ^^^^^^^^^
> Mixup between META_FLUSH and NR_PAGE_TYPE leads to memory corruption.
> 
> Fixes: a4b6817625e7 ("f2fs: introduce periodic iostat io latency traces")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/iostat.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index ed8176939aa5..e9a3df7ce4d9 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -223,7 +223,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   		return;
>   
>   	ts_diff = jiffies - iostat_ctx->submit_ts;
> -	if (iotype >= META_FLUSH)
> +	if (iotype == META_FLUSH)

Maybe it's betterr to merge these two check condition as below?

if (iotype >= NR_PAGE_TYPE) {
	f2fs_bug_on(sbi, iotype != META_FLUSH);
	iotype = META;
}

For CHECK_FS is off case, I guess it's fine to not return and just print
warning message for notice.

Thanks,

>   		iotype = META;
>   
>   	if (rw == 0) {
> @@ -235,6 +235,11 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   			idx = WRITE_ASYNC_IO;
>   	}
>   
> +	if (iotype >= NR_PAGE_TYPE) {
> +		f2fs_bug_on(sbi, 1);
> +		return;
> +	}
> +
>   	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>   	io_lat->sum_lat[idx][iotype] += ts_diff;
>   	io_lat->bio_cnt[idx][iotype]++;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
