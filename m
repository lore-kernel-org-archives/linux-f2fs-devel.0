Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9E1F94CB4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jG9DR15Y7twjonM89l7zkaIVCRsIhu+NYFQo2pAS900=; b=N90vPZ8/JPowTpMp07OpP+HNaP
	3Ubg694MMBqfsrl4KwhSZy7zfWmb/M+LKeHsCDuoo/R1Jx8njz0h8n9gPfbWLNUDLWJnZNl1xr8yk
	Gopxsp707Vurt+FRZEGyDq68H4EF2xdk8nuIjG1xDolmBgCOwFD6pZsL1GWfXvgBaJa0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFIsq-0003Jb-Mh;
	Tue, 21 Apr 2026 21:43:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wFIsR-0003JF-M1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Apr 2026 21:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hRgOQqLI7Kw923W5cr2FIVyM7ndG1mvX/V8EzHi04mI=; b=Q/Az5dIg5+Tu0kvvTBxuXnFVWU
 EQGzXuD7+e6On85NU8EuPsriUJXVuma0a5vA6UkK/S5648R8ziMCsW9pjvhX964gtU1+r0dR6lLrX
 kchvOCl7U5y1NxYruvstqoWSKhxoMMcACGLiRCHfU4HprX1Pc/w63AAymmv3pmcFPda0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hRgOQqLI7Kw923W5cr2FIVyM7ndG1mvX/V8EzHi04mI=; b=FXQCR+UBThXYyRs2CoUZ3f8HPU
 PCg53ysusUDgmeLjvPbGnYwxDjii1zesNq8zfRzFeXftr0hc+shVlCyGBda6Q1hjgrUogArs9ms7+
 UKssS/XLaMnNHP7lTTG5NGhFzl3n4b1YqMogjc7KxJMD9qnaAU/7LWoJBTGciRqtN2yk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFIsO-0005I6-N2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Apr 2026 21:43:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5561343A36;
 Tue, 21 Apr 2026 21:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C101C2BCB0;
 Tue, 21 Apr 2026 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776807799;
 bh=pTUFlPVgh1+kKopP2/8EcrgMqvKTDIazFWCbVyb/saA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CZ1aTAqAp1DEuzXkk0YqoVGbSe2TJWO8OccQjAcTgtpULImuh5vd77WIS8fsUBFLU
 pehzx/xLhYFe0qDouKUWtfNhbxtxepJP8/ohbkYcuPaS22ZBh3uOy6Lh9tH1yGN/Sa
 J477aufpJhJI/psggvY6BwSD4k1A98xHSTBmBd3PxoXhG7Jywoe+9dlHh54LR5JUIK
 3B1NE2LPeKjckp/cG6y2sBPmamM6lJCVxbA26kpl5Py3t8n8XpGdABBZds0KN3tEIt
 bA526D0GvlEaZ/wQWDQMW6ywPQLY8/g5M7BARF0Q6pvVKJw/SxAzisuOVY8cLvfjyK
 ljBDrZ5Dw0u9A==
Date: Tue, 21 Apr 2026 14:43:16 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260421214316.GB37143@quark>
References: <20260420114714.1621982-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260420114714.1621982-1-aalbersh@kernel.org>
X-Headers-End: 1wFIsO-0005I6-N2
Subject: Re: [f2fs-dev] [PATCH v8 00/22] fs-verity support for XFS with post
 EOF merkle tree
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 20, 2026 at 01:46:47PM +0200, Andrey Albershteyn wrote:
> This series based on v7.0 with Christoph's read ioends patchset [1].
> 
> kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/aalbersh/xfs-linux.git/log/?h=b4/fsverity

FYI: the git repository doesn't match what was actually sent out.  For
example the patch "ovl: use core fsverity ensure info interface" is a
bit different.  The version in git (incorrectly, I think) ignores the
error code, while the patch returns it.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
