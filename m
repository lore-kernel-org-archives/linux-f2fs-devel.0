Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0E6C61DC6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mrFjfQ3WFli8SDpHLX/mHbIxWxsZ8ArW1oB9lzVNgJc=; b=CmuT5ygjPLBO4nwSwPLzAlltKg
	Ex9ncIxpdP6hJO+TihLOHF+/1YML294dOSq6wNJNCYZ+vf7LzSlUSt//O6Xfq9cNKrnxHZzM/lpaz
	DQ8N0T3Du4/cvZz8IJeSxJgsmJwpQ0xbQyJKudOxpa7/qwmukTFzes37R6bDg/xEamZY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzOeN-0003d6-Cx;
	Thu, 27 Aug 2026 01:11:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzOeL-0003cp-Nw
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 01:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lQswqUI+tP5tEP71AnJT+zozOIMpYQqzkqDzCyPqMsc=; b=AlFiWqLrMqZg/dd5HpIlT1/kX0
 vI9pRoZxCk+BlXp6vHUjtnzKvW0xYSGbPTvCBqJ5d3ImIwlzojtsf3e03ZCYpcn6qylK2028G9JH8
 VZC9SBt2vOc/0/ACRr7QtTHCO7QrOCk/Z+VVS/IPY2eZeD1xkUCY5Hg2UMM89tn1TNRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lQswqUI+tP5tEP71AnJT+zozOIMpYQqzkqDzCyPqMsc=; b=SV6S2g8NIJW5EqQg+hcx80501x
 obU35LPWMKcHH4lNIAFOSM/hrnQN0i/ktC0bYi5f1P9pxvIr+vD7K9CUfdqnH6a2QIR8L18yEIoK5
 aIMUFfgQnC/aQGuWa0JRrXpxpFKZwaByle2kK6vll7jfDeqroo1H9oG5pPNoeDT5sQsY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzOeL-0002ho-N8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 01:11:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03EA760A5C;
 Thu, 27 Aug 2026 01:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A397A1F000E9;
 Thu, 27 Aug 2026 01:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787793079;
 bh=lQswqUI+tP5tEP71AnJT+zozOIMpYQqzkqDzCyPqMsc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=f6ksFcHYPUbZh1Tn9sUqGDmgITrLAh7zksSAf6NFfijFKWiusWXqMK8IYlwlvjSB7
 w3Ddvm24Xxn08GrbnN4RdAWNT7S6SNT70VO2YVrpxKtVADOsbBIJhtX5S3BS9mYpgL
 tEh2rFa9CQxIhmePlnNcsU6Mxxdj719HIcFAty6fVQGI8YNV3z7PaeMrBklRojKgcg
 tIMoIf9jB4Yqmr+OwTP2/das7V4U2wTVp2sWTUFLlRc44+8BZB91bGzYkmrgiz2gNw
 f/Nr3MQuC+iLXlqUQr7MIU+KKDJg5WRmOkwYfeyDumrWDxmJhBUE4CK06HiL4OfwnG
 dpxKIYEUNGGqg==
Message-ID: <43d32505-41ff-4470-a75a-add402f14982@kernel.org>
Date: Thu, 27 Aug 2026 09:11:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260826153644.3726384-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260826153644.3726384-1-daeho43@gmail.com>
X-Headers-End: 1wzOeL-0002ho-N8
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support resizable tail section and
 unify pinned allocation
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 23:36, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Currently, zoned block devices restrict pinned file allocations to
> conventional zones at the beginning of the storage (before
> first_seq_zone_segno), triggering range GC when conventional space is
> exhausted.
> 
> On regular block devices, when preparing for future online filesystem
> resizing (e.g. partition shrinking), pinned files must not be allocated
> in the tail area that will be truncated, as pinned files cannot be
> relocated by GC. Specifying the resizable tail area size (in sections)
> allows uniform mount configuration across devices of different storage
> capacities.
> 
> To support this, introduce a unified `pinned_area_max_secno` boundary
> abstraction in `f2fs_sb_info`:
> 1. Add `-o resizable_tail_secno=%u` mount option to specify the number
>    of sections at the tail of the filesystem reserved for resizing.
> 2. In `f2fs_fill_super()`, initialize `sbi->pinned_area_max_secno` as:
>    min(MAIN_SECS(sbi) - resizable_tail_sec, zoned_max_sec).
> 3. In `get_new_segment()`, restrict segment allocation for pinned files
>    (`pinning == true`) to `0 .. sbi->pinned_area_max_secno - 1`. If no
>    free section is available in the pinned area, return -EAGAIN.
> 4. In `f2fs_allocate_pinning_section()`, unify the range GC trigger to
>    run `f2fs_gc_range()` up to `sbi->pinned_area_max_secno` whenever
>    `sbi->pinned_area_max_secno < MAIN_SECS(sbi)` and allocation
>    returns -EAGAIN.
> 5. Expose `/sys/fs/f2fs/<dev>/pinned_area_max_secno` as a read-only
>    sysfs node.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
