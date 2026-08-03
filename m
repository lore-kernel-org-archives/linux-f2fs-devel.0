Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07404C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PBlY7rV3egyXcOvfMnzwUgw+3ekSeTZ/xM6cbKV9J9o=; b=hPkD6+nJF4BdixP2mo7dwaYTqb
	ilM2j4f6j1it9cVrejoBbZvR5blEkEbmxKrwz3ZzIdY0eDB2JJixtkxFRpGWw4PdrSBkyZluQOU0B
	CVwugDJVNN5M7L3xaCGYJJvVhAuHQpWIgvRdr5dCQjtTwosVgZag9wQfrFYkQUZbe5LU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqi6g-0007xs-I2;
	Mon, 03 Aug 2026 02:08:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqi6f-0007xm-W5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 02:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=akXWdnMvBxguKVgRZUt8MGf93stsSK4rwcrXnjHtvIU=; b=P1JuMOyponwFJ2/InRMgCn9ORJ
 b/LVHKhtsM5F2jbxAY6pnrWDGIuhsLGuwsF77LC+f6We3nS1SwzUxZYLIY6beMeDT90tpggW4Tixy
 OljuvegmjTisU7rq6ypcUBUntRgbnurkLzxEf9uBpZ/Qd1EtJuD+UyT+s5xFIMdC5yUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=akXWdnMvBxguKVgRZUt8MGf93stsSK4rwcrXnjHtvIU=; b=nNfE9MAd5LKeCz0lFYMDkL7KUE
 M37BBLSc2RbHXnXhuepUZVvUU95lD7Wur3whHFQvT+4uzn7nVlHznoVEvUnPE1WrzrTIodjTlBb0T
 LYGP7mid99hn3cIMKtSVZBlmzulTCnzsmjd2aBcIfgF2dKO72MHYENT/A8lLa7upqmUM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqi6g-0004aJ-An for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 02:08:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A695160A58;
 Mon,  3 Aug 2026 02:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2804D1F000E9;
 Mon,  3 Aug 2026 02:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785722920;
 bh=akXWdnMvBxguKVgRZUt8MGf93stsSK4rwcrXnjHtvIU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=G6FeoOZf9L3vR0tKh67td8aotR1b5qA7rGBF3KGuhCy4A7YQgUuaPtO9pA9a5UKny
 JmyG1dEC38HNLMMhcbQv7kEIz01ww/WSc4/yAiQcaEXNxAPE2n8RfXb+UoL9KduE69
 HHc5R0DUuFMm8Jipi4zrG1p1AYOEJ2aBipc3Y6Ldh8cLAef61JzMHHP/yNoQfiWg+V
 FABS6/C8lYfIPtwRRqxzDXDFr9rsZiCkVPPuZLLd0VzYgqX20ka+MfMx476cG8dgwy
 VDL3UV663Yyt3T0Ix7rM65czUq6OwmSjoUJZXWRIsYZKHpG36X3r6dEaVJzUXN9cfd
 8CxR4+3w7G5Jw==
Message-ID: <3edacd16-9112-4470-9b59-b5a8edf25eb9@kernel.org>
Date: Mon, 3 Aug 2026 10:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20260605100559.94843-1-guochunhai@vivo.com>
Content-Language: en-US
In-Reply-To: <20260605100559.94843-1-guochunhai@vivo.com>
X-Headers-End: 1wqi6g-0004aJ-An
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: drop unused SB_ENCODE_FLAG
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/5/26 18:05, Chunhai Guo wrote:
> Since commit 29c1e18a0bc5 ("fsck.f2fs: tune linear_lookup in
> f2fs_do_mount()"), fsck_update_sb_flags() writes the superblock directly
> and nothing sets c.invalid_sb with SB_ENCODE_FLAG anymore. Drop the dead
> flag and simplify the SB_NEED_FIX check.
> 
> BTW, SB_ENCODE_FLAG should originally have been 0x10, not 0x16, since
> invalid_sb is a bitmask.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
