Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4541DCD11C2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Apr 2024 19:07:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rsou0-0007ZY-1F;
	Fri, 05 Apr 2024 19:07:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kent.overstreet@linux.dev>) id 1rsoty-0007ZR-7r
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 Apr 2024 19:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xy7rrQFx/ai4jiHF7erHWLhfU4NiOdULn/JTP2Sih9s=; b=VEGSRG0lTovWmvc0/JJIkJZziG
 YiHZmBM5mc2WJ74BLkalvscCoYhaxIbnG+X4f2OKZZP7sTmteRoktJxgt+GUy682PI6myq8597Gk0
 RX4SppHokrVHWMlr3L3rwfUu45mvmh0inrt0hCgPzxwuw5CKFXglBMD3kV6BwHNXuofg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xy7rrQFx/ai4jiHF7erHWLhfU4NiOdULn/JTP2Sih9s=; b=j/1XNuACE0UyhzVKeYqVjXCYNU
 qcq3vYgREUvtLhqc9/KP07tp6bi0Ah4zXEfUjOJw1maAn1DMoJtKIiH/o5cRyAeKBR7nJNcFv9B2E
 uUErc4yozCwfKkdk6nnbLANXF1A360xF68/2rkVQUOckv8qDLHGk6+CYoiHQXGAlF4xs=;
Received: from out-183.mta0.migadu.com ([91.218.175.183])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rsotx-0008On-0h for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 Apr 2024 19:07:02 +0000
Date: Fri, 5 Apr 2024 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1712344009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xy7rrQFx/ai4jiHF7erHWLhfU4NiOdULn/JTP2Sih9s=;
 b=HZ97vexPrKySNDCOlz9qANDAP2JyhZBo/XKrmr+lyOE6CHkjHxJYL3ItLuk9OGrZpDRot0
 Q2UlJMp5dDfEit2UE6bzXAAdCDy+AAHKq7O1YfadBIDO1LT0kCLSqROgs2CrC0IoQX2GA0
 sxKvTykI3035G7lRq82NPDS2a99O47w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Message-ID: <3bvnvw5lvlraveup3du7esp3v54wissngudpov3xzneajo2fji@hbqk52z2xp2z>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
 <BDD29EBF-3A5F-4241-B9F2-789605D99817@dilger.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BDD29EBF-3A5F-4241-B9F2-789605D99817@dilger.ca>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1rsotx-0008On-0h
Subject: Re: [f2fs-dev] [PATCH v3 02/13] fiemap: update
 fiemap_fill_next_extent() signature
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
Cc: linux-bcachefs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 kernel-team@meta.com, Jan Kara <jack@suse.cz>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 01:05:01PM -0600, Andreas Dilger wrote:
> On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy <sweettea-kernel@dorminy.me> wrote:
> > 
> > Update the signature of fiemap_fill_next_extent() to allow passing a
> > physical length. Update all callers to pass a 0 physical length -- since
> > none set the EXTENT_HAS_PHYS_LEN flag, this value doesn't matter.
> 
> Patch-structure-wise, it doesn't make sense to me to change all of the callers
> to pass "0" as the argument to this function, and then submit a whole series
> of per-filesystem patches that sets only FIEMAP_EXTENT_HAS_PHYS_LEN (but also
> passes phys_len = 0, which is wrong AFAICS).
> 
> A cleaner approach would be to rename the existing fiemap_fill_next_extent()
> to fiemap_fill_next_extent_phys() that takes phys_len as an argument, and then
> add a simple wrapper until all of the filesystems are updated:
> 
> #define fiemap_fill_next_extent(info, logical, phys, log_len, flags, dev) \
>    fiemap_fill_next_extent_phys(info, logical, phys, log_len, 0, flags, dev)
> 
> Then the per-filesystem patches would involve changing over the callers to
> use fiemap_fill_next_extent_phys() and setting FIEMAP_EXTENT_HAS_PHYS_LEN.

Cleaner still would be to just have the callers initiaize and pass a
struct fiemap_extent instead of passing around a whole bunch of integer
parameters.

You get more explicit naming, better typesafety - functions with a bunch
of integer parametrs are not great from a type safety POV - and you can
add and pass fields to fiemap_extent without having to update callers
that aren't using it.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
