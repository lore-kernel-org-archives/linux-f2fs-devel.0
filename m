Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A6C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Nov 2021 15:13:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mqcuN-0002nW-IZ; Fri, 26 Nov 2021 15:13:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1mqcuM-0002nQ-9C
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Nov 2021 15:13:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y5L8KmMpvt81dT75QTEkxTG0vhrhSP9CfJqM2Jh5MtI=; b=ZmxYSxnrVlOQGkSK0QIXFvnCSS
 aEM6txsJ15C9be9S41l5y892/W3VkNECv+ttZDLa/Z8FRfz9XlzBP8fy+x/lBLPh94QnJoZfa1Yz2
 WEy2Nfee+RIrdeQtT8jmJ8am0viW4f4gTIDBHqSwRtCzEVt7vCtevBxUmpQUYMRwtZv4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y5L8KmMpvt81dT75QTEkxTG0vhrhSP9CfJqM2Jh5MtI=; b=HCMF/VTJxprtVk1vHdmX0B53Ut
 MdWIhe7I/cYj5SaX193by/6/kfzka9vboEt4RwxlRXHpyiDDCb2Iex40hymR0/iD8zflHNfv0i68r
 /ED7VUBGkfzEZC4Qkgyeos+LkLbnwFknCW3kEux0EjgEhMxiKUtZ30/WhRlJ5bENaKts=;
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mqcuL-0000G5-MP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Nov 2021 15:13:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FA52600CC;
 Fri, 26 Nov 2021 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637939571;
 bh=JGOs5xrMkmXHn6QBH3/p/id/LAg9cKwmXJxxxLabdjk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SA4+C539XJAC4xyJRVUWw9F/kEPA0iOLpR0QFY13eg/uv3QkQzTWogbJWcZvQLVtl
 VQPfOcrOBzcEBOUYBt3jsakzfyuWHp8ZKj0Blb1WPWRYBimec7WJejAqLkg0GTRzT6
 8m3YofkEBK0KqxCiybcJAHTNPJHUcqFxxEcj5VyV4EQUFEYEz+kXjPegm0Vx7mLXM/
 izgJfTNTZivNty59UGTaS62s3VLSPiZdgSgLCKFiCJkHbuSiv1A+ANWdbBuPL0s/i6
 6LeIVdYz3x+N5jVCFcqkv7v3qzRwINJPjvuTOsCFvvhQCtEqJ9OSWfehhQ6Ug8Amv4
 1R3kgO5AMYFrQ==
Message-ID: <9695acad-80bc-b53a-6b65-b60a6d5c8bdf@kernel.org>
Date: Fri, 26 Nov 2021 23:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20211126101921.305013-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211126101921.305013-1-changfengnan@vivo.com>
X-Headers-End: 1mqcuL-0000G5-MP
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix remove page failed in
 invalidate compress pages
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/11/26 18:19, Fengnan Chang wrote:
> Since compress inode not a regular file, generic_error_remove_page in
> f2fs_invalidate_compress_pages will always be failed, set compress
> inode as a regular file to fix it.
> 
> Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache compressed
> blocks")
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
