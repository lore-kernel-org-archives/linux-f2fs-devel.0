Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98224C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Apr 2023 17:40:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjOAL-0002tm-On;
	Mon, 03 Apr 2023 17:40:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pjOAJ-0002tg-UG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 17:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7GdSQ57moF1tLoMaTeH/9Tl+E0z3olnMcI1cs/jqnmQ=; b=D4hrO/Kpn5vOttdN3jWxiyjM4a
 hhtym8l18KPoZzYUOchETipcZGTYQfYOJu9sl0y8wmMhzZsdBf6DOD8CPKH2xAqa04+E+YVjV45hw
 dFX39v/8LArSP1s5OWbDph5M4vAyMwwCtTeJ94bYJEWxttocWhuy0qKAfRvnAQby+i4Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7GdSQ57moF1tLoMaTeH/9Tl+E0z3olnMcI1cs/jqnmQ=; b=knnUidY25+Jy9RehRAsRteBIDX
 yenNjfS+mCSuf7pVUKlV2y1y8WpCQP08ZodBMDN2cVXAxYxYKpL2teRmv9f1kEFEG9n1LB7TXcgG5
 QJhs6+GdClmD0EeNGqf46oxV0b3UpaNNYXsrXIeZGN9z8WHmjDyBD9+y2j4on5hOOU+A=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjOAI-0005kU-E4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 17:40:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 10A3B6235F;
 Mon,  3 Apr 2023 17:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E77DC433EF;
 Mon,  3 Apr 2023 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680543616;
 bh=RvPcLNdIyDQoHWqd1WZ9/rdoukI6sI7zASjdr3Ihk2Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gMAQTOerjuermXfBrC/PRjC1o/eT1qVBAuL3IBclx1JGM3/UeVgAexT6utNkuYsVE
 13MkAIeM6BoZc1G1wfwLrNg91L1MjVtPX+1HkRIme5yrQCconFwAdcHx5FLIPhJs3t
 j+HYQVS5pjFQ2JAMIAlbudvrDcUAjyCP7IhANPgbx9RbmQksnNYBTR4bV/BgbjhYVN
 G5f5yMxwxB+jCpNgfhHzmRWEVnDu+uEXlqaAL9t9lx5rzj24GWHnWapprQGQBA5oms
 YCRxsDrsls6qiCFqnIn2Skb/j6CGmNfL7Ivw2MZf2UBozsypWJ6U/BcxWerKUDKSF/
 0fanFX82y4xtw==
Date: Mon, 3 Apr 2023 10:40:14 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <ZCsPfukvFHhiI6vN@google.com>
References: <20230330173127.46900-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230330173127.46900-1-frank.li@vivo.com>
X-Headers-End: 1pjOAI-0005kU-E4
Subject: Re: [f2fs-dev] [PATCH] f2fs: support to show noage_extent_cache
 mount option
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

On 03/31, Yangtao Li wrote:
> This patch support noage_extent_cache mount option.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/filesystems/f2fs.rst | 2 ++
>  fs/f2fs/super.c                    | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index a81c896464ff..75505ab88de8 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -352,6 +352,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
>  			 data block update frequency of the extent per inode, in
>  			 order to provide better temperature hints for data block
>  			 allocation.
> +noage_extent_cache		 Disable an age extent cache based on rb-tree, see
> +			 the above age_extent_cache mount option.

Hmm, why do we need?

>  ======================== ============================================================
>  
>  Debugfs Entries
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b5828a67f7c1..8bd9953ea7e3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -165,6 +165,7 @@ enum {
>  	Opt_discard_unit,
>  	Opt_memory_mode,
>  	Opt_age_extent_cache,
> +	Opt_noage_extent_cache,
>  	Opt_err,
>  };
>  
> @@ -244,6 +245,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_discard_unit, "discard_unit=%s"},
>  	{Opt_memory_mode, "memory=%s"},
>  	{Opt_age_extent_cache, "age_extent_cache"},
> +	{Opt_noage_extent_cache, "noage_extent_cache"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -1269,6 +1271,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_age_extent_cache:
>  			set_opt(sbi, AGE_EXTENT_CACHE);
>  			break;
> +		case Opt_noage_extent_cache:
> +			clear_opt(sbi, AGE_EXTENT_CACHE);
> +			break;
>  		default:
>  			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>  				 p);
> @@ -1974,6 +1979,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",noextent_cache");
>  	if (test_opt(sbi, AGE_EXTENT_CACHE))
>  		seq_puts(seq, ",age_extent_cache");
> +	else
> +		seq_puts(seq, ",noage_extent_cache");
>  	if (test_opt(sbi, DATA_FLUSH))
>  		seq_puts(seq, ",data_flush");
>  
> -- 
> 2.35.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
