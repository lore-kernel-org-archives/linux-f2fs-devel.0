Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B114D1A427
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 12 Oct 2024 02:43:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1szS5s-0003OZ-P6;
	Sat, 12 Oct 2024 02:43:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1szS5r-0003OQ-HL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Oct 2024 02:42:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TeNHcigzR2oq4HaIiAeDRvL1Q5Etu/+8tXt1iNh5soI=; b=TW/UJLZl9hfznVb3k4Eh5oO/W4
 jTdTWLeWGjBL104AiusVYzbL7HudRIt5KFtegxQ+H/OBc/7+nMStHra7w5pOHKa1/fAuFyKR70WpV
 nEIDmttfq4Lzp3JAk2mKAxNKrtnj+vWsbH/P/CevCwwnOH74XcQfLasWIc3oilD/lclE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TeNHcigzR2oq4HaIiAeDRvL1Q5Etu/+8tXt1iNh5soI=; b=dhcuNtbyz166eqXc+ucMZVC57m
 DvdvkVpXKTwXhwbQ7/o8C9385pQUZ3I9NsNbDVkmLhGVJaPyuBsZ2+Fka/1aeHtgP4xQfleT3v3AY
 sqVaRK+xclmA1g1FK+8R5kGBFwvRKlQf74irNYImZbUrJucKWlowyyk4YH1hLu22abyI=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1szS5q-000343-8P for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Oct 2024 02:42:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D1222A43309;
 Sat, 12 Oct 2024 02:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5228C4CEC3;
 Sat, 12 Oct 2024 02:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728700972;
 bh=RLEiaGtYnac6iCX6YR/4UajVQiUmwCqXjMwt4XIFwvc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=PLXC7fRFdDaVXaBdnxSaV+RYffrIakbMmtz6kNdxO/mD9fI6WCod3jhIIinNAPDDl
 XKmp4WN3WUCvwEYjE0MBDrnoUon/xu037rx4lbLx0UXNGKgh842s/rAWX4KTtHqKqQ
 ckeaUH6ybsAskP0M3bXChrJZSTNpy++Nbt3gbcWRbuxZjYIQbRvfxkcrpao87aeHTy
 NdF6ZYE833keQ4Upuo3Iv1eZFlFZ8hRX7LjL7djidnjwWUKzwCSbcreENLWxO8v0nc
 DgyqDE5hiEG9C1AAxYqdgc/8BfsqMJ0YZ2hOQN4hsc95jEb/QH/caAVdGQMH/cK2Ws
 bWfAsLHsMisXQ==
Message-ID: <64487878-21fb-4679-ac1c-ce24c02a3e64@kernel.org>
Date: Sat, 12 Oct 2024 10:42:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ye Bin <yebin@huaweicloud.com>, jaegeuk@kernel.org
References: <20241011164450.3366215-1-yebin@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20241011164450.3366215-1-yebin@huaweicloud.com>
X-Headers-End: 1szS5q-000343-8P
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null-ptr-deref in
 f2fs_submit_page_bio()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: zhangxiaoxu5@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/12 0:44, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows when concurrently installing the f2fs.ko
> module and mounting the f2fs file system:
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> RIP: 0010:__bio_alloc+0x2fb/0x6c0 [f2fs]
> Call Trace:
>   <TASK>
>   f2fs_submit_page_bio+0x126/0x8b0 [f2fs]
>   __get_meta_page+0x1d4/0x920 [f2fs]
>   get_checkpoint_version.constprop.0+0x2b/0x3c0 [f2fs]
>   validate_checkpoint+0xac/0x290 [f2fs]
>   f2fs_get_valid_checkpoint+0x207/0x950 [f2fs]
>   f2fs_fill_super+0x1007/0x39b0 [f2fs]
>   mount_bdev+0x183/0x250
>   legacy_get_tree+0xf4/0x1e0
>   vfs_get_tree+0x88/0x340
>   do_new_mount+0x283/0x5e0
>   path_mount+0x2b2/0x15b0
>   __x64_sys_mount+0x1fe/0x270
>   do_syscall_64+0x5f/0x170
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Above issue happens as the biset of the f2fs file system is not
> initialized before register "f2fs_fs_type".
> To address above issue just register "f2fs_fs_type" at the last in
> init_f2fs_fs(). Ensure that all f2fs file system resources are
> initialized.
> 
> Fixes: f543805fcd60 ("f2fs: introduce private bioset")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
