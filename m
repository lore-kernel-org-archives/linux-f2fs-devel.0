Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EB7C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Apr 2022 18:23:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhEzK-0000Ow-4L; Wed, 20 Apr 2022 18:23:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mcgrof@infradead.org>) id 1nhEzI-0000Op-TQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Apr 2022 18:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zE8KK/ZJ3Iv3wH8L3ZgIF2nIKkuafTKaaZyrkHoZlcQ=; b=lo8jO7uyKj3iGoYZsdF+D2q/1y
 aBpiLUQEGw6m6H0m0ghyWI1pd/2Q3ehRfSrKYzsUBHUD67Ql1UarqJwctrupgPf73OGbqSgbV34d2
 swQswkgbmcC2bLWvWZ3OFBA2frfS8ZBfpCJQ5+nNSrd07ypwwjAQfaOH1UjgpI+jVYSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zE8KK/ZJ3Iv3wH8L3ZgIF2nIKkuafTKaaZyrkHoZlcQ=; b=VtOWq/IY3B72qHy1TYjltD3ieK
 hvCVRET5MZcQjcs2LP5hHQP+JTQdNNi2kSaQRcxqDpicBbJq9oJIIMZLfofNKA9dwdPoMCAwwqoI+
 jQEao/lX21Dad+U2OqxHu2vL3+7NW4STk/+ku6esJ9tXiR3CI8QegnttDf/6bFIgR3YU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nhEzF-004vAx-4R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Apr 2022 18:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zE8KK/ZJ3Iv3wH8L3ZgIF2nIKkuafTKaaZyrkHoZlcQ=; b=T4T4GLJeE2V2UZwuxU9t3cu9Kc
 nspj1teJ3f0dQULXHnKoxHdcBPiLfue0Vw5C9jj88qlFQj/SxgzvvNTCS8FdF4Ov8rgc3n3C3boGL
 vzJMBXU5CY+wSrgUbCEIuVwSRzdwkwNOvv+UY/PwHj5lHMPEx7KxEy48HLL8RPBP5/a8bm6qtNEVg
 fK9ixbIPjB6WQRiDwo+P4iV+hrrHQbpkbyDCxSqQZPy4fye2GYjomdoo2stxIS+Nn8vO9zkRwLBdL
 X9h90ARD8AloAmIT09G0matE5NTacd5F9J0vcdZwqDe1+n7caiAt4nOQ4qOtSYEh05VvRydG4zYVE
 jks5QL6w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nhEz7-00A2nw-Pt; Wed, 20 Apr 2022 18:23:25 +0000
Date: Wed, 20 Apr 2022 11:23:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YmBPncG/AsN/nC2O@bombadil.infradead.org>
References: <CAB=NE6U7AnJf3_eHG_ZmVA66YfjH4rT+7dYiHgEurArpQS489g@mail.gmail.com>
 <Yl86tKxvBN6lHoma@google.com>
 <CAB=NE6W3r_O5L30pPLJ9s12ahfBGvudFAKyLbO_1=JCf2bDTkg@mail.gmail.com>
 <Yl8/2cPCkSZ17hxN@google.com>
 <CAB=NE6U+KbnFPd+EYEhXxF7o4DSB58k-uGevC6y1h2SSE2sbtA@mail.gmail.com>
 <CAB=NE6X8e48pvKd+4Ms3c89gcUzh58Nd-n_xxyD5HRkEGbks3A@mail.gmail.com>
 <YmBNEdDRJiGcruiT@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmBNEdDRJiGcruiT@google.com>
X-Headers-End: 1nhEzF-004vAx-4R
Subject: Re: [f2fs-dev] Baseline for f2fs
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
Cc: Pankaj Raghav <pankydev8@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 20, 2022 at 11:12:33AM -0700, Jaegeuk Kim wrote:
> On 04/19, Luis Chamberlain wrote:
> > On Tue, Apr 19, 2022 at 4:26 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > Oh... so this is not upstream...  I see.. ok hrm..
> > 
> > Any plans to try to upstream your delta?
> 
> Not for now. :)

Why not ? :)

In any case I can *cake* in a custom git for fstests when f2fs is selected.
In other words, I can add support for this hack for kdevops for f2fs, but it
sure would be nice if that delta disappared.

  Luis


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
