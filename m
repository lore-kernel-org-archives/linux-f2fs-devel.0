Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94674C5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHP8RVC1oba2B6L1ykcQ+g2L+fB1gG8GGiTHZZJYqKU=; b=ktQPkQTlBDiy0Wci+PbQdTNPRa
	JpeJeyF9Q9Zljz71dHmdJ+GMqbGJYBvjcxG5iceny3Y3c4HFBJ7QTs1GEXQ0lV8RHKREkL8hKUpuz
	d6/5BLf9wJjocbmxdFOyWjJEFEyjzn38C0VpwgEzjL1r/60j5Ar53MO5GtCjWLu+DNk8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ws7fB-0000gV-H8;
	Thu, 06 Aug 2026 23:38:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ws7fA-0000gP-Ln
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 23:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oAPtEbxbO6lhryFen453jc4BByN/BWCjEvbFliTvU6o=; b=edIToFZl6OBe8gOauPKsjQJ1ub
 hht7QFEXad5a2kpHOByWKeiO90SQOMWINQgndMv7PCLdboyeDrQi35jy708AavuFS36/vkgbjjbup
 31he+mNLV6d0+9WGJqdPpJQlE+kcueroLUXmkwt2i6s7clRYaiYA70tG3/rWHI0jHjjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oAPtEbxbO6lhryFen453jc4BByN/BWCjEvbFliTvU6o=; b=FKLrSctvLo9fDoZvQb1Wc0Q62l
 EvbvU/lfWEiKhCOevYfjzYJrep+u6zid/x5O+ZObSElgDjYdBlTQruXPisTI/THRvJVw/8LGhdk0r
 H0vP2YqunP3fhhK690qyaYGXE2I3MkfhNaj9R5wemrJVx0S4dA43H59lg8hH3OjQFsso=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws7fA-0004iC-TR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 23:38:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E14C6004E;
 Thu,  6 Aug 2026 23:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A51F000E9;
 Thu,  6 Aug 2026 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786059487;
 bh=oAPtEbxbO6lhryFen453jc4BByN/BWCjEvbFliTvU6o=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GJmGkAq2dFIbQgvpPTasm+iJYH0ry1V4nEgCG3eddyvH0MbbH/rjQWIh3nE0+5bSm
 GXGCm9/dqsxj/4Uu+UgTWFW0lFWackI5fP79wgHUNY5w7+W/auQjOzSy+Pd9+QYFWM
 xCRIsVKUnQ1KGfipq0TjNzpfyHYL0iFAiNMhcC+bRa/4TWCsmTmh44Bq3l/Z9zKw7S
 HknJgS+zTIvWfC/+d5Ieg/DlnrNj2O59SO6HYgB9dlAuqKKaSjRybo8jBxEGsAmUEq
 THTfCmtaeo3F9sN5LHkBW85aSCrorFvFzbT8bpjwi57Kl8eZ+6GCl+1GzthrxyhpUN
 MQIhhL2f0Sjwg==
Message-ID: <8d2a968c-f57d-4757-afb3-b79ee1f14223@kernel.org>
Date: Fri, 7 Aug 2026 07:38:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260806170108.2100312-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260806170108.2100312-1-daeho43@gmail.com>
X-Headers-End: 1ws7fA-0004iC-TR
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quiesce background threads during
 system suspend using PM notifier
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/7/26 01:01, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> During system suspend, a race condition can cause f2fs_gc and f2fs_discard
> threads to call submit_bio() while the underlying block device (e.g., UFS)
> is in Runtime PM suspend. Because Runtime PM worker threads are already
> frozen during task freezing, the threads become trapped in
> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
> timeout.
> 
> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPENDING
> during PM_SUSPEND_PREPARE. Background GC and discard threads check this
> flag and immediately stop issuing new bios, allowing them to enter a
> freezable sleep state cleanly before process freezing begins.
> 
> In addition, check freezing() as a fast path to stop issuing new I/O
> when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
