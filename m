Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F02C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 May 2023 01:24:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1zi1-0000wk-Fr;
	Thu, 25 May 2023 01:24:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q1zhz-0000we-W4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 01:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=779goaQO7oyxnnWcDoG86zPiSYHZlXbmhFm0roclWVM=; b=dsYHSycnArCMAzTtUdA9TowDvc
 5E19PIw0GbTY23g+Sq7BCsdaz+y9JGFMk2Z1K+fQoe65ThRcGOQstzRN/HQFOkFd4xVC51o10wsyj
 T70mM0h2ENHJHvjp+GAIHvQ8Od2u1LYMmZMm9AzABz1sH4jbjNeAAsyN43DCAVSYmQoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=779goaQO7oyxnnWcDoG86zPiSYHZlXbmhFm0roclWVM=; b=YUT+aNbSES5NLlLSuyLAooLMTs
 1PRoxxdgp6JLHep9cNfbPzY2w/bwd152E7C680Cn+pQ01wK6Cd3RC26hhzd+zR+k9i26Fmgejmh/R
 totSX5SEmwBuh5pPxGrQMc/bXaSLY2GZ1xYezF0VxDRYxmGZds4cMKWLGRwIsFqyQ188=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1zhy-001oW6-Id for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 May 2023 01:24:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2E16C63627;
 Thu, 25 May 2023 01:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A493AC433EF;
 Thu, 25 May 2023 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684977836;
 bh=OHg9DeZfOhV4V5vB9rYTi3BHagEQpsmCOnLIFMVIhsE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MULPruLRZ6/JS3zG1tVhqJebxg2rZx3watmCfhkpkNA7UqAIJpS3oZYxPiAYZfzL/
 47hkj/pkJ0PvMUm/SEuZJe2Ao3jojqE/Gi2fhZNhzjcJu0nQZyOe14odV/O3wfd+Qz
 zo2+lnENMM5F6yKeD9c2iWcPrrM3TTCbL7dZtZuF7xEYaIbhQW367fD2iIiVKnx9AT
 JeWRAWqo5TJ2th9kUV2imnWJtL1OMf+SxCt4Dft6ichiPWukEpWb8nDaqCSiz5fCm4
 yZ958HtP9BDEuFqwDG5vLH3NySEnRtrSIIJZiFADTc0V2bYfN49+8rM3DgyPMWg3ki
 zW2yXJkYSZJmQ==
Message-ID: <1876098e-939d-7dda-ee96-34dfd5a5b4b6@kernel.org>
Date: Thu, 25 May 2023 09:23:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20230524024204.13694-1-guochunhai@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230524024204.13694-1-guochunhai@vivo.com>
X-Headers-End: 1q1zhy-001oW6-Id
Subject: Re: [f2fs-dev] [PATCH v8] fsck.f2fs: Detect and fix looped node
 chain efficiently
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
Cc: linux-f2fs-devel@lists.sourceforge.net, frank.li@vivo.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/24 10:42, Chunhai Guo wrote:
> find_fsync_inode() detect the looped node chain by comparing the loop
> counter with free blocks. While it may take tens of seconds to quit when
> the free blocks are large enough. We can use Floyd's cycle detection
> algorithm to make the detection more efficient, and fix the issue by
> filling a NULL address in the last node of the chain.
> 
> Below is the log we encounter on a 256GB UFS storage and it takes about
> 25 seconds to detect looped node chain. After changing the algorithm, it
> takes about 20ms to finish the same job.
> 
>      [   10.822904] fsck.f2fs: Info: version timestamp cur: 17, prev: 430
>      [   10.822949] fsck.f2fs: [update_superblock: 762] Info: Done to
> update superblock
>      [   10.822953] fsck.f2fs: Info: superblock features = 1499 :
> encrypt verity extra_attr project_quota quota_ino casefold
>      [   10.822956] fsck.f2fs: Info: superblock encrypt level = 0, salt =
> 00000000000000000000000000000000
>      [   10.822960] fsck.f2fs: Info: total FS sectors = 59249811 (231444
> MB)
>      [   35.852827] fsck.f2fs:	detect looped node chain,
> blkaddr:1114802, next:1114803
>      [   35.852842] fsck.f2fs: [f2fs_do_mount:3846] record_fsync_data
> failed
>      [   35.856106] fsck.f2fs: fsck.f2fs terminated by exit(255)
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
