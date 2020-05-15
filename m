Return-Path: <SRS0=D49P=65=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899FC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2020 19:13:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3413B20727;
	Fri, 15 May 2020 19:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Zlx3emWl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mnOZ32mt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1HxKyRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3413B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jZflq-0007ec-4v; Fri, 15 May 2020 19:13:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jZflo-0007eU-OC
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 19:13:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6AlF7r8qzheY7AE1PoL8SJ5w+O4w3zc6yf+frt5GDbw=; b=Zlx3emWlgdf7xpXJCUQZIwRqFc
 vMntDt+bUYvlXLm1EAVnx3RFRyMmAf99HmBNlgQUizQ5iexVoMBYJ+fy6P0pmRBbS4YZqoNl0pQ99
 mAQNlFaS639+M8OvZJbR4pqfH9Cn/an532tzVtE84GGNLTzh0mYZNtoL+mFWgykUIx/w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6AlF7r8qzheY7AE1PoL8SJ5w+O4w3zc6yf+frt5GDbw=; b=mnOZ32mtj+5yjzLSIyVRjLUUsE
 6zJbXAX5COMpl79FCLMo81upCympymTOQc50gww82Dlj0lJjfwFM/+m7ECtkuMIIT57wrnFFzT00U
 oAt/gLEy6kyahuD6dJJ3vCSgl4QhMuaGo3LdAfnynw50cAJ+64/bJEAkBipnJU5bO05g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jZflk-00C1pD-AG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 19:13:20 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0DCC720727;
 Fri, 15 May 2020 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589569986;
 bh=KJkgdLjxG0bP2FoboUYZz12iyA8epSzyHBX+8dMqLQs=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=V1HxKyRaZbGzNbSrE7JLV28G71Lu4DRCD1bXmBjfU3kJtwbAVxE2BzLigVoVhG1nN
 WxnLzN2dXV8nPUypI0dNnVSzyLhTdM7JzjNY1fCgh8jndI5UbDi+m1ESma4Q8iS+u+
 vks7iA1mssyLCvp5aagVGTmKKJ2nlQP5Gr0hU9VI=
Date: Fri, 15 May 2020 12:13:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20200515191304.GB1009@sol.localdomain>
References: <20200505204823.211214-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200505204823.211214-1-ebiggers@kernel.org>
X-Headers-End: 1jZflk-00C1pD-AG
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't return vmalloc() memory from
 f2fs_kmalloc()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 05, 2020 at 01:48:23PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> kmalloc() returns kmalloc'ed memory, and kvmalloc() returns either
> kmalloc'ed or vmalloc'ed memory.  But the f2fs wrappers, f2fs_kmalloc()
> and f2fs_kvmalloc(), both return both kinds of memory.
> 
> It's redundant to have two functions that do the same thing, and also
> breaking the standard naming convention is causing bugs since people
> assume it's safe to kfree() memory allocated by f2fs_kmalloc().  See
> e.g. the various allocations in fs/f2fs/compress.c.
> 
> Fix this by making f2fs_kmalloc() just use kmalloc().  And to avoid
> re-introducing the allocation failures that the vmalloc fallback was
> intended to fix, convert the largest allocations to use f2fs_kvmalloc().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Jaegeuk, are you planning to apply this patch?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
