Return-Path: <SRS0=2O7d=FO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA8C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:24:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00B522D02
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00B522D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1knPgM-00017y-3x; Thu, 10 Dec 2020 17:24:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1knPfs-00014Z-8V
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 17:24:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GM0x6O9rnXlhaRTH0SsGDYvtyN/Dkji68YscZDyajhs=; b=ZXSgWD5VPlz341txW/Ek03cDOi
 Mper1Lvuo+/KjJY7aBpZWGGFxI6+Ck1ZQ2wzobPSkESzEkmQT8YiJCxqiyu0tXoiShXFeZbbE5gJI
 Er0FTe3BRwtnQH4or6gqRzvdjUu9im5kPjVPfKnrLsn9Pc4v2O4JgTsO7CDl+g6lvsy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GM0x6O9rnXlhaRTH0SsGDYvtyN/Dkji68YscZDyajhs=; b=Q227axn/15PC5BhQZOi0veiSuG
 bA2n1vXvd9icI4rbp3BqSTJd8gh4HGCMSrDfZjDPKOqPpA05N9Phzi58EOuwp81iOt8N2IblvTLQE
 D9NPZngvEyoex/4yczNKyCOFYlmHuma5oXX1+RLHa1NQQ1lR2d5cRemuirj5fWkmdHiI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1knPfc-006lAG-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 17:24:15 +0000
Date: Thu, 10 Dec 2020 09:23:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607621025;
 bh=OMwkssHcKty+vlzemDTI48/lgSqmwlzZ/YXqxVTg4bA=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=taTDBWeFKykbXbevMBubrEKPlSoLeWeAy3gTI1wXDOgHRSw02CTTfmreMrSKKKi2w
 itbIWalYWUD6ayXJiBwBC+Qf3U+pjwVy1D28G/XlADxnj22qyXjJmfhobC71TMaGr1
 B8gGkWbJkv8W2d/Q/GnDyBYy1tMdpCT99kREMtu43WMLbcsf30HYdAJ8Qp4NijoCby
 vzYhDq/BX4NmAM5To7eLNx6WztTpd/FzkPyEOiv308Ym3mqPlpK45j5MuRphVxIkIC
 Nxye89qKSYKsY817ugNm/v4b4buNvh/AjqjReSFBvVplgxelDohHSiCv4yxLFU2rV3
 KaecdzufOC2bQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <X9JZn2ELSZISEQpU@google.com>
References: <20201210092020.66245-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201210092020.66245-1-yuchao0@huawei.com>
X-Headers-End: 1knPfc-006lAG-UQ
Subject: Re: [f2fs-dev] [PATCH RFC] f2fs: compress: add compress_flag in
 struct f2fs_comp_option
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

On 12/10, Chao Yu wrote:
> Add a extra field compress_flag to get/set more compress option from/to
> compressed inode.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> 
> Daeho, Jaegeuk,
> 
> Could you please check whether we could add this new field to struct
> f2fs_comp_option? so we can expand to allow user to query/config more
> options of compressed inode via new ioctl.
> 
> It needs to consider before original patches goes to merge window, let
> me know you have other concerns.

Chao, I think it'd hard to add this at time point, unless there's critical
info that we need to set very urgently.

> 
>  fs/f2fs/file.c            | 1 +
>  include/uapi/linux/f2fs.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 16ea10f2bcf5..fbf06311c88d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3965,6 +3965,7 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
>  
>  	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
>  	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
> +	option.compress_flag = F2FS_I(inode)->i_compress_flag;
>  
>  	inode_unlock_shared(inode);
>  
> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
> index 352a822d4370..2b9c4c99ceee 100644
> --- a/include/uapi/linux/f2fs.h
> +++ b/include/uapi/linux/f2fs.h
> @@ -93,6 +93,7 @@ struct f2fs_sectrim_range {
>  struct f2fs_comp_option {
>  	__u8 algorithm;
>  	__u8 log_cluster_size;
> +	__u16 compress_flag;
>  };
>  
>  #endif /* _UAPI_LINUX_F2FS_H */
> -- 
> 2.29.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
