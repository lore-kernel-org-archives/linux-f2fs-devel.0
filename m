Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E31ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Oct 2022 03:18:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ooFt9-0005V1-43;
	Fri, 28 Oct 2022 03:18:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ooFsp-0005Uj-V8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 03:18:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sYFN9PBm9FF8wYdNcfHVFvoqVWeg/5DZsHQc5u6Mh2I=; b=VBYAp9dtKYoUgZFRlWUu5vncnP
 14pquVk2b0Lg+nEM+iM9aNsQ+ORMPx9KKCVQS014vrAOGu/XhXip8IANfDyB/fiIRarlxxt6s2HkZ
 +hqqmiGbxuVLz8gcoL++XCHmSTPnL7uJKihHk0/y876XpWx1OyOf0o2oglSID7OEhx7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sYFN9PBm9FF8wYdNcfHVFvoqVWeg/5DZsHQc5u6Mh2I=; b=axdX6gw94t9iMGGlqYS6DF7xaR
 yM9ouWIba/W6Or1jJz3mfRqCbO8qWpkiXi3lH7L8qlWzYP621BFgzXCPqXZ/2hP7H3WWaf6pUI6D3
 gwpSNAksx8rWKu7lLdVmmZdgQNIXf7QVGq0VJ/iJSSZIhG6W6xknZV+8Clf3ZPjJq+Cg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ooFsm-002xgF-8t for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 03:18:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2DB5EB82726;
 Fri, 28 Oct 2022 03:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7734C433C1;
 Fri, 28 Oct 2022 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666927075;
 bh=teGpqU5l4BnV+gF1DyvYpL8pu0uLFu7cp/ZG4zNC254=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kMDmcYSOokwWI/EfdMSjR8nSmgl3TkoZO0HlBLMX8Siv2lMfhQP4tyQn4Wcl0yd6X
 YJuYh9uUvFLtyG368SG/bzz1CTq79jZQLJB/pkXGDqmvaNiyOC+7d9to2QoTCSnD9S
 BZpiV4oF8A+eWXzkT5e5vRQasWe+amVnm74VJll9CEMQlUdkpJ1oD/LTkRvmkjy/K7
 GCRO1Ti/Vw7NqvR1qUNauW7WtImmTapqa0Xi3W6vatVWxj6coQ+Nt2wrE0b+sjWkUL
 BeXybtRcwchkRmnvjXemLaRx/NXVR8j3PJvgGJOqfB6BDfcddAByBMtaVS/yGJzx39
 YNVET2MPpgvMg==
Date: Thu, 27 Oct 2022 20:17:54 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y1tJ4uKBa0ItHCBw@google.com>
References: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
 <20221028023303.28020-1-frank.li@vivo.com>
 <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
X-Headers-End: 1ooFsm-002xgF-8t
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error
 when errors=remount-ro
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/28, Chao Yu wrote:
> On 2022/10/28 10:33, Yangtao Li wrote:
> > > It won't pollute global namespace since it's a static function just be used in f2fs/super.c...
> > 
> > emm, I think it would be nice to see the f2fs_record_error_work symbol
> > in the stack, it can be explicitly a function of f2fs. personal opinion for reference only.
> 
> Oh, yes, let me update in original patch as well.

Chao,

It seems there're multiple bugs. Please apply this as well.

https://lore.kernel.org/linux-f2fs-devel/20221027180416.3786792-1-jaegeuk@kernel.org/T/#u

> 
> > 
> > > Do you mind letting me merge these two patches into original patch?
> > > since original patch is still in dev branch, rather than mainline.
> > 
> > Glad to see, if resend.
> 
> Thanks, :)
> 
> > 
> > > I guess it needs to stop ckpt thread as well...
> > 
> > agree, :)
> > 
> > Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
