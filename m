Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5382C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUotpM4Ykv2MCR3FuONfzFgc/jkSMjkUoulaNwSPo4Y=; b=FHodsteSEaK3jq77+pBwaQ5bwU
	yFKUcY+pJJyMO5HRHi1+k+xN5DBaG7+Zs8UNDvM9lTYp/ZbwYSDrhkZRfz4vH5YaWo576fj4a3yqe
	Xd2eaDqUMKYE84PWZ2acy//9x/3k25yppS5T1nPIx3JGyANUzlq1fY6px/1eB3h29xgA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2dY-0006T9-LH;
	Tue, 04 Aug 2026 00:04:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr2dX-0006Sy-MO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dcABTRhfi53RQ+j/GQA+fU4xh8TauAjt420CWoYoQ1A=; b=gHbZSTJH9cq8p8zzlU71WkumIZ
 +XXXoNwCgQ1aimOyzPmPC5M3cFKuxp/yIZywZqzCpj0AKRIwQlB9FsUze5MK9LBToe+0K1YUMk3pz
 tY7UAebfNwxhfTljDsxJP9JKTNgVSURdlL/RD2meS4162QAdyUIfo7ohQ2YZSObQv+UY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dcABTRhfi53RQ+j/GQA+fU4xh8TauAjt420CWoYoQ1A=; b=EEqnQA0Ltzi6XTxD1K/EGkwwSH
 1p8SHTE7bOHQ576iTbhPxh0uucmwh8UOjL+LUKLNYXGM0wI34pMl72EiSmaG6UYPRfbVSyjtJv3wX
 EZX+XrpLYc8xs8iHuTznR6gcuOh8+c4b0bNobLCUc50Kz0cLVJyg+q3NXzA94cZDJbtw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2db-0000pm-Ji for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:04:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CAD360A62;
 Tue,  4 Aug 2026 00:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A521F000E9;
 Tue,  4 Aug 2026 00:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785801838;
 bh=dcABTRhfi53RQ+j/GQA+fU4xh8TauAjt420CWoYoQ1A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=b6BLhWFQ3VEy8nc3WHYtb1vDZ4x8XuSBtQ8/qiggIVTdY5PZgGgXH/wRMjjV1osmB
 3FtACAGY59knxpmCEw8o25q6wjGv4BuPdrl+mkH5mktLg9KTGNBGieedqEqgvfXjD+
 z7TsMv7xoQ3ySvvu9wuhFGscRrdth0xa3h+uf6k0HAqPFOGhx6/7CR9FplHVi4UiVv
 gPAOuz7JuDpDg4w+gTscq/nXeSfXlFjPQIWpztMvaHzhciq+faFdfWz7lHHbz2gcXY
 mGC+L04X2gqgvj/i3Ung1OU/ldaNpLtMCUs5Ayg1MhBKMKKCtisKOCcrmN0qUEIMzb
 8BiFkMRaj5Xjw==
Message-ID: <1c7a599a-2a9a-44f0-9d03-cb1c87f81cd3@kernel.org>
Date: Tue, 4 Aug 2026 08:03:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260803123251.1522864-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260803123251.1522864-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wr2db-0000pm-Ji
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: avoid NULL checkpoint thread
 access in sysfs
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/3/26 20:32, Wenjie Qi wrote:
> checkpoint_merge can be enabled even when no checkpoint merge thread is
> running. A read-only mount is one case: f2fs does not start
> f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
> sysfs.
> 
> The ckpt_thread_ioprio store path updates the saved ioprio value and,
> when checkpoint_merge is enabled, calls set_task_ioprio() for the
> checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
> NULL task pointer.
> 
> Protect ckpt_thread_ioprio sysfs writes with s_umount as well, so the
> checkpoint thread cannot disappear under the store path while updating
> its ioprio.
> 
> Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
