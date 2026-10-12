Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CDCCA9EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 03:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cL97B9CCpqfYwPwokTTxpFH10wyz9Y2HWxylVI0bIfE=; b=W3mkj0zloIjBXVTqNgYhSDzCM2
	7jOiPvCG6upd/mWaam6okI1FD8jgIMyF9xk/9zQ2mHqb6/UQEH0M2VuPLcJt+xxQgJE8svvBsmQ9y
	6TVO051VHQZFLbcZBBGO6M1ddKpWs3TbfuC1idhSsB4D1O+apEG1CCkmNodhgj4+w27c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xG6N6-0005eH-AU;
	Mon, 12 Oct 2026 03:06:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xG6N5-0005eB-2f
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n9ZRVZAhPl0REZUvWy9Yao07ThdaPGKA/SPLB+UrlLQ=; b=EcSo7xBf5SSFnTYmPIpOcOXd0J
 7ploOAvu5kD5sp0mdb+dmzEQT8S27He7S6qIS2Rm4NdpM92GONrsmhyfQHRMqxXZXaWfE4SgwUth+
 xXcaQezsek8QcPU4ODtLBqOvD+IhEjN4ea9FA0kEzsHtsGD55S+xzXEGEa2AOaP/OwvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n9ZRVZAhPl0REZUvWy9Yao07ThdaPGKA/SPLB+UrlLQ=; b=RnIo+7fm7JQj3RG6xTSyWWrymU
 3Q8agQ5bmC9zKzTb/3f0aoPOzxl4Hm7jSVd57EMLSUk1PReyZ92Ir0qJOD88eoOzuXf/SIlt1JOJX
 Rg0VkcpYmgcn6vbWIBcGf2QDLPd003W/kHygyAcBc9dEHRhHfH2VgBYyNNyR8mwnpPM8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG6N5-0003mJ-Df for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 03:06:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2AAD41808;
 Mon, 12 Oct 2026 03:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2C51F0089B;
 Mon, 12 Oct 2026 03:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791774393;
 bh=n9ZRVZAhPl0REZUvWy9Yao07ThdaPGKA/SPLB+UrlLQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fkHjlQ+WdOiIsPLnMTSxK89S6+KXM2Kfu37oDdOHwd+qyvL7oUiULjfq+avuvWwdH
 Aw67iK23Duv9PQpG27FaE2/oZqRkiUlfkx/mkxZUp2PFHTklEWddSg61fQNNCT1BPk
 c+TnUAuKDGPN1UyRqCRKeZT6nTqm7SZrCblkhZX40ES63GkQltMUAnvEMHXFJRV7Ch
 sWtjjYJcS4mtoAZBkEWXBXOwBvPqYDYrQmFdBvmL/pCJVw3SIWp0SU8hvradm7hOpK
 hfTb+gFNnYFv9ocg3ld0b0VWjm81ehOR9TMZNQZ1VS17eFGVBPq4XLcvwvrfteZHme
 00+mj+Wiq596A==
Message-ID: <e12debf8-87d0-4c17-8973-98e950c2047f@kernel.org>
Date: Mon, 12 Oct 2026 11:06:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009161224.4163796-5-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009161224.4163796-5-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xG6N5-0003mJ-Df
Subject: Re: [f2fs-dev] [PATCH v3 04/17] f2fs: support atomic file large
 folios buffered write
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/10/26 00:12, Nanzhe Zhao wrote:
> +	/* If index is beyond the end of file, reserve a new block in COW inode */
> +	if ((index << PAGE_SHIFT) >= i_size_read(inode))

Can you please check all "xxx << PAGE_SHIFT" statements in patchset to see if there
is overflow issue?

> +	if (f2fs_folio_may_unlock_balance_fs(folio, mapping, need_balance)) {
>   		folio_unlock(folio);
> -		f2fs_balance_fs(sbi, true);
> -		folio_lock(folio);
> -		if (folio->mapping != mapping) {
> -			/* The folio got truncated from under us */
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			goto repeat;
> -		}
> +		folio_put(folio);

Then we can call f2fs_folio_put(, true) to clean up the codes?

>   	if (folio_test_large(folio)) {
> -		err = prepare_large_folio_write_begin(inode,
> +		if (f2fs_is_atomic_file(inode))
> +			err = prepare_large_folio_atomic_write_begin(inode,
> +					mapping, folio, pos, len);
> +		else
> +			err = prepare_large_folio_write_begin(inode,
>   					folio, pos, blen);

Same question as it in 03/17, can we relocate?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
