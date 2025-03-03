Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8E8C282C6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Mar 2025 03:16:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1towHf-0003a2-9P;
	Mon, 03 Mar 2025 03:15:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1towHe-0003Zv-JF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Mar 2025 03:15:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j4n7W1x0TstHZgD5vGjpHRLfQUH0ov4E2kbdAjRSBv8=; b=ELsgEMLOQadbBZSsu4chfa7eLq
 OVuqa4+we2LoVvazxgUYDaqxx1jK81Mxyg11TnJn8l1SxkiaHm3SclHRZOnbqxje5q/Jim8vdHP+d
 UspRNg/kjvKk9aR4NySDbRKmc+GDPqbKPYJ/9nYhHaeYY68S5ugEJzEQcR+G/VSIaMvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j4n7W1x0TstHZgD5vGjpHRLfQUH0ov4E2kbdAjRSBv8=; b=P/f9+JFgKpwQPouA4QC3pX9vPQ
 /VNdJV8EVBTiGahXqBjwOsgLXZMcGb6p0ViyHmfTBz+62tgviIDxnVsE5p8Ds+zXSzl0laNJH0vvz
 LDFuh7mlXeME+XNEvdvfIxzuwhw9DvPVWJYseP/78uweqpsVR1U4bnOmlLzz9a1N+OjU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1towHZ-0004rP-7X for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Mar 2025 03:15:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DA1C4611CA;
 Mon,  3 Mar 2025 03:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B5FC4CED6;
 Mon,  3 Mar 2025 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740971747;
 bh=5M/kwU8mFCcQDQ71TdlsVXaQJdVcyUzLgfKCSWf6PZc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=KbzSZBJqN6E30b7AjA7koMSrqH1JdCVxLVZWT/v2TbYGvHvLxMklNhGpkMCy4R0xk
 /HMsZB69cwCoSEHcPSli+YBnmIzIutoEraG/+yKOssVD4WYNjEvRnkfPXzGj/h3FC6
 Qpdm+qB3/nGS+EeuAjC9Uncwn22wq29LKX94cs+n3On6sDqibptNCYeyLnTt2AN60g
 HR7KRMrE+NKI1wvtTXrB0CQAO+vBTaMwNBQTSSjsr+JABXbGmHCM56vuSe6JwIRKyz
 mFj7I1Qp7XtRpMplGG33WLLp145A5icUWXMzeewFmBOSnT4uZAR4xeyfJRQKZV0XAn
 ZcU8wC/p85v+Q==
Message-ID: <152da38e-ecb1-4333-8c86-b0fc343d7de7@kernel.org>
Date: Mon, 3 Mar 2025 11:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
 <20250218055203.591403-18-willy@infradead.org>
 <39268c84-f514-48b7-92f6-b298d55dfc62@kernel.org>
 <Z8Jq7PQNRDu_zmGq@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <Z8Jq7PQNRDu_zmGq@casper.infradead.org>
X-Headers-End: 1towHZ-0004rP-7X
Subject: Re: [f2fs-dev] [PATCH 17/27] f2fs: Add f2fs_get_node_folio()
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/1/25 10:03, Matthew Wilcox wrote:
> On Sat, Mar 01, 2025 at 09:15:53AM +0800, Chao Yu wrote:
>>>   struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
>>>   {
>>> -	return __get_node_page(sbi, nid, NULL, 0);
>>> +	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
>>> +
>>
>> 	if (IS_ERR(folio))
>> 		return ERR_CAST(folio));
>>
>>> +	return &folio->page;
> 
> No need.  It'll probably generate the saame code (or if not, it'll
> generate worse code) and this wrapper function has to be deleted in
> the next six to nine months anyway.  We use this idiom extensively.

Oh, correct, seems return value '&folio->page' is equal to value of folio
as I checked.

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
