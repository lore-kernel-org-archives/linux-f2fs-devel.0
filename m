Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E4ECD5BAA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y//gmexdjGJtSBgPbE+ezthZcIkropyi6vhM72dhUzI=; b=cuUsc3IY5B6yA+kS5ISlE5ZaDG
	uXR/Ee3VhBj/Hmq7OJ/SzdHCtcaPZUwwKJEWizxRY29NHwQY5hjD8Y27XtesV2sCaFiBTgbKcouaD
	tshwwF4HcPJ+5RXihkbw3SwZthNoL5YNwMUdOfYLLC2F/ILqQAeJRD49sf70rf4TsiCo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPymg-0001Cm-Tl;
	Thu, 21 May 2026 08:29:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wPymY-00017n-6q
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vOCEfgNYXKiVGJd798lyzXOfQOk4wWjeEy9YzVjrJn8=; b=buv1XWAxQpHXYdOpqS41rkOG6Q
 0cqow25Oa3q34GWNEptnl1UahrdXwCO4cERFTHeyLWH7DzK95mODMmNHgeH12Y2NfZ7NgxAQDDuoR
 jKpbJ2O5rIdLJbj5rz7NvbvI/t7gGWK09kUmjVbR+wQk0K1Ujnx6XfINxpYuRdwKpjKU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vOCEfgNYXKiVGJd798lyzXOfQOk4wWjeEy9YzVjrJn8=; b=Ba3Y2t9Zua/EFZOL1c3KpI0SS5
 uw5udYgGtp81hIF/GvehhD+0FiPlhy4iEDG9QQloKu57S18YBTra3/QjTqr7T7HJeT4zGl9A2z8++
 S0YslShsmNW6/7NEF3Am7rNcCcsW0xtWuedzkgyjjSift8dAd3VgQ927+Uc7tJ3KRXnE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPymS-0003tY-NK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:29:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9992560172;
 Thu, 21 May 2026 08:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129B21F000E9;
 Thu, 21 May 2026 08:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779352154;
 bh=vOCEfgNYXKiVGJd798lyzXOfQOk4wWjeEy9YzVjrJn8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JKuRjNOd1CE6RzL6kH02FLD+ke3nSr25Q3kBoqP46hvSROeYDc3c/TMjThJIPBlEw
 B7BUXjjAzYQKhcLNhe/qm3gLUm78PcZOLCsnHY4ySO4e3/r6rASs+DJ5v+Plx4bKKH
 Fin8t9fO106smxzD7i1qgj8MPCrcu32faz81C+tC/M/z/cOx54p52Wyk+Vtd4NxeZe
 9XJTUmRH4W5oM5sLCusyLBzq9moC7AEm2kNyNhkydZCClKFFkWU6Ze2UfzA9izdfEz
 Gjt1Rray3LU/G5WTrLfDcHvmdbskQHyPCHqodqVfBeU4xsOm3HNqF6OXDVY/tz9KFe
 nuZi0mh5p5wOQ==
Message-ID: <f00d5746-4079-44bc-b56a-31e79ddeab1a@kernel.org>
Date: Thu, 21 May 2026 16:29:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260520120705.1263756-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260520120705.1263756-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wPymS-0003tY-NK
Subject: Re: [f2fs-dev] [PATCH] f2fs: pass correct iostat type for single
 node writes
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
Cc: linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com, yangyongpeng@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/20/26 20:07, Wenjie Qi wrote:
> f2fs_write_single_node_folio() takes an io_type argument, but still
> passes FS_GC_NODE_IO to __write_node_folio() unconditionally.
> 
> This was harmless while the helper was only used by
> f2fs_move_node_folio(), whose caller passes FS_GC_NODE_IO. However,
> commit fe9b8b30b971 ("f2fs: fix inline data not being written to disk
> in writeback path") made f2fs_inline_data_fiemap() call the helper with
> FS_NODE_IO for FIEMAP_FLAG_SYNC.
> 
> Honor the caller supplied io_type so inline-data FIEMAP sync writeback is
> accounted as normal node IO instead of GC node IO, while the GC path
> continues to pass FS_GC_NODE_IO explicitly.
> 

Cc: stable@kernel.org

> Fixes: fe9b8b30b971 ("f2fs: fix inline data not being written to disk in writeback path")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
