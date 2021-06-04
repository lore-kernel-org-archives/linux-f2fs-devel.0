Return-Path: <SRS0=ofO9=K6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3E8C4743D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 23:46:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE8A613BF;
	Fri,  4 Jun 2021 23:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE8A613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lpJWk-0003PB-3H; Fri, 04 Jun 2021 23:46:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lpJWi-0003Op-36
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 23:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vsp6ZcdAdQZ+Ises/3pMA5HtxIebHur3HwNGnbGzckk=; b=XjMDTgbkJBai0wZgW9GFEeMFD+
 JQBF518hWyRUZO/rP3WRY0RZNkm0A2zdmszAxDL5wcNX6+diKSXwG031z72L1e8661NaPyICGpixL
 ggfLN4ECKNxq0nLUjfcV+LQf+ZLu+qWyEkNLhV8frd9iOgSwmhLNaRHwje6W1Zx7Zdmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vsp6ZcdAdQZ+Ises/3pMA5HtxIebHur3HwNGnbGzckk=; b=Ruziz+W4yeshep3R31kiu0tOiG
 pFchBW5Q5R/eiKi37YHpxkjgn2kDu1jp5ZSPWlSrfiaFnLqfpDri+neBPGzEzE42QU44lMU69bFuQ
 aAETEOWnJbN964dTAg6RdtTHQIbi/W0wBNfpIlTC1yPrkVsr73K457D+Hp7rC36m2Fa0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lpJWg-00AypL-4l
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 23:46:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FAB2611AD;
 Fri,  4 Jun 2021 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622850403;
 bh=zSqYRKt3AKTNAslcAW+pxGjDfLkejzE4sjKMLJf4zJI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=T05xuJSXooNKkWiZrrXr7ff1s5nmbdsNi6cqlsOvbNAn1zFJF5H//P/6yTglmMP53
 YS/T6IB3hWllmEFP0VJibkI7l8W7fJDd9N3nUtJec7jGxOGGMURbKR+5mxE79AhOsD
 kbNQ3m+6LZWzIS0KS0Bfb/duGsL70Y0RR078RZMviiNpTQNB5BjMDjs0VDA6bjfPtP
 8C3cbEeM4UNOyOHqc7SIXAl84pqPJlRLA46JPU+zZpyDSJyvAArokm2r9vi+UamxSH
 twAODzReuwlLXhe+Kkvd/TGQmit1UJIXfgF4YGp2PpZ3ybvpOYBImhZODTvqYbuLX4
 jKAaKWlksRU5w==
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-3-drosen@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <b05632b2-6d60-02c4-7610-51e3c10379f5@kernel.org>
Date: Sat, 5 Jun 2021 07:46:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603095038.314949-3-drosen@google.com>
Content-Language: en-US
X-Headers-End: 1lpJWg-00AypL-4l
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: Advertise encrypted casefolding
 in sysfs
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
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/3 17:50, Daniel Rosenberg wrote:
> Older kernels don't support encryption with casefolding. This adds
> the sysfs entry encrypted_casefold to show support for those combined
> features. Support for this feature was originally added by
> commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> 
> Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
> Cc: stable@vger.kernel.org # v5.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
