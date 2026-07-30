Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19020C5516E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Mime-Version:References:In-Reply-To:Message-Id:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zhcavNjZ4seHeLbZWcnsddC3GhLixJ7wwj8O+aPCoWc=; b=TQMOGWY4F5P4EasaAWz1yYAOc0
	N0ANuQFzI+zqWBD8U3gRjv0SET5Ct2V1NgsO+sVu7NTCiXXi8eHeDddUUEcvlmlqZu/r0bkP9G8hg
	cEcItVj16xI0Y9Gk9qdjV2ejSH4KNJEJYgG9tEkozCMCvyg77X3Nu6mVeFkzl8qJsOxM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpX89-000391-CF;
	Thu, 30 Jul 2026 20:13:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <akpm@linux-foundation.org>) id 1wpX88-00038v-5h
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SYHnuwd5oBPShQry/A1IMV78wT87yQ12pmYbnlaWCNI=; b=iAGowxD/GMnPJc8Ckswd/0fIoG
 8pC/wM35tj2WnwvvUdYjcOd4zVIjmoDchA9kA2ZHhWRFeE9YY3JxRxlbGchEdt1uKR8bSPT297YD4
 GsojsTLniDxngDpfx+fMP2p3iW3NBtdAKTAehVMgEfjnOZe2kredQd1XL3vKP6zpP52g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SYHnuwd5oBPShQry/A1IMV78wT87yQ12pmYbnlaWCNI=; b=UR0MqT7eu7zq7vn7zU9iYGmZQB
 2ZjWuHSpPTKieOQlV9EV5cCbLdQ5X17Ft9eOfXW7BfOvp+rWnYiVuVVx0aFt+rIBdW4+ymCir7vsX
 wS7wigC7V0dlwfQvTWhBB4CFKJHQ8OSxFRlC20vWQzWGSZSb8J846m48OWLRYL/PWWd0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpX8B-0003i8-4I for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:13:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D05D41734;
 Thu, 30 Jul 2026 19:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE6C1F000E9;
 Thu, 30 Jul 2026 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1785441208;
 bh=SYHnuwd5oBPShQry/A1IMV78wT87yQ12pmYbnlaWCNI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=iJnEVe1voUvv8oU3L/LXlxlWg/TMzmxWX/p+WsY0i3YPuE5mFSEJ4cF0TMcimIXHY
 ghjBzhczgWPekjA8dP0c5k00yvs2tMguPZfnVAQ1KarieF9XzeUMVueazl7OX9zaeG
 yRbcWd3iB0SupGRkN7oe2OwtgLEhQG1wvVdm67wE=
Date: Thu, 30 Jul 2026 12:53:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-Id: <20260730125327.11fc9227d04f659a59136cdd@linux-foundation.org>
In-Reply-To: <20260730184853.48347-1-ebiggers@kernel.org>
References: <20260730184853.48347-1-ebiggers@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1wpX8B-0003i8-4I
Subject: Re: [f2fs-dev] [PATCH] mm/swap: reject swapon() on filesystem-level
 encrypted files
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
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Chris Li <chrisl@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 30 Jul 2026 11:48:53 -0700 Eric Biggers <ebiggers@kernel.org> wrote:

> ext4 and f2fs don't prevent filesystem-level encrypted files from being
> set up directly as swap files.  In this case, encryption is bypassed.
> 
> No one should be doing this, vs. the methods of encrypted swap that
> actually do work (such as swapping to a dm-crypt device, or swapping to
> a loopback device on top of a filesystem-level encrypted file).
> 
> Nevertheless, to prevent user error, make swapon() explicitly reject
> this case.  Document this behavior in fscrypt.rst as well.
> 
> Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")

Ouch.  We are going to break ten year old setups?  I don't think we can
do this!

I think the best we can do is to emit loud warnings which point the
operator to some Documentation/ which tells operator that this
deprecated configuration will be disallowed in, umm, 2029.

> +  Alternatively, encrypted swap can use a dm-crypt device instead.

That's tautological.  s/ intead// ;)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
