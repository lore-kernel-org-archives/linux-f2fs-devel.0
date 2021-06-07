Return-Path: <SRS0=2MSU=LB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE6C47082
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 16:57:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6618460FEF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 16:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6618460FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lqIYi-0006ez-HG; Mon, 07 Jun 2021 16:57:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1lqIYh-0006et-B3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 16:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=52/GWSBN1UwFa6xE59omLI1rMPSBTMtaO8M8MiUFyNc=; b=MeEtWonH5OoregH5K8f1OJM3om
 L3591JCoEV4mLoJNZPS/Ulr37RadCg/T0llNik2GSMm0V91dBmqYIp0hbFORlW/ESRKfG2QFboaDj
 dcvB9k0HwiP8uTWMmx5tq7t0/J6UvxxWWE4dMQHTbD2rEtPdIYL86O56nW28yuZbDixw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=52/GWSBN1UwFa6xE59omLI1rMPSBTMtaO8M8MiUFyNc=; b=Br9+maaePFw32tmugSqIkrjbD5
 k0ZO1DgjVhgzp/UZzizmw+tX+j4AeM3wbDw7ONnM5lpaOM4018kNHAT0/CGfAtI0ek8Ow1Mp1y8Ua
 LOYP25oXfQd1D01/URDsuvE/Bd4qBI12gMFszfeieS97CwV2dnRXjW2O71qSVkonszHg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lqIYf-00FWrQ-Uf
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 16:57:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D28260FEF;
 Mon,  7 Jun 2021 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623085016;
 bh=CGWwZ0B5Yt1bOk3aGjgmlwf36RYxJNKPqpmqpOCx2xQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a7qpuDOqXRQve/5XFZ3bapJKWyjEaAzb6CMJ8pbZGuLRO5/ziVBb1+mPln5cRRDfI
 jp7BTihHnEOa8KvFsbNQ1qUnvo4ldXoQE3czUsQ+1m7qhpmX2Ui6gfY5Y/poW4aNa4
 jDpRgfokaYMOemsFzkgSkzLhAgl7KsIasxfuN2mLYSSEQLPI0fnauTH6IQWPHI6sKk
 5UHx7m/X0oAmsUCEi2s4CPoo4ew7wHnpHwRBX7DiMYcEA9T/ZTBEKc0NqpiYmC+Ptd
 84ObhTkO5/3wPiknxN1fioWhetPDUpUlA0CzhExmfc9/XKQocGr0eRRzlZzrWg5K9C
 ZF4/JSrECc47g==
Date: Mon, 7 Jun 2021 09:56:55 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YL5P15nLsc/3GQOY@google.com>
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
 <20210525204955.2512409-2-jaegeuk@kernel.org>
 <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
X-Headers-End: 1lqIYf-00FWrQ-Uf
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED
 instead of using IMMUTABLE bit
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/06, Chao Yu wrote:
> On 2021/5/26 4:49, Jaegeuk Kim wrote:
> > Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
> > out it disallows every fs operations which we don't need for compression.
> > 
> > Let's just prevent writing data only.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> BTW, we need to expose .i_inline field to userspace since there is no
> way to check status of inode whether it has released blocks?

Need to add some in F2FS_IOC_GET_COMPRESS_OPTION?

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
