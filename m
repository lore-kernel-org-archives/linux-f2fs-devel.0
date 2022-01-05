Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9368C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jan 2022 18:26:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n5Az6-0004XN-58; Wed, 05 Jan 2022 18:26:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1n5Az4-0004X7-ST
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Jan 2022 18:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i61rJkp8ZcQVKuSe8n0rmSZwoCxJCb8TqfKFL5CE3Dw=; b=j7A8or2mCNN5J0XyNMa5VTLjtF
 YuB0or+yJPDKXXU2NKkSOBZzoI3ybTuKqKTvufUOEuyWKJOGXjoYauIjCtUqp4P/tVm7tRicaj1PO
 yeWMN3pd6Gp8v2NXvAqqFXS3UXARDiacmi/fXMW+Kl5rppRU2ER3rdXqkdDd+Pat0tYU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i61rJkp8ZcQVKuSe8n0rmSZwoCxJCb8TqfKFL5CE3Dw=; b=fqg8xgMvKmf4vYGhzN0HJHdXgj
 wh/p9qeYqxvOBNFWwWaUlvG5Gg4tljsiSCCvvjP5LvHbZxrBRR3C7ajzd13XlWupAV+EB5UiVyyu0
 Kc1GYv8ew7aREdtK0Fv5m4FBfl9Yai4Fcm80xVbrusFrytbaDEpYNtvDJ29xfxFRBrho=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n5Az3-00043x-6y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Jan 2022 18:26:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D2AB7618A2;
 Wed,  5 Jan 2022 18:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B5DC36AE0;
 Wed,  5 Jan 2022 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641407155;
 bh=etvQ70B7VTyNu3V0pWf5jfwy4CPdXh6nZhHM9S06xJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fpv2cfxgNNW+9zQL2AZr2bFdBg+XEAAXfZYz2uGazv2p+34UlA0W4MPGQb46zLyhX
 Ym1/IzchYFOOsi2YeKfAIhvk/m9Yw7Bm2M8EJ+o+4KScr+dpT+AJbjLJBrCZLB0OSm
 MMGI+BR9JcBv3QksGbKifYRFLdABA+LJrreAxsgN1HWfdoj12b15r3xg1vL2uSUdjB
 u9B32MxzoqScoYrKWJft1WmKAhLOqKoOMz7hnX6VgNboUvfa77kPntunlq/46JFYZ/
 wcSd1vCj7JlYtRhEH7TqosDdL2oKmwfTiI0ZyLKrDOpHrMMsb+WKMIdNEfF+AbZN3a
 vFCGgAKCPK5OQ==
Date: Wed, 5 Jan 2022 10:25:53 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YdXiscxIceQWw2ZG@google.com>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-5-jaegeuk@kernel.org>
 <f8c0d9f8-6a1f-e7b7-4dd3-fcd31272a0df@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8c0d9f8-6a1f-e7b7-4dd3-fcd31272a0df@kernel.org>
X-Headers-End: 1n5Az3-00043x-6y
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
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
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/05, Chao Yu wrote:
> On 2022/1/5 5:24, Jaegeuk Kim wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
> > use iomap for direct I/O.
> > 
> > Note that this may be used for other things besides direct I/O in the
> > future; however, for now I've only tested it for direct I/O.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Ditto. Thanks,

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
