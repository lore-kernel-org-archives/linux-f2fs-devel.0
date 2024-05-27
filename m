Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04D6C25B78
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 May 2024 16:06:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sBzLb-0003tY-Ag;
	Tue, 28 May 2024 16:06:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sBzLZ-0003tO-8n
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCxT5L6JSXe2UV9jfQqCsj2TLcP4b0wXa4ucf3o6RzY=; b=N0s55UbC2szYiTt7PWzPuK25PM
 3CAWJTt666U/bKuzA6EWqlpKlTqk5IQdYYgTha3E/Go38aBz1+7UGS//mKL8IdDzS7svX4qUnH7AR
 breTE5wbHvt6vwFh8n3vfjm/8PWPqI6oBmrAvIW5Q9pynFFyGDrv6h1K7fvGbSx6JUTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZCxT5L6JSXe2UV9jfQqCsj2TLcP4b0wXa4ucf3o6RzY=; b=GbRVQKnuvtuZPLhh5EQA58d4vW
 cUea4Bkp/YX3uP2uLBJOdVot2aFMPm4iDV0tD5En75dzryPu9QGZTAe/ARM0u02MJymHi0Ig0r53c
 QrwOtizWWWoTiIgZWEG67zlFBv6XwY5C97g3V1nXZe2nP4551QLoq/iE+BhVAEQS32Fs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sBzLZ-0003zR-Ly for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:06:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B8EE760C12;
 Mon, 27 May 2024 03:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51419C2BBFC;
 Mon, 27 May 2024 03:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716781753;
 bh=1roAnXoBpmfOOOh02YvPm+SdLLwFEfO7YksTC91triA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U/ST8/4yylKhLjgKzkNG/1idVDlnSQjdKf3hMftU6u3hkmLp6IynYgeoWIPIHexsS
 PqniFw1wqP2gm4lKPn8VkrwcLbjgqfHGhgbw0VBy9Xhdy288jKmaBJvsjHZbACae9t
 ujQ8S5x643S0t4sqxNRRnkk/kE0Omb7aEtypSd8rqiZQEvT1GBWxbXK13v6LthwsvC
 Wi3rH4igYS7eXlkXpYS6PC29I1AF5OgktwPmDtr8kZhp4mwT+qqUX7zZj9K7S3yZFW
 LqDxUZf0YZ+Ol4AE8+EnKyLyxO+whGpx212VpUzFg4PcRBJMdocPHylV7TztZqBO/9
 dUJv/2Y+t0OMw==
Message-ID: <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org>
Date: Mon, 27 May 2024 11:49:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1sBzLZ-0003zR-Ly
Subject: Re: [f2fs-dev] [PATCH] f2fs: enable atgc if atgc_age_threshold from
 user is less than elapsed_time
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/5/20 19:36, Zhiguo Niu wrote:
> Now atgc can be enabled based on the following conditions:
> -ATGC mount option is set
> -elapsed_time is more than atgc_age_threshold already
> but these conditions are check when umounted->mounted device again.
> If the device has not be umounted->mounted for a long time, atgc can
> not work even the above conditions met.

Zhiguo, I didn't get it, can you please explain more about this issue?

Thanks,

> 
> It is better to enable atgc dynamiclly when user change atgc_age_threshold
> meanwhile this vale is less than elapsed_time and ATGC mount option is on.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/f2fs.h    |  1 +
>   fs/f2fs/segment.c |  9 ++++-----
>   fs/f2fs/sysfs.c   | 16 ++++++++++++++++
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1974b6a..e441d2d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
>   int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>   					unsigned int start, unsigned int end);
>   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 71dc8042..44923d4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
>   	return ret;
>   }
>   
> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>   {
>   	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
>   	int ret = 0;
>   
> -	if (!sbi->am.atgc_enabled)
> -		return 0;
> -
>   	f2fs_down_read(&SM_I(sbi)->curseg_lock);
>   
>   	mutex_lock(&curseg->curseg_mutex);
> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>   }
>   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
>   {
> -	return __f2fs_init_atgc_curseg(sbi);
> +	if (!sbi->am.atgc_enabled)
> +		return 0;
> +	return f2fs_init_atgc_curseg(sbi);
>   }
>   
>   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 09d3ecf..72676c5 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> +		if (t < 0)
> +			return -EINVAL;
> +		sbi->am.age_threshold = t;
> +		if (sbi->am.atgc_enabled)
> +			return count;
> +
> +		if (test_opt(sbi, ATGC) &&
> +			le64_to_cpu(sbi->ckpt->elapsed_time) >= t) {
> +			if (f2fs_init_atgc_curseg(sbi))
> +				return -EINVAL;
> +			sbi->am.atgc_enabled = true;
> +		}
> +		return count;
> +	}
> +
>   	if (!strcmp(a->attr.name, "gc_segment_mode")) {
>   		if (t < MAX_GC_MODE)
>   			sbi->gc_segment_mode = t;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
