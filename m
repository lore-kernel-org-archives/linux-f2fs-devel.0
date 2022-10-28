Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF052ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Oct 2022 16:59:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ooShU-0007Tz-Su;
	Fri, 28 Oct 2022 16:59:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ooShT-0007Tg-CH
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 16:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sos/Jbs68PxbmXrcG0ILszE9VSR6mFNiPe0LEmH2jlA=; b=EHjczm0XMDvlCqU5lT9ywQTdNd
 xJQNRfE+Vx7HJ2R7V+JjZplO3+qovM8bBFvO+Uhl+nEgfsn4naAYhBOM9d3KrK+R18ULpWxgzxTZC
 sY3WKPBwu0rB6HgrcoiDHb506KgMwGM3zAaZgOmW9aS8bt+RPqleeZmBATB1geF79Ffg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sos/Jbs68PxbmXrcG0ILszE9VSR6mFNiPe0LEmH2jlA=; b=D2G6m+vSfsE6Gk17itnW6ZZlCk
 UvkarDBdwHiTN5itlAGaR9Sl7iYzebhqaRdIk4a3dACCgCRxDHDPxWKtMU6BbYKfNO1UGBQNN/Vom
 pXccJAk2cQ65/DSbXD+LMVT6hqvHAPRFzHD5eEeLb3Rd3yds1lHZOqLmR/cbsJSvV9uM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ooShS-003dt2-HV for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 16:59:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2371B629B3;
 Fri, 28 Oct 2022 16:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D63C433C1;
 Fri, 28 Oct 2022 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666976352;
 bh=/M2mrINHIA7P8HhyfSe/oGbwQhTLhA4oDq7xRt+Q2+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X23/rnsUUJLgNKoChlEbr7A0oe2azCDzIAaQElWoHKsaEiwbv+atCnERO4INTR4Bw
 QiiUjACAUg9WB5dZ5RLrzdHtieFbrcZ2o5ZcZx8KLJnXc01zks/sMLofw/JHTvnQyH
 Lg3aqDsuUzbpkfXZ0aSIfo3i8OZhl2iDCi/XlD2Wt8BReavQveT6MyetmWUR7GrD/f
 mrtPB0X4flPUzDTgHZGy0JA7SaRXbyIpqC4o0KYO6Zwxj7GfdG2m20k68n0l337CR3
 F7Ssey37tLAxi2JXAGXJLUq0HVU523Xtb/PEWLOKJBv7d1SnHEkgShMMSjerHh9PhY
 PBr9HQcfXDwcA==
Date: Fri, 28 Oct 2022 09:59:11 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y1wKXwLqse/kB6A9@google.com>
References: <20221025033217.14840-1-frank.li@vivo.com>
 <20221025033217.14840-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221025033217.14840-2-frank.li@vivo.com>
X-Headers-End: 1ooShS-003dt2-HV
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce gc_mode sysfs node
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

Hi,

I merged two patches and modified a bit. Please take a look.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=28ea9479410bab555db26e8437ea61b180e768d6

On 10/25, Yangtao Li wrote:
> gc_mode sysfs node can show the current gc_mode as a string.
> Introducing it increases readability.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>  fs/f2fs/f2fs.h                          |  1 +
>  fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 483639fb727b..6466f3b1f0a9 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -634,3 +634,9 @@ Date:		July 2022
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
>  Description:	Show the accumulated total revoked atomic write block count after boot.
>  		If you write "0" here, you can initialize to "0".
> +
> +What:		/sys/fs/f2fs/<disk>/gc_mode
> +Date:		October 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Show the current gc_mode as a string.
> +		This is a read-only entry.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6355a5683b7..80f23e44a442 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1318,6 +1318,7 @@ enum {
>  	MAX_TIME,
>  };
>  
> +/* Note that you need to keep synchronization with this gc_mode_names array */
>  enum {
>  	GC_NORMAL,
>  	GC_IDLE_CB,
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 49898a7243ba..058857d8b3b9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -41,6 +41,16 @@ enum {
>  	ATGC_INFO,	/* struct atgc_management */
>  };
>  
> +static const char *gc_mode_names[MAX_GC_MODE] = {
> +		"GC_NORMAL",
> +		"GC_IDLE_CB",
> +		"GC_IDLE_GREEDY",
> +		"GC_IDLE_AT",
> +		"GC_URGENT_HIGH",
> +		"GC_URGENT_LOW",
> +		"GC_URGENT_MID"
> +};
> +
>  struct f2fs_attr {
>  	struct attribute attr;
>  	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
> @@ -133,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>  				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>  }
>  
> +static ssize_t gc_mode_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
> +}
> +
>  static ssize_t features_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -823,6 +839,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
>  F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>  F2FS_GENERAL_RO_ATTR(main_blkaddr);
>  F2FS_GENERAL_RO_ATTR(pending_discard);
> +F2FS_GENERAL_RO_ATTR(gc_mode);
>  #ifdef CONFIG_F2FS_STAT_FS
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -904,6 +921,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(max_discard_issue_time),
>  	ATTR_LIST(discard_granularity),
>  	ATTR_LIST(pending_discard),
> +	ATTR_LIST(gc_mode),
>  	ATTR_LIST(batched_trim_sections),
>  	ATTR_LIST(ipu_policy),
>  	ATTR_LIST(min_ipu_util),
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
