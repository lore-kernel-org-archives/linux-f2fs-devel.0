Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A1606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a6/GWIyp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jbgsSwEK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UmpxHear;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCamjkp2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TDKX6CCfi0guPZXtcerFiNfpTs5wrDfmbIUKreJCVBE=; b=a6/GWIypQqg1B2
	DfjbLyHvmcANBsJNKo/aUDuZRn0lEvV6yCFZkDrIngY01CNGea0cJCmgigxsM3KldGxGw6sqwKK/o
	DRe+1RIDTohzRn7CklEjeb2O4fpLOV47QeBrhIkzwqsT7qfK6pebKV791BSrhctQ0gRR/AW9PmQ4+
	/8U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF1C-000000004q5-1bAe;
	Thu, 29 Oct 2026 01:33:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF1B-000000004pY-3xE3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Az7JCfLfZ+BUrkAqrJOQQPIHKHXzY3tnCWu32RhZFdA=; b=jbgsSwEKG8EQlBoieGEdSl+GNP
 XoeGf1IbPDc1/fHttYNKQL2/mCzoe78Zrq7wL2aj8JciXAEGKNiSISL2q4FP+McKG1y06M8dhBN9X
 LhojJR1WloqL8no3Pla+eVIOa12R5dt00EVk5LCmPwpwamkDNyBwFYN3IYNsQ8XQnqUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Az7JCfLfZ+BUrkAqrJOQQPIHKHXzY3tnCWu32RhZFdA=; b=UmpxHearaspsOrWHYuXB9dqPJ1
 MiawMMxsRlaRIiN/iiRqAHEWqVR7szP+1B4kM2668cS2+zzgpSQgSRXoImj+73Tsdfrw/RssCyw0p
 Uq3Aol5B6LBgQmf5ks25iOAFinc6z8zFaH3NNXj72Yd3kLh6/kflgPjjIRSqHX0DTkZg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF11-000000008Lt-3dk3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:33:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AB024184C;
 Thu, 29 Oct 2026 01:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198521F01825;
 Thu, 29 Oct 2026 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237590;
 bh=Az7JCfLfZ+BUrkAqrJOQQPIHKHXzY3tnCWu32RhZFdA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=mCamjkp2l7wg6XK7uFZGSQ6QwS8VrYErQ7adiYQPz7LrssZRHNT0GfKwULiWA+/R6
 uBWkPHQD7LmKwrv9tZVVpUFEyjyxYDMjASGIc/2av8U0iG4Sa9rM2mmo/swBTI6Yvj
 rpI+X6gne+zg7/Up5R5vJNMLaMLaS+xvOmvuY/0y/yGUIkhMGGYTPFJvyAZMAq6gax
 r7GgJaOkp0CLxkqQhiwRfNw8tKL4+m3t1f7/NbUEgugHnI6GVPqqvUIXSSA64pAm6b
 QORCQ+EkdeN0OqjFQf9tNxbPJAhwwZtH7sFzM+noRdB+67NdKjQlNF46tpKtb6U9oI
 z/3OvolordVSg==
Message-ID: <156f75fb-fdff-4863-9ab8-5c0c5b1d72c9@kernel.org>
Date: Thu, 29 Oct 2026 09:33:06 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-10-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-10-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF11-000000008Lt-3dk3
Subject: Re: [f2fs-dev] [PATCH v8 09/15] f2fs: optimize small block size
 large folio read
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:44, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> The original f2fs_read_data_large_folio() implementation has limited
> benefit with a 4KB block size, mainly because updating
> read_pages_pending greatly increases the number of spinlock
> operations.
> 
> Use len_blks to batch read_pages_pending and iostat updates for
> contiguous mapped blocks.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
