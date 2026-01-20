Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A7D2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jRpjTQrzS9anwSpvwIAkgJPYo+le4noJYuTXKyslNH0=; b=RjcHUMXk8P2rcwy1MJ08+H5L9z
	zJTSoy3AOQTlE2VRp/WGVu470mwWt0yHj8HJp7akxZh3sn7x1Iy0XGVveEUB1cDQ5M1+D6ZquSkSm
	AQxi/Qy2UZA0LcKV+6AhFjC8rIJr3wjMJ6DyYhdeSG8LolIfhgpiPB5wZdtKEw35WfFM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viAyI-0003ir-N7;
	Tue, 20 Jan 2026 12:36:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viAyH-0003iK-9O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:36:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zfNp5TYCST3VIbRo64aQqPHeCGJ6dG2o9xPeo/OhmMA=; b=Zh930ABZCyrjssW6bGYKn589ta
 BjWWCf7Aahu45FjgevAAprPmo2m0IY7ssDgTK+68bb6VRnghhFXqK3ItB24XBw1+GHAGrSJSMUn7W
 fEVqRl/+7/Izlq3LlZCQndux5PzY13MmnEcQPgtOmx3+PN+Imw6SomveicuXrOInK8og=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zfNp5TYCST3VIbRo64aQqPHeCGJ6dG2o9xPeo/OhmMA=; b=BcuItke+4wjazT77JMZ2GYau8w
 YFA5JeVL2POXYyxUExt9c7YN6kDPDMT5o8sz3/LH+odDJZpc3rkfxWGPyx3GkrwcROLY6sKpke+6v
 qeOd9qHV91XPkZFdrzdSHjd/pf8s4y3LUucHvi+uXVmDnMwF0+5+yZOzEYh+06bbr3SM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viAyG-0002c1-S4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:36:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 463DB60008;
 Tue, 20 Jan 2026 12:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C61C16AAE;
 Tue, 20 Jan 2026 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768912582;
 bh=4vtMXLq0UAx7kfgISmyIzih93qfS/l9hhu4SbX/ec4Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=tI1xueJzJ75GM5+FtGkSROcXk08DBeyrV7Kb48bOH67PMF0CyHPt0CpvRg9P2ou4Y
 S4tqwTs8dsShkOvkMkWwLhpiVAXRumQp1TGcJGd9Odz1CEeQ0+jYNo5K1IbkSin9Fj
 UavOT0OOlCOI27ryB/dZhi2DMhaWa02V7/T+zYGfBvo0r32yHfk3pcrbHhuVzw/Xo1
 Bh/Jk2EYd2hQuKTGEDORsj6LA2aIrH7Umz0sf/ltCEEWPL0PImfNhc2OfV3ZNBIZD3
 yX/+BEqccjQd0zXPdSKJA5vD6mEqm655SQ1givZmX3NFj27DQ1P65DhVapmEPUiwBu
 omE8xky82cH4g==
Message-ID: <11190a28-5800-4f48-a433-faf3067f289c@kernel.org>
Date: Tue, 20 Jan 2026 20:36:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wu Bo <wuboo@amazon.com>, jaegeuk@kernel.org
References: <20260112144416.38583-1-wuboo@amazon.com>
Content-Language: en-US
In-Reply-To: <20260112144416.38583-1-wuboo@amazon.com>
X-Headers-End: 1viAyG-0002c1-S4
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: optimize the
 addrs_per_block/inode loop
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
Cc: wubo.oduw@gmail.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/12/2026 10:44 PM, Wu Bo wrote:
> ADDRS_PER_INODE and ADDRS_PER_BLOCK are macros of a function, and if the
> compiler does not optimize the code (-O0 for example), they would be
> called in every single loop, which could cause significant performance
> drops in some cases.
> 
> This scenario has been found before, refer to:
> Commit: 1bb669e ("fsck.f2fs: avoid unnecessary recalculation")
> 
> To avoid this performance drop as much as possible, I changed the
> function to 'inline' definition, which could mitigate such cases in
> the future.
> 
> Signed-off-by: Wu Bo <wuboo@amazon.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
