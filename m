Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198B0D2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KwWQWdpt+qLxgpaMqC3YNLm+BOn0qPq1uFLByp1pkes=; b=aZ/BcEA3OPaC3wFuCyDd+M3e4V
	CXp7qG2iTxVGYA4ny4Lpc8LJ22V05zl7tb4dwbWLphaFNQOT8nR/ATrbFtdKlcSmSdziYcXXK+7ze
	8gJyYbI1Dqdxmo084J7w5E1ibcfq2Ir70GAz8yrXj55ztZCH6/NTkEF+vORWOKDE1DYo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viAua-00060R-ER;
	Tue, 20 Jan 2026 12:32:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viAuZ-00060L-E4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:32:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cX+qnA4DIF+Z1rsqQ6P0H/7xWIVByeSBQxg8noOveTg=; b=jbH1U8Kc2j3Z6ZOMKUuIrPF5Om
 9/f7BJaSGV8Sipyr8cm31wwvsXg1YtB/p9/2VJshe30sfKpGQNxWXddEIuzFkcLihhLLBdMA9apsv
 Iqi/RSy8UwGg7+njk/jznhyFhW4Cyc73lXnuW+0CfGUB2pYGej1TjHk/bQsyWPEdE+7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cX+qnA4DIF+Z1rsqQ6P0H/7xWIVByeSBQxg8noOveTg=; b=gg6Us5fSIyl4hzx+VM4hhU2TkH
 3h4XNf4dmlLFcGjrcWaW4qxsaXugC4uYsRUtfz+jlWrUI6bqanriAKZuFrnUfZQ8pyLICSlUVxwJW
 7mPGjmaxc0JE3OLOGVhdA/e3rTJd5HA9O5/eg406YJ+ssWT+MkJ4pwnS/iKcdOxpCDas=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viAuZ-0002QM-0M for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:32:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A89D600CB;
 Tue, 20 Jan 2026 12:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCEFC16AAE;
 Tue, 20 Jan 2026 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768912357;
 bh=nu+vIBtIAMWwZVdSHBkvLNFaV+bV/T6TLPI5Mv4PZdY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=KemF9fVAGF/HHTM9fVivs1p3rUsGzts/23FbBKvKG9Lm9l81Fj9dH7vLyfBJqb6XO
 D8JyAP9BP0gkwxXXlsX2Ra6lLDAtFH/a58s+dNpp+VV7AnLLda92QHK4igHIWgBHnD
 +LnZi+zFpnuiL0JfISGzZxN0ftEEC7l/uOavswgYqIbNNB16mBQukp54bg82JXoEpR
 SqCu1hvFDp0ouNHEmqxcvij0qAd0/RQezTOec1kzmVp3qfKwXu6hinEb0Jkho3rMk+
 OouzrpLoei/pVUI2XelChZeqWKscuSHIidouhZzYrJRY50yQU2I9bZvWdQrC3VOHgZ
 2D9bG8nth22Tw==
Message-ID: <a7a81c52-a047-4f2c-b397-8116aeb169c0@kernel.org>
Date: Tue, 20 Jan 2026 20:32:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260113152138.15979-2-monty_pavel@sina.com>
 <20260113152138.15979-5-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260113152138.15979-5-monty_pavel@sina.com>
X-Headers-End: 1viAuZ-0002QM-0M
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs: optimize NAT block loading
 during checkpoint write
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

On 1/13/2026 11:23 PM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Under stress tests with frequent metadata operations, checkpoint write
> time can become excessively long. Analysis shows that the slowdown is
> caused by synchronous, one-by-one reads of NAT blocks during checkpoint
> processing.
> 
> The issue can be reproduced with the following workload:
> 1. seq 1 650000 | xargs -P 16 -n 1 touch
> 2. sync # avoid checkpoint write during deleting
> 3. delete 1 file every 455 files
> 4. echo 3 > /proc/sys/vm/drop_caches
> 5. sync # trigger checkpoint write
> 
> This patch submits read I/O for all NAT blocks required in the
> __flush_nat_entry_set() phase in advance, reducing the overhead of
> synchronous waiting for individual NAT block reads.
> 
> The NAT block flush latency before and after the change is as below:
> 
> |             |NAT blocks accessed|NAT blocks read|Flush time (ms)|
> |-------------|-------------------|---------------|---------------|
> |Before change|1205               |1191           |158            |
> |After change |1264               |1242           |11             |
> 
> With a similar number of NAT blocks accessed and read from disk, adding
> NAT block readahead reduces the total NAT block flush time by more than
> 90%.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
