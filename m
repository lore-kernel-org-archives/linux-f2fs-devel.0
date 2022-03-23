Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF89C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Mar 2022 16:50:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nX43Z-0008Ao-AI; Wed, 23 Mar 2022 16:50:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+e62b50da79483f2da7a7+6786+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nX43X-0008Ai-Ax
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Mar 2022 16:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JNN7HWnFWy+fdeE99vwLpUXCXAGTZ1oVZ0UYC79jYwI=; b=RSHYQcqVDy2bmZn4DFKRi60z0n
 nlfuis+RBu+kYr4Rse8ZNfJR3LPZPvg72AzfW3GJCa6jsCOdFK+TKa+ZvTIgujoTVjDi1CohpTlSL
 BtTsnOj6ju7Q77O1VHRLeDeSnIhvlCJb+hKEftiJASuPR/7F5XwTjfH0d3RgRT4HABP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JNN7HWnFWy+fdeE99vwLpUXCXAGTZ1oVZ0UYC79jYwI=; b=ZdvGVeUjusap/BGDXp0hmKwOCr
 ZoKiv60PaeULbgE1DEhdPgEp01UTplmL0w8bK1PbQQvxCnHegRBjUCXOJ25E2ZSWpflUk8Flc6+d9
 CaoX+kjSpxkQnz9wsvMWrMDxBlN/oaqeCkUv1ix0Wn6xvYEo/0KLli4+3tIRGPpHZiGA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nX4BR-0006zO-81
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Mar 2022 16:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JNN7HWnFWy+fdeE99vwLpUXCXAGTZ1oVZ0UYC79jYwI=; b=HZnAuN0PFlLVL+0nwLA9rF7iCx
 QTZMAzXa44A28aJ4E1lm1Ev/IabTqLoDAYbT4GJh2dIQM2VBya9X8kLEkZhjc3GFEGJQn2S19x1O3
 MhkjFE9hWZ3RYOEctnK1JG4U78jJ8Wjv/x2njW4yc/tLhG332f5k0HENMAG+M2pYmDc73jDcdU/aP
 kK8vZOlPO6ULSgujCrYtcLtMlPUnW1dZyHgykrjrb+OkoHcNLlMZginWxjE5rUPu9z/A5wWIvw9rR
 ygJdIctADTBDEWiXE6y48sXVFxMSHza+zgYj43KTg/SqRSxjJvxXEimrMR4qUaSETg7rXZfjheDyj
 MQypegBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nX4B9-00EImC-3o; Wed, 23 Mar 2022 16:49:47 +0000
Date: Wed, 23 Mar 2022 09:49:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YjtPq1V7hbxc93aj@infradead.org>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <YjrNRpbo/i3tgbAA@infradead.org> <YjtPUec8jiqUXGuf@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YjtPUec8jiqUXGuf@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nX4BR-0006zO-81
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.18
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
 Christoph Hellwig <hch@infradead.org>, Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 23, 2022 at 09:48:17AM -0700, Jaegeuk Kim wrote:
> Christoph, I proposed,
> 
> "I've been waiting for a generic solution as suggested here. Until then, I'd like
> to keep this in f2fs *only* in order to ship the fix in products. Once there's
> a right fix, let me drop or revise this patch again."
> 
> https://lore.kernel.org/linux-f2fs-devel/YhZzV11+BlgI1PBd@google.com/

That counts as ignoring the advice to me.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
