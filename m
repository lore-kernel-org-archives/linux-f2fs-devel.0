Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D1EB7EB2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHCQ29jXtjjFApVamk+WTwW3ietyxIE5CvESbm7X6T0=; b=AqD56CQnW58GuEQL7RxT4d74ZN
	I6AMxXKxD+5DcA94oN+kgRgLdD2pm8rSDjDOW36mNxE3wMdx4ir7taOEfN2HuLoEUXKBwe0GEtj3O
	YTCPQyOXqyvySwCXZo/+iGRhlGt0v3AQcnfs1d/kECxMks03F5RNHFSHOjUMg76/qopw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxiJs-0008Q6-Gu;
	Wed, 04 Mar 2026 09:15:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vxiJr-0008PH-8i
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 09:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0vxGBpxEUqFfrnWqtqj+lCWR8ZGsUjkg3jhv/DbhZ1w=; b=bYkbHc7zV7FN7EUysDgzQy8xjW
 6ijsoTxZ1ohden+obMTaRniVBXz7B51zluaXXwoYvo5QXkbrfowbufCxpcHbSIEDLBjtNw7ptUxjY
 ohdvWmyOrW4BRfaF2rPASdI+2h3rJNBtwO3uipxvKC6yRfcFrF4cWcAU0JjgIBo8UTvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0vxGBpxEUqFfrnWqtqj+lCWR8ZGsUjkg3jhv/DbhZ1w=; b=jFKYwTGmjjLMkAomEAzs85kZ0/
 810UkjrLlmSvrXIXZigMMhIKi0x/onBHhJ9ZdDuwTAO4gdG2b/KpQvJc3yUIj1Ul0JO51Kp9Gc6a1
 gobuF5cW7Sq2THljG9R+6kUXYztKTyOJiv4K2ZLPwiktl9jz/N/Fh0U6eYtM/yEs4MWg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxiJo-0006qg-Iw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 09:15:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BF2A408AC;
 Wed,  4 Mar 2026 09:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3571C2BC87;
 Wed,  4 Mar 2026 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772615695;
 bh=6otz9s28fFtepjsE/Io5UmhuIPxV7e5S+OhsPvLvnkE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=aks1YqfhWJdB49Tu1L0GlIPVSd8kAYoNhYzneK10zYcUsvoNats9iZDlxfEWEY3zF
 mQ2TWnP4kmbGGYTz0++m7+m1jG+0VYqIRIiItOCx4Vm47Th+ptl5euvHViv3qvDwLI
 DmM55uWiXwZI3D0W5p+sDK8WI0ZrbV6Xr8Xg2Snch268BpajTny3+eQK3PmmCvLF02
 9fbawoH2hdOAtIRi+lv4UaI/OF+k83RkE39/95goimgtPk3OmdEZwGoGoJzEP6c6hs
 WK0PACHrsixnwwwq5WGoAjYASgdwA3/VYqxYfKAvEChp001tg2Qw8nArQMejAJmpCt
 bgw3uwN7nQYLw==
Message-ID: <a77cebcf-5e9b-41a9-8c4f-f7feae63e61e@kernel.org>
Date: Wed, 4 Mar 2026 17:14:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260203133635.3942502-2-monty_pavel@sina.com>
 <20260203133635.3942502-4-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260203133635.3942502-4-monty_pavel@sina.com>
X-Headers-End: 1vxiJo-0006qg-Iw
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: fix incorrect file address mapping
 when inline inode is unwritten
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/2/3 21:36, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When `fileinfo->fi_flags` does not have the `FIEMAP_FLAG_SYNC` bit set
> and inline data has not been persisted yet, the physical address of the
> extent is calculated incorrectly for unwritten inline inodes.
> 
> root@vm:/mnt/f2fs# dd if=/dev/zero of=data.3k bs=3k count=1
> root@vm:/mnt/f2fs# f2fs_io fiemap 0 100 data.3k
> Fiemap: offset = 0 len = 100
> 	logical addr.    physical addr.   length           flags
> 0	0000000000000000 00000ffffffff16c 0000000000000c00 00000301
> 
> This patch fixes the issue by checking if the inode's address is valid.
> If the inline inode is unwritten, set the physical address to 0 and
> mark the extent with `FIEMAP_EXTENT_UNKNOWN | FIEMAP_EXTENT_DELALLOC`
> flags.
> 

Cc: stable@kernel.org

> Fixes: 67f8cf3cee6f ("f2fs: support fiemap for inline_data")
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
