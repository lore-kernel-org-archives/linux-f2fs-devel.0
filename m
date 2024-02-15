Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB20C48BC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Feb 2024 00:24:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1raPYN-00034D-8J;
	Thu, 15 Feb 2024 00:24:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1raPYM-000347-40
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Feb 2024 00:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqiWnqSJgEtcos3fpiKxiMG+xfTegtN4gnquwuKmB/w=; b=ehFml6m9H1E/Vg6f7ZzrRTDECa
 +sDUS1RZFI4JO1R3cAuoYOs/Iq1PNbhZ5kb+ONa3PEoA+LVxXK2JhN0rqrrPk0hh3LLf7gpwNpVOx
 XmBUpYpRvvBfMV5Vg1Z0ypRWGdew0HQiriyyT1gHByGgcWr437rMGgBYjMtkJmnN+e68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sqiWnqSJgEtcos3fpiKxiMG+xfTegtN4gnquwuKmB/w=; b=EO1opL1uNf78vAIPL94cnahnqx
 3NQ5Dl7MmSEY9Y/WzUg8SNMQViq+oZXcC5fXc9tXnyEqCGQ3XiYv+BFK6RGPu7EZeQxA+rUwmANlY
 B9ZbpwKjzE37i8Sc2br0h1VFfhavqRGsmfV/v5tOkzYLGdd+UgHkJaWil6BdMlXPir0A=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1raPYJ-0006o1-ND for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Feb 2024 00:24:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F149361B80;
 Thu, 15 Feb 2024 00:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3713FC433C7;
 Thu, 15 Feb 2024 00:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707956665;
 bh=59cH34O2OWkKVZjG9GgdkKelHOHZV98dvK1VvoxsuNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrK5g6NegFC+QhqrQea4HSmqTdiC9Ka/gx0p2n7jiipIgWksWr24/0BVRwkNjluCO
 o/mA4cjWmL+WNNbSUwu1cH2syPViHbh7mITciDFdhaMCXuxgQb1c0suVhPiV7ViTp4
 ncP94sqOe852oIomjyUZT4yz5pxRVbglAV2iZOjOQHcF0MwWecT5ZK+kVShnJlfvNY
 OykMsWyj4W+fUb6iZ5pVyPKpNc3tVavEbiWfVhg9eOlNlmVArIP5dRJf6RCvhpaXDh
 oqcrmyOzsFiY7kqCA9BzFxTZCbrJRiQa6bzILtTeVdf4wv05i3k6HPWJd9IJH19vEP
 KMzA0kaGVqA3g==
Date: Wed, 14 Feb 2024 16:24:23 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20240215002423.GJ1638@sol.localdomain>
References: <20240213021321.1804-1-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240213021321.1804-1-krisman@suse.de>
X-Headers-End: 1raPYJ-0006o1-ND
Subject: Re: [f2fs-dev] [PATCH v6 00/10] Set casefold/fscrypt dentry
 operations through sb->s_d_op
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
Cc: brauner@kernel.org, tytso@mit.edu, amir73il@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Feb 12, 2024 at 09:13:11PM -0500, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> v6 of this patchset applying the comments from Eric and the suggestion from
> Christian. Thank you for your feedback.
> 
> Eric, since this is getting close to merging, how do you want to handle
> it? I will take patch 1 through my tree already, are you fine if I merge
> this through unicode or do you want to take it through fscrypt?
> 
> As usual, this survived fstests on ext4 and f2fs.

I think you should just take the whole series through the unicode tree.

If I understand correctly, this series is really about fixing things for
casefolding support, not fscrypt support, right?  There is a lot of interaction
between the two, but ultimately it's casefold that gets fixed.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
