Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE79C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 May 2022 15:04:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nubVV-0006S1-Jf; Fri, 27 May 2022 15:04:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nubVU-0006Rj-5U
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 May 2022 15:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mkbNoF7CHDD0939WO2D+SsXoyWlmC8IqIBG2NZDTadY=; b=OAby3F4uJAoZlvsEhvxGHgM/ya
 Dv7zfhBPNM2ReqsNswdGyNRBgTosIPKc2phWug6Mv2X9UztUbgVbjGUNSnDV9jJ/1KcztNLDcm1ZO
 +AxyYusjPQpCoWjgR4X3X7/3leJRz5glsEoIodu1k+j73fMlPqy9dz8bW8CyFDJdHFU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mkbNoF7CHDD0939WO2D+SsXoyWlmC8IqIBG2NZDTadY=; b=lx91cq3wCqkdXJPm4jjPh7volH
 XMjudJVapug+T4uep0SyPh6o3q7EkT80npNv6U+MwvzPXKJUVK2oQF2mf8ZomJRY7ZbohxBarEkbh
 p49yGPtArJKBEMwmsOgCbAN1Z4CsnC3dMxNai2Bh+vX3guTx7K27yMdD21X3n+iIOX9Y=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nubVT-004Ppp-Mr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 May 2022 15:04:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 63AC0B8255D;
 Fri, 27 May 2022 15:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98190C385A9;
 Fri, 27 May 2022 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653663836;
 bh=KYmRsp8PHcsSaHvwN0jbr6Bu6gOSmapE0ghQ9PlKuk0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gvrS3QKv0IjtRN0lfETBVYHZqaBLXVlfkmvoFwVET1CXV0ep4XxKHvmjTp5Wdk5IC
 zujtE6qYxNlQgYEAKN6sor53oNK09Iu4H8SgyQfl28ca0rRiAGZZYpE5jsspOujwOh
 OUgyJ2qQqYfhEOHOVzKTddubM02UsZdejLZHJLmt4SlTQUFcWVmQys8bZTPb25j1kh
 nMgd/gof4XXwkmpKt5qve9PxLyHOec4uSUX+P1M38jnUZWjuTUtcqdVTmQxDHe4Qd3
 blE/zmNZYcmiNe+GwPDQJHfqGfMFNi1qfhhoWZKWfQ0IlgGzf1pWf6NzXA9dh6En8N
 pcHAEhio+BrUg==
Message-ID: <a64e5581-0201-9a4b-46ef-817cbef327fc@kernel.org>
Date: Fri, 27 May 2022 23:03:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Yufen Yu <yuyufen@huawei.com>, jaegeuk@kernel.org
References: <20220526022106.3848304-1-yuyufen@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220526022106.3848304-1-yuyufen@huawei.com>
X-Headers-End: 1nubVT-004Ppp-Mr
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: replace F2FS_I(inode) by the local
 variable
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

On 2022/5/26 10:21, Yufen Yu wrote:
> We have define 'fi' at the begin of the functions, just use it,
> rather than use F2FS_I(inode) again.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
