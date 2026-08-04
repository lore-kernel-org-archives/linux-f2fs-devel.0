Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396B7C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqjRGtrUWHbyb8S6EzYZvEKyQfNjOeSaWtH3c4KT3ZQ=; b=hL9OFSWwo+BEXPryWy0C97k+NP
	9iJn5vKXHzDBmMHE40WNJ9Gc8jc/Nw+q7Jl6xwv0EZCtybxUlCwL0z+fNFyIQ2gXA8co5hMHMzYnq
	kNwN+8BkA1vtLNNxrD7Tk3L4Nhi2bwBVgE3szQqjC+R68sfHNDVDwSl/Vuw3m+0lAkgE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr5K6-0007vm-3j;
	Tue, 04 Aug 2026 02:56:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr5K4-0007vf-SH
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 02:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fKWkyBXLwM7WyN7+yHyKvtPgNDr1bdwv61Pe/sas1Y=; b=JeXHh386U7vKqgpWY+9dPgUa33
 qWHVjfVX9UUSOvQFy12u3Vc4BxzhBMpLvFNvW6GBTiIVcuZ1Lda7Apq6eKM81RUiBdO3QWZTDF0rd
 GwVR9EyzSRwa9WPYZ1/imm+vo40vG/AIySatV5EUng5thhKEEpLnlhjRwVc3xqxHP/aU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9fKWkyBXLwM7WyN7+yHyKvtPgNDr1bdwv61Pe/sas1Y=; b=lAhyp20D1KyV8x94qTYMW9JjOY
 mwSTOUWwDPloe/gPM6d+6JcOEPNsKZrSkyemdpDUz3Y0/RyKRycAm+AOtM5AYA1VVLSpJyRA25Kol
 9iHNegY4hYbFow9l85AuaM0iKZsrXX+f+fDcGF5+VJeT8yPZru7oPJUIXZeQGPllpGpE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr5K5-0006Xc-3B for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 02:56:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C44E6435A0;
 Tue,  4 Aug 2026 02:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C85B1F000E9;
 Tue,  4 Aug 2026 02:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785812163;
 bh=9fKWkyBXLwM7WyN7+yHyKvtPgNDr1bdwv61Pe/sas1Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Bdu02aebURC/bLfarcWBkaRymeJ0Lpk7MbAvfjqwOmki4PDUxA6PQpifTb252GQ6G
 HCJddJ+H6k6DHysh59tYJZC3R1duhkUEbQlVwuOdL5LPiffkdqM14e2BZnlaHtTFAc
 5yd+jWpnjfU7r2RmaaGMWaLcQESSQPmTS9oSRGRQ1dHD54SZeYVrF3llJW/qfzcLwu
 cZFbXMVwehMnShCMhJdTxdTufJP1ADjkVRUx2Y1uBAOSyYSj2jOV6FKTmviX+KiMx6
 q6qQsJqKjxkhoDh3irquOWeVeOSAdwSl4ZlfMST6L54JBYVrZcmEzzyAX0URsdlOMz
 /ZOmCZq+pYyvQ==
Message-ID: <e72b48a0-a90b-4c57-95f6-8df4bdfd2e0d@kernel.org>
Date: Tue, 4 Aug 2026 10:56:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260804014849.1942326-1-qiwenjie@xiaomi.com>
 <20260804014849.1942326-2-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260804014849.1942326-2-qiwenjie@xiaomi.com>
X-Headers-End: 1wr5K5-0006Xc-3B
Subject: Re: [f2fs-dev] [PATCH v4 2/2] f2fs: protect critical_task_priority
 updates with s_umount
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
Cc: linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com, stable@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/4/26 09:48, Wenjie Qi wrote:
> The sysfs store path already takes s_umount for GC thread control
> entries, and ckpt_thread_ioprio is covered as well.
> 
> critical_task_priority also updates checkpoint or GC kthread scheduling
> state, but it is not covered by that serialization. It can race with
> remount or teardown paths that are stopping those threads.
> 
> Protect critical_task_priority sysfs writes with s_umount too.
> 
> Fixes: 52190933c37a ("f2fs: sysfs: introduce critical_task_priority")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
