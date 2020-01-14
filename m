Return-Path: <SRS0=YoBC=3D=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C2AC33C9E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:32:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E8E24656;
	Tue, 14 Jan 2020 21:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JIJdVojk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IUYqOdD5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgTXs4Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E8E24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1irTnt-00028b-Jn; Tue, 14 Jan 2020 21:32:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1irTnr-00028K-EX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jan 2020 21:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=61GVDQ3XxFLelk8BddLFfb8qKhQzL3u3wnnLZ2ljuhQ=; b=JIJdVojkg5kVz84dl/qaqDaZZM
 Ick7kaeraKoBHqNh+lTfqyM8zNujgFeWdo6Rt8a+ZO2hN1MHBFAzGDaNpVVbU0LNCBj655dFx8u0I
 X7oh1hF/zQSCILQFDgUT0CIbkkwatDvljcESiooUvcD6VB/wT/Juqvsi1yRe7V36K4oo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=61GVDQ3XxFLelk8BddLFfb8qKhQzL3u3wnnLZ2ljuhQ=; b=IUYqOdD57cpLLBIC7iXat6TYLt
 6faFy6NGyz7ZCPBTyntIYOT9Ci3c++lZjNrk3HTeccVrfFOeBQQ5fA0D49+m32ObQKo8WyGCm8ruS
 fXBA/bp5joNvGf4Cb9ImR1wIOcHkcov+HWg1iRAfHSLsVH2HF/y7qDIrw3IFNtRvfC4o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1irTnq-003T0G-CS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jan 2020 21:32:47 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B43F324656;
 Tue, 14 Jan 2020 21:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579037560;
 bh=dozMZNZbwXQXYTYPrlUelgfZm/+WwDTPJ1CePGDuCLQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tgTXs4Z4uC5Ug2qyrWa7r3M9ydC41IjJUg9yRfyWTP/ou74LzDuWMdSplppsecIW/
 Hw1b0cCk+aM8F/+EMk182zPEoSlJ5ZTI4BVX+6MCrJl1m0XX7m0hlibGuBUr/ki7fx
 bTZkvkfKhcpchpyHoBwPtUcVtKtY7JDfT0KJzTjU=
Date: Tue, 14 Jan 2020 13:32:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20200114213239.GI41220@gmail.com>
References: <20191231175545.20709-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191231175545.20709-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1irTnq-003T0G-CS
Subject: Re: [f2fs-dev] [PATCH] fs-verity: use mempool for hash requests
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
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Dec 31, 2019 at 11:55:45AM -0600, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When initializing an fs-verity hash algorithm, also initialize a mempool
> that contains a single preallocated hash request object.  Then replace
> the direct calls to ahash_request_alloc() and ahash_request_free() with
> allocating and freeing from this mempool.
> 
> This eliminates the possibility of the allocation failing, which is
> desirable for the I/O path.
> 
> This doesn't cause deadlocks because there's no case where multiple hash
> requests are needed at a time to make forward progress.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/enable.c           |  8 +--
>  fs/verity/fsverity_private.h | 16 ++++--
>  fs/verity/hash_algs.c        | 98 +++++++++++++++++++++++++++---------
>  fs/verity/open.c             |  4 +-
>  fs/verity/verify.c           | 17 +++----
>  5 files changed, 97 insertions(+), 46 deletions(-)
> 

Applied to fscrypt.git#fsverity for 5.6.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
