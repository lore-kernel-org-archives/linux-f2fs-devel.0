Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216C6C47BC5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jan 2026 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCdp3vyGX8MLfl/407ormnKvga6dzZC/7uBpsa7sQVQ=; b=YG6s2/CBFj/9eWph+QJQTxnX5d
	+u2ByVXo8I9YRibgnQH2m5FZC4lNKS2XHhM5uzsdXCeeRJ1K4MDbOOzK+UWFNkeUz7bxzKE/ejQYT
	OaKWVQyY3PG2BK1fc0dE0sqQBDCcKrjqFTtJFD9B7KgZPWYcjgMP1yKhZGyYdv8ZIXiQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vd3B1-0003ss-Ly;
	Tue, 06 Jan 2026 09:16:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vd3B1-0003sk-0V
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jan 2026 09:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VCjBcF1V8UfZ5HkJoeXn/Q5hFpHQrgZniZGW3yTaAc4=; b=M5R22avBoB1sUpDnHL1UjQ0kqX
 FwMuXGwcfXpP5vUAqiToOouYL3LNForfTtA63bVrd1HO2iO49++wTQlmG7nrsFkHKmvpxtjBLoJXt
 5ZSS7c/T5ERD0iZTTxNhaLRtm1Y1HcWIWypbzrzPwg1IN7nUdBOUUfWFDbhWMOJ8bWX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VCjBcF1V8UfZ5HkJoeXn/Q5hFpHQrgZniZGW3yTaAc4=; b=fYw2YmNZUoWKPtlx2EKKQHTk/v
 eiHIWcgj9StJpY/78xtGCTyaIcFnnvnMZ6whAPIoJhrMtHpUxvgBBC8bErSJK1sqHltbGGlxmwy0d
 KVAD9GfBi+gUHGmRXV7zU9o51iXA04iNcTWe3N9DTBpUCsPqrA5TZV57+1Q9ldGbLrho=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vd3B1-0001Rr-DL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jan 2026 09:16:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D0A940637;
 Tue,  6 Jan 2026 09:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF57CC116C6;
 Tue,  6 Jan 2026 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767690980;
 bh=ie1bpc9Rkof32pGQxJ30gOLVwmlHF/yvwRZ2LsTecAY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=Cy5x09ABCtRAyTb6N9gEUN5BnJgUFAt3c61AD1KcnSs3Z9oVbQAl+lVe5ntF0a9Vp
 Cq/X/7hF1zIzqOAyJ92MzzW46YbeB3tXvsLA+xnLpvCy/HSgQGLl2LvPQtko4AMLyy
 YDxbT+UEBpVFz1j9kzdIA/o7YO8FGkNNN3hwUiwipPkMSHtvP/GqC+RBrF6ldS59Mn
 IGLup8BGFdNXw+2bSC5gQmse9fSHnC6Zl/vgz1MHiIACcSLEGBI1R8UJg9n9i/HEvN
 ycBKu4JJKPkO3/VcZvefz3aa3j8xsf/5Pg+zmiUb5e0WAPxrcZBn26FYSIOy+OjZ9l
 sYzcY4FJhXNzA==
Message-ID: <61ba9e54-6e08-4140-b070-05fd696afa48@kernel.org>
Date: Tue, 6 Jan 2026 17:16:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao@126.com>, Kim Jaegeuk <jaegeuk@kernel.org>
References: <20260105153101.152892-1-nzzhao@126.com>
 <20260105153101.152892-2-nzzhao@126.com>
Content-Language: en-US
In-Reply-To: <20260105153101.152892-2-nzzhao@126.com>
X-Headers-End: 1vd3B1-0001Rr-DL
Subject: Re: [f2fs-dev] [PATCH v1 1/5] f2fs: Zero f2fs_folio_state on
 allocation
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/5/2026 11:30 PM, Nanzhe Zhao wrote:
> f2fs_folio_state is attached to folio->private and is expected to start
> with read_pages_pending == 0.  However, the structure was allocated from
> ffs_entry_slab without being fully initialized, which can leave
> read_pages_pending with stale values.
> 
> Allocate the object with __GFP_ZERO so all fields are reliably zeroed at
> creation time.
> 
> Signed-off-by: Nanzhe Zhao <nzzhao@126.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
