Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421DDC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Nov 2022 01:25:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ov7Am-0003FW-0X;
	Wed, 16 Nov 2022 01:25:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ov7Ai-0003FH-LH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Nov 2022 01:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uObwcigWyI9e5svPkDtNm5erCKo7LhmTD8YqkbONJoQ=; b=DGxGKQN46Wfyoa8IfN4sw8cxaW
 Rrv7h1gHkAcYOmA+Ar86f7fMtSRBfpU7a0qsS7ZdecR0j8q8trlwOrzw281GDugJ3sNLZqv6JC5RR
 5YVhwiLqL7na9BM6nKtSqlHsNXuqHgkAy75A4U3TENYJc45bVwV0rapA6sTQSx8bXP9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uObwcigWyI9e5svPkDtNm5erCKo7LhmTD8YqkbONJoQ=; b=PS79prBw+4mA2pak1LeYLYiZvu
 EaspFP/y5vYscVBNwAAvjnu4bk4R+bO8H0YLgi5zvL5BolONsiShMhOhaP2pfkTklcQnGNZ6aJ6As
 up5BOo8kHZG2bztRbdD5m9jxGYsDt88WhVViMbPpfunX+QoSFvRVfXWvkxLp+vXLU8xY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ov7Ae-0004iX-Cs for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Nov 2022 01:25:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 308146183D;
 Wed, 16 Nov 2022 01:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B3C433D7;
 Wed, 16 Nov 2022 01:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668561889;
 bh=MgQLyJjEwp91nkw7N6At0JhNUZwGU5DTWpxITP/24nI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ggGYdR+vcWC78/sHFejkAazCokpo+jIqKifySSr45rHTKE6vc2P3MuusVWB2iPorB
 eOe6PuxvBaxYu/J1wDGclc3F2fJtilUAfRndgfylQR/6ufvUDFWooR0E03d5jh/ilI
 JzUGIkUdApXokXx5kXx513PpwcHbQCRRPQAAr9QGgkIQP2BFP4n9OajT2E9FgU7thJ
 PuTSa7hF929ZtR9YZhJHe7dXxG+BqC4rt7SF9YsyM2bnWB4hTD/8LOCtOJy+HWQXPF
 UHp+x+IAbMNywoJ8fWv6zG9ZCFYtqYXd6vGIZigQN45tZfwPqyWAQqsRKVRMdVQrKt
 0/r3QBCdocEVw==
Message-ID: <0b0ca95a-108b-d77b-9669-b298ccec6e53@kernel.org>
Date: Wed, 16 Nov 2022 09:24:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20221115084655.84191-1-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221115084655.84191-1-zhangqilong3@huawei.com>
X-Headers-End: 1ov7Ae-0004iX-Cs
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix error log cluster size warning in
 sanity_check_inode()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/15 16:46, Zhang Qilong wrote:
> Mounting f2fs with following issue:
> sanity_check_inode: inode (ino=4827) has unsupported log cluster size: 0, run fsck to fix
> 
> ->find_fsync_dnodes
>   ->add_fsync_inode
>    ->f2fs_iget_retry
>     ->f2fs_iget
>      ->do_read_inode
>       ->sanity_check_inode
> 
> It is triggered when entering recovery mode after a system crash.
> The root cause is 'i_log_cluster_size' is zero in f2fs inode with
> F2FS_COMPR_FL flag. It will resulted in mounting failed, and the
> filesystem need to be fscked.

fsync on compressed inode will trigger checkpoint, so f2fs_recover_inode_page()
will never process compressed inode?

Thanks,

> 
> We fix it by adding copying compresion information to f2fs inode
> page when recover inode page in f2fs_recover_inode_page().
> 
> Cc: stable@vger.kernel.org
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   fs/f2fs/node.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 83cc8a9e4982..2c4031ed71c9 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2799,6 +2799,14 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>   			dst->i_crtime = src->i_crtime;
>   			dst->i_crtime_nsec = src->i_crtime_nsec;
>   		}
> +		if (f2fs_sb_has_compression(sbi) &&
> +			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
> +						i_log_cluster_size)) {
> +			dst->i_compr_blocks = src->i_compr_blocks;
> +			dst->i_compress_algorithm = src->i_compress_algorithm;
> +			dst->i_log_cluster_size = src->i_log_cluster_size;
> +			dst->i_compress_flag = src->i_compress_flag;
> +		}
>   	}
>   
>   	new_ni = old_ni;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
