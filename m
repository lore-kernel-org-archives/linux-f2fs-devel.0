Return-Path: <SRS0=HVTi=NL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0229C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Aug 2021 21:52:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EC961164;
	Fri, 20 Aug 2021 21:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69EC961164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mHCRd-0001Jt-PA; Fri, 20 Aug 2021 21:52:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mHCRc-0001Jf-R5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 21:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jMkrX+EkPAfOwn03xc5HKBSkn8HsQYk+7Z+wNJDMI7s=; b=MUhc7Pb97IVRHvv40z0DiOLm6W
 2/6L7CFlzkpDEY60oONeIt+tg3ZkNV6O/qMqE/0+zFLGRz6hLAfCAS1eNYvp59r52f1GHAJQDa1lt
 gi5oxoUpvF3eUvDzWwzAEmZg+9y7MbZy6zQNuir336C6BC+7dX4dg/GRFor7J6VdDeWc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jMkrX+EkPAfOwn03xc5HKBSkn8HsQYk+7Z+wNJDMI7s=; b=kPuYjv3J5ukDgEoZGemXCy1ADO
 EuGrTBvKiWTf+VcngkaXZsM6z210WmYQVjxR9HfED1Gos9x6kWjCEJr1v03O7EH5ZawX3BR+yqOyO
 PD9zb0feIJxOe6sKQmSiYx7PLfYBCq2mRc6QDRArVJg/1QrM/Qkpjzg93nICuY38nlf8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mHCRa-00DCK6-W8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 21:52:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9875661166;
 Fri, 20 Aug 2021 21:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629496369;
 bh=e7ifXtKt2aWf1y2xE7mHpd35Fe0gLKD3FzNWdBEnQpE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=iMSKHmPLIpFcrWMroqjdSqTwWskuliZl06qP2VZTaoN3ZpWasuLdE7Lh+FY+3fteV
 RcW+cmoIyV+xXcauyJe3IQ0SPxvgs71jIevhfssJawv7vbZ7LTTl3z51s/tOBOL+rf
 V145OPRFH4DviXV7ra+aTU0ElOw2DiywEDhYB5xne4kWblP529L6Jpyc0LAzVAOR9h
 XMqIIOVLNPncXsmXMTUyPdVD8noT/gb1N4qoLHzCwoQ3nB27FBbgB8A0All+nqLO3C
 L1FkPUQbieLqdlvIlXa9y/b8FMKwcJPcrj7csscZhSUEJdQn4lsRpQhyQjYk/inFbq
 RsiQd5m8NpChA==
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210820035229.216975-1-daeho43@gmail.com>
 <20210820035229.216975-2-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <71203c35-4a9d-c43f-c74c-16a90bb5ff71@kernel.org>
Date: Sat, 21 Aug 2021 05:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820035229.216975-2-daeho43@gmail.com>
Content-Language: en-US
X-Headers-End: 1mHCRa-00DCK6-W8
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: introduce periodic iostat io
 latency traces
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/20 11:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Whenever we notice some sluggish issues on our machines, we are always
> curious about how well all types of I/O in the f2fs filesystem are
> handled. But, it's hard to get this kind of real data. First of all,
> we need to reproduce the issue while turning on the profiling tool like
> blktrace, but the issue doesn't happen again easily. Second, with the
> intervention of any tools, the overall timing of the issue will be
> slightly changed and it sometimes makes us hard to figure it out.
> 
> So, I added the feature printing out IO latency statistics tracepoint
> events, which are minimal things to understand filesystem's I/O related
> behaviors, into F2FS_IOSTAT kernel config. With "iostat_enable" sysfs
> node on, we can get this statistics info in a periodic way and it
> would cause the least overhead.
> 
> [samples]
>   f2fs_ckpt-254:1-507     [003] ....  2842.439683: f2fs_iostat_latency:
> dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> rd_data [136/1/801], rd_node [136/1/1704], rd_meta [4/2/4],
> wr_sync_data [164/16/3331], wr_sync_node [152/3/648],
> wr_sync_meta [160/2/4243], wr_async_data [24/13/15],
> wr_async_node [0/0/0], wr_async_meta [0/0/0]
> 
>   f2fs_ckpt-254:1-507     [002] ....  2845.450514: f2fs_iostat_latency:
> dev = (254,11), iotype [peak lat.(ms)/avg lat.(ms)/count],
> rd_data [60/3/456], rd_node [60/3/1258], rd_meta [0/0/1],
> wr_sync_data [120/12/2285], wr_sync_node [88/5/428],
> wr_sync_meta [52/6/2990], wr_async_data [4/1/3],
> wr_async_node [0/0/0], wr_async_meta [0/0/0]
> 
> ---
> v4: separate the previous patch into two patches
> v3: moved other I/O statistics related features into a separate file
>      with the same kernel config option for better maintenance.
> v2: clean up with wrappers and fix a build breakage reported by
>      kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

It needs to move Signed-off-by tag to the front of change log section,
otherwise it will be missed during applying.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
