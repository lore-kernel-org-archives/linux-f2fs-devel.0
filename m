Return-Path: <SRS0=pHl4=GP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9FAC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jan 2021 22:26:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8770F2312A;
	Tue, 12 Jan 2021 22:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8770F2312A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kzS7l-0000x9-GM; Tue, 12 Jan 2021 22:26:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kzS7k-0000x2-HP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 22:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q6wzpxQOCTd/vQeAHMZxZqjS+FCenUuYzwt2ycprd4w=; b=U+tzWCuBgW7oy5MN3qCBQlpzud
 1k4msDDx3wFV2B9dnfLu9p5c3DCYvCBZUCcKQ4LGnVEKifsDVS+XhmoEpsG4ZE1WjKNOC3nR8f6Ou
 AsWyeC3zD5LBiO1HXmTW3lYR3UH9QSAfr3a5PGBhiWZxvSYyRNAMFmJ3SfDRtxXLrcw8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q6wzpxQOCTd/vQeAHMZxZqjS+FCenUuYzwt2ycprd4w=; b=KEu7mUqIusVUqO57ANS6t3kScF
 IgJNeMCV6cyYoniMSfxJwiLSacPRUA1c20AJDXLgRZLVOyohchFjeJtgPUxdMcadT3MogP9r5oEDt
 sETwIhODsljWkXeXO/igmRrjPReYobNe3bAVMGVtIK50XfRLtzORTIx3dejdWax99USg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kzS7c-005Mdy-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 22:26:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFEE723120;
 Tue, 12 Jan 2021 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610490387;
 bh=HkIz0HpTUapVV/p2ZBv78OcW6wacEuGAa5TYmHSHkEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pYwOe9PAaRD+PIgNpxmhDDYFA6qj3cSaEw1CYzcu35JGayJ1VljKkvBMY6zBDQrB1
 S0kC+7kIM6G2I+OmPWrSbjrDwcYOMtKqdOimoSjKosrZ/Bq6JSa5Tdl0XUW2uVO6Tw
 fDr5YF1/GMnQhgQnngdx1CLEmSCv3/W/CN6nSZrlhIRMHZ1Pk0SqxQFLm82NHyje6C
 K2fVimwKy2yrYy4ysJCgODwEfAnBheJKq9qX8BJnOtz/oHHOwP0g4AYVayMN5nUnE+
 Wpv0jopRZTGgPf1qY3UmmILuSfQLPMGoY+mr9nQVQDYA1sNWu+oaQ0jOsT6Zbm46G8
 N4q7+sawLkvoQ==
Date: Tue, 12 Jan 2021 14:26:26 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <X/4iEjYU4+qEyA4d@google.com>
References: <20201228232529.45365-1-ebiggers@kernel.org>
 <X/30+5rc1bv39moX@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/30+5rc1bv39moX@sol.localdomain>
X-Headers-End: 1kzS7c-005Mdy-Dv
Subject: Re: [f2fs-dev] [PATCH RESEND] libfs: unexport
 generic_ci_d_compare() and generic_ci_d_hash()
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
Cc: linux-fsdevel@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/12, Eric Biggers wrote:
> On Mon, Dec 28, 2020 at 03:25:29PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Now that generic_set_encrypted_ci_d_ops() has been added and ext4 and
> > f2fs are using it, it's no longer necessary to export
> > generic_ci_d_compare() and generic_ci_d_hash() to filesystems.
> > 
> > Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/libfs.c         | 8 +++-----
> >  include/linux/fs.h | 5 -----
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> Jaegeuk, any interest in applying this given that this code came in through the
> f2fs tree in the first place?

Let me merge this. Please let me know if there's any objection.

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
