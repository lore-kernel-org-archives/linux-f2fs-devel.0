Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991E9C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Apr 2022 18:12:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhEoV-0008CI-Qs; Wed, 20 Apr 2022 18:12:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nhEoJ-0008C5-Tu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Apr 2022 18:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=igYFGVwUtMrYFtCOVyOEziT54htNgcX7DvW0MJFZu8I=; b=AclzPMscMHD9UU3qOsrVPcAnoo
 y8zvsJ2b04u1dPJ3e07TYSLzP9DVO4f2zKKwtEvlN9ATIqTWlULg2wn+kwZhm73R/LpG5P8ak9KqZ
 R0g+uGBpBeFJcw3717E0waGLfFrOuT0LoR3f1SrQ9F5ZBzBIDMqY8FGoqcKNbJnlXAIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=igYFGVwUtMrYFtCOVyOEziT54htNgcX7DvW0MJFZu8I=; b=XQAqdb5/cUIT7KdgJUm7YsaQNs
 LRpTH2oGkgrmd40vezDjL2JOitolhJYcvGHYQOClPOKgvr82dj0iO1h6TH28lBXQMYjG5kDGr9kE6
 0JvNh7IYDTI35lFMqpp4C5p6qtWH5Hk/ay6XafjyI/sv3VkLM4Bbwdpf+k0d53qJV4fk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nhEoG-0006Nx-7w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Apr 2022 18:12:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CEF5D61B4A;
 Wed, 20 Apr 2022 18:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A071C385A0;
 Wed, 20 Apr 2022 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650478322;
 bh=NTy9pFDWRuCUyy+uRS6JtLFaKO2Z2cLw81UXIFC+Vr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DdBFOPQKPs5WI1dCKZuS5WAuu77VokqeMbZM5eTxoTWfi+tZDeOdFOBl/exLtmrE/
 50q2oNjj7F2e547EfrKKG5jMin0+lWpjlUGv65p3WMbp3NxnN+tk1WAmotlyvsci+P
 kpnuCskiQbDl7HubYrAeF9HUiDZ6c0hdK29vtZaTebAxvE9p6AHY1c1D/a3YeV5SRG
 kYhJ1SmaMyOEyQ/InoqZjNrwLMzvIPqbd5onUlptLNKS1zH2vd+9j96oX2K2sriXKe
 9yIuO7woiJuruLrI5YjaQ/C4LMguzLYyex44KpqiW5QPHpUEzKgjspdeHTljRuOuK1
 2oxBEZtax11BQ==
Date: Wed, 20 Apr 2022 11:12:00 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <YmBM8KEZ9JttevxH@google.com>
References: <20220419215703.1271395-1-jaegeuk@kernel.org>
 <Yl+XIjiuFRN9Pzxv@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yl+XIjiuFRN9Pzxv@infradead.org>
X-Headers-End: 1nhEoG-0006Nx-7w
Subject: Re: [f2fs-dev] [PATCH] f2fs: use flush command instead of FUA for
 zoned device
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

On 04/19, Christoph Hellwig wrote:
> On Tue, Apr 19, 2022 at 02:57:03PM -0700, Jaegeuk Kim wrote:
> > The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
> > command to keep the write order.
> 
> The block layer can reorder all commands.  Given that FUA only affects
> the command itself that should not matter.  What is this trying to fix?

Not for zoned disk, as I mentioned. The mq-deadline serializes write commands
but I got an reordered command, if there's a FUA|PREFLUSH command, which emits
EIO by the disk.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
