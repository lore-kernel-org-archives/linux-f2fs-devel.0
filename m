Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C76FC5479D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 13:30:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFbBQ-0008FI-Nr;
	Wed, 11 Jan 2023 13:30:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pFbBP-0008F8-Fh
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 13:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JPg8tMGtzJ+RJWfPZe9z/XnvC6B7yEsQzEYSlQV671Q=; b=T3PY22hN4b9TFNa1f7bfIWZZho
 R6cruIcM9FiTuy9vF/QWdNY+bzWf13Mm1RFlIvwMqXitw5fZf4cuwvxdHLJ6F9mGo/B0GapxGSbAg
 H3Jy4AuYs67fhHgB+EA+T3meVsHGMMjXQo3k5XhWyl7psdjmSks8J0mkTxsnu5mxtp5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JPg8tMGtzJ+RJWfPZe9z/XnvC6B7yEsQzEYSlQV671Q=; b=g0UVvOPM4MZVK9NHbTXRIf6jwY
 Bjzs+tKL8dO//2vYi27dxNCklMXBNWT5tlb8GHIO+QWQNw2/8UKPzjEOXCxAamwJqF5F7Y8+2Q/0B
 2r5eNsDmrdnDtTdNK6mQTkGpPJaz9H2/38q2+pPAFeKdzjG4mmibsaQfY7ovCIKZtD80=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFbBO-00DuPZ-Af for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 13:30:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E2DD461D1B;
 Wed, 11 Jan 2023 13:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2ABC43396;
 Wed, 11 Jan 2023 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673443816;
 bh=yqVgwWvB4/KMucLBOLI63/hATRZpVbXQMLtw0697zJI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FuWmDJHbYuPi3yPnixcamijaM6M03H1GVoryiqGjS30zSx82mZxgh1i85zC5k1sOl
 R/7jvsJqf4Y65BMFEWKPJ5GtcJUDCqE1iiEOzH8q/o5uJ/zeBcJQxu495xXVwB/XcM
 bGZvd/RWHTVbyv/Lam7RCYRPVsJV3wfFwgxXJjKBjlCEVizBphfl4pJMGblGyvQVu0
 IKp6wJiuD3s5UwkfirWXn/yfEGE2EHDsUT0NdqVAsdp44XkrZrQtdWDYJBj7Op2wx7
 V2XP8OKZ31EOV/pgGRJOhqK9kfU+SGJ0oYT2ayn4JeCmQVLOnaBCWDhhxDdWd9tJXv
 Orsd3For0y6EQ==
Message-ID: <aed2e21a-84b1-667f-c194-dda01bdaef6c@kernel.org>
Date: Wed, 11 Jan 2023 21:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221220185459.55950-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221220185459.55950-1-frank.li@vivo.com>
X-Headers-End: 1pFbBO-00DuPZ-Af
Subject: Re: [f2fs-dev] [PATCH] f2fs: update comment about
 f2fs_issue_discard_timeout()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/12/21 2:54, Yangtao Li wrote:
> After commit 4d67490498ac ("f2fs: Don't create discard thread when
> device doesn't support realtime discard"), f2fs_issue_discard_timeout()
> is not only called by f2fs_put_super().

Actually, it also comes from error path of fill_super().

We don't need to update this comments all the time, how about removing
this since it's trivial.

Thanks,

> 
> Let's update it.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
