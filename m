Return-Path: <SRS0=XdgK=HF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E8C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Feb 2021 05:22:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948D864F68;
	Wed,  3 Feb 2021 05:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948D864F68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l7Acf-0001ty-4w; Wed, 03 Feb 2021 05:22:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1l7Ace-0001tr-7L
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Feb 2021 05:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oo77zX9Q/7BN6qsuB16TwQ/R27aFvS9NDa0u1/2p4kM=; b=V9kHTLRlfYKbft1MhWRHXt174p
 rRHoYKK8WYJ4ZiP0E5fn+ub0431OGWd3DvUTk9qoWiyfparD8teF9KItsW7d+T0UQoqNYO74EGiOn
 vMtLw0FkBhUqAzfGkdSqGv7Ido/pM3JjSui4zB/Yl37mqGOJ3g4THLVVneaIR/g2cZaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Oo77zX9Q/7BN6qsuB16TwQ/R27aFvS9NDa0u1/2p4kM=; b=XK1Aq7d/ZiNRuYYssykYkCx8gK
 BQ92Q9ouARPiqWB9Ue6UGHc4z6K7AU54zRh/YOkYkteJo0mAtpKvvx5p8wuMpwb2ZOrvEg+CnqF0i
 gqn0nhCx79LDbwqUBp/F7AIdVFi4kd8RAGiPjKmP7LFlP/ZturfNvoWlhJ4SsGRcocvg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l7AcX-000Kn3-TR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Feb 2021 05:22:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DCBD64E24;
 Wed,  3 Feb 2021 05:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612329738;
 bh=cLNqVKFCW+BN80pXVHFeKzr4oNTwQ9E0KfoXAi7zrIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aaO5bxjyzzw4Vmr+uTv4uCsf/zpdHQr4gp8MCzgkAGOsj90nf+8Oam6AoppLSCIz9
 k10PqVSkqMADuT3ByUx3l1QLCUZj+BDYyGHCPNqHu4TkbMvU4I50pinhH6nAF/5lLL
 W1voVC4IyjK+pvUdKyjcCaFAUEDsJMcD1DwFKACXP81UwQ1sznnELlVsK+LzzjMT+y
 m0UpuTHHJetNKJwrqadmF/jaBH9pNbesr38OjLVoo1wWqOK3O3qFVk9ryn/2qHgOf/
 NZ2//TuHHKXad0zqMT4I0L0UzRyng5NrMy5nuNUcUqlTHs58RBTLh2YwG7Nmf6wpdL
 35iiURpKWp4Fg==
Date: Tue, 2 Feb 2021 21:22:16 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Message-ID: <YBozCMnv1BT8ZyXG@sol.localdomain>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210111151517.GK18475@quack2.suse.cz>
 <X/y4s12YrXiUwWfN@sol.localdomain> <YBowmPPHfZUTBgz1@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YBowmPPHfZUTBgz1@mit.edu>
X-Headers-End: 1l7AcX-000Kn3-TR
Subject: Re: [f2fs-dev] [PATCH v2 00/12] lazytime fix and cleanups
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
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Feb 03, 2021 at 12:11:52AM -0500, Theodore Ts'o wrote:
> On Mon, Jan 11, 2021 at 12:44:35PM -0800, Eric Biggers wrote:
> > > 
> > > The series look good to me. How do you plan to merge it (after resolving
> > > Christoph's remarks)? I guess either Ted can take it through the ext4 tree
> > > or I can take it through my tree...
> > 
> > I think taking it through your tree would be best, unless Al or Ted wants to
> > take it.
> 
> I'm happy to take it through the ext4 tree.  Are you planning on
> issuing a newer version of this patch series to resolve Christoph's
> comments?
> 
> 					- Ted

I already sent out v3 of this series several weeks ago
(https://lkml.kernel.org/r/20210112190253.64307-1-ebiggers@kernel.org),
and Jan applied it already.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
