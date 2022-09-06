Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31D6ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Sep 2022 03:28:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oVPFo-0004o1-Bj;
	Tue, 06 Sep 2022 03:28:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oVPFn-0004nv-FV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 03:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vA/ZARNqvxOgJQkBGU8oLT9KX5DnXBtmKmH8be20pQA=; b=gOIODJqh8Jl5iHa76hrPWbs8vg
 JA1aYWZ72cYk40TsqUxodLLsYz3Pt/5B6UpGjRAeClQV+ITf1S5ia9vq4cmuqDjMYwtvwk9Zk42b9
 QlfRaBB+CWFjxy/KHZ+ed2qL2I+9FpCc9y6mSDeRxaH6DBMfSdTDcP/5bEHo/M/As4Jw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vA/ZARNqvxOgJQkBGU8oLT9KX5DnXBtmKmH8be20pQA=; b=YlwUZBBMYgdpIQRjck/KhkfEBP
 YtfpaWOiuDz036KIvNu7hDFW2ItAr7XLaCcMHJrfa/3lYGz+eJwtHDzdd8wBgRV2aXGomf1kPhPn1
 g8XRA54uBfRLHRHOO+7i+RXAEFio4BQFlLX+wgvXvq4pbfI08r23Hgrv+JH+hgySK4sE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oVPFm-00GtJJ-Uk for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 03:27:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 302C661242;
 Tue,  6 Sep 2022 03:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E662C43470;
 Tue,  6 Sep 2022 03:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662434866;
 bh=iPuAoo1l+jEO60ptqnFhfS9oJkta1xXjySBNeTmLs9w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O+8ojnot5q5B7FfmMG+9WChttGJKjLNiIa+NKQ//wAwsiKYEWyySVAerKPgmMWAHr
 AFWujTRReSDt56JJnqxMOXu8b0S+852TjD22cvy/QYRAgSu315S/ctrMfQ0dQYGNm3
 cY0dGRmCPfhV57xqGrrTCV3nRiTYvpgL5pCHVzmhZUtGK6F4Obsmwi86OY++1b9dXK
 qUfvGGce5bcUH3P2VD1VMzfgS0IgtuLbzTHdZ43eefrUrPgamza5dj7DRg2cKN/W/t
 /1Tp8V3IofH89uiuBjYLX2sMHwYMnfhgrhUPNo1dF4ZSEr/rWE2EOo6eHllJFC+mlZ
 SpNW3EQE2JvZA==
Message-ID: <52a9d745-1039-a596-95f1-98e1c35ab62e@kernel.org>
Date: Tue, 6 Sep 2022 11:27:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20220905045917.7520-1-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220905045917.7520-1-zhangqilong3@huawei.com>
X-Headers-End: 1oVPFm-00GtJJ-Uk
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: fix race condition on setting
 FI_NO_EXTENT flag
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

On 2022/9/5 12:59, Zhang Qilong wrote:
> The following scenarios exist.
> process A:               process B:
> ->f2fs_drop_extent_tree  ->f2fs_update_extent_cache_range
>                            ->f2fs_update_extent_tree_range
>                             ->write_lock
>   ->set_inode_flag
>                             ->is_inode_flag_set
>                             ->__free_extent_tree // Shouldn't
>                                                  // have been
>                                                  // cleaned up
>                                                  // here
>    ->write_lock
> 
> In this case, the "FI_NO_EXTENT" flag is set between
> f2fs_update_extent_tree_range and is_inode_flag_set
> by other process. it leads to clearing the whole exten
> tree which should not have happened. And we fix it by
> move the setting it to the range of write_lock.
> 
> Fixes:5f281fab9b9a3 ("f2fs: disable extent_cache for fcollapse/finsert inodes")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
