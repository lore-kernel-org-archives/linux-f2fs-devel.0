Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB47DCD98E3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3X0gIV08OSORLh2ZORj1NrVLwedGCwbMRDYeZ/K+6ZI=; b=gnBWckZ/Zggxzp0vnTpLKvI8hq
	uAtqMvXcvGJ/X69/K5YP99I2BYTaHWTOeg2+JYnDEkej8d1zc5HG8xqfHSOauog1OtyRcdOSzthjp
	LVKBoVgHl13U62+6LLnKji1LLuR8hR4hUTcL0sxyJsMR/jHXsg0RRuLw0abYl8st1qAY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZMwY-00006g-6R;
	Tue, 16 Jun 2026 06:06:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wZMwX-00006Z-JT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 06:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8skaFAn8iWz1oYQUx+F0nQwHC7XAZ27/HYL8nRZKzuQ=; b=SzY+Aov4ColCcDQreJhphPnWN8
 bYY0+IsC6ugNsQOAslqnCrtRwoErIrPf/0T4MdD4ZGsPDy27k1NRGg7Djz4mZr8olngYKqDl0X02T
 wOuHQoVeKWxiXWpcaCAKt7XN9QaynmVwMs7HiSTHRT5o67Cy/YnPtXxUomhNNFxpjBLg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8skaFAn8iWz1oYQUx+F0nQwHC7XAZ27/HYL8nRZKzuQ=; b=nOWmpl6cGF0QRAjy/Zs6Psd3Mn
 LJ3Op2z21T00QpTldOld36LdgkK520AbHAkvhdcZJk76AtsK6/ovIiCh2NAuvVTrQQLWI/8lcHuVO
 QmYMjnNL+6GhbuAEmfqt/7RXr8NS30TI1RrcXWNQXbBoKA7cIEl5uOE84Bbp3TPnWO7A=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZMwS-0006b3-Sl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 06:06:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2E6F4354E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 06:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6AA1F000E9;
 Tue, 16 Jun 2026 06:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781589987;
 bh=8skaFAn8iWz1oYQUx+F0nQwHC7XAZ27/HYL8nRZKzuQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ys0gv1AsAR4Uu3fqzwbinne90Nsc6ytcdAegYIFHH3MqIo9dEcl0IAYzI2+5NUTha
 jbC1oYuQbv7dXsIvyRDVZAzknrhNxJDmS2vReOFJNux9OT3wGyxEjfuoYs2O1egBqs
 uOHca+WBtXUzVXsjjxZEOQjIw8KIjYOXbxnxnSbHzx0jDnMyAKrUOsqz3h3ay3/Pa/
 VYd4OGq+htQsC3AWEoMwBuSDeyJQTTpkyY0UcjI8fxmfWWxgCcCsvmxVIz/BpzTf1j
 KHDAcR0z9uM25x1tobgF5QFTrhID08i4hfGtNXyJgOf/fwoffLPfrNcBaJdivwAaE8
 4yJJLfGoVGLyQ==
Date: Tue, 16 Jun 2026 14:06:21 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <ajDkil_W3kK-jW8c@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260615090558.1627456-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615090558.1627456-1-chao@kernel.org>
X-Headers-End: 1wZMwS-0006b3-Sl
Subject: Re: [f2fs-dev] [PATCH] f2fs/009: use common _scratch_shutdown helper
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: jaegeuk@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 15, 2026 at 09:05:58AM +0000, Chao Yu wrote:
> f2fs has supported ioctl(_IOR ('X', 125, uint32_t)), so that
> "f2fs_io shutdown" can be completely replaced w/ _scratch_shutdown(),
> let's clean up in f2fs/009.
> 
> Suggested-by: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/009 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index fa4a39d16..39a4bad3d 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -12,6 +12,7 @@
>  _begin_fstest auto quick
>  
>  _require_scratch
> +_require_scratch_shutdown
>  _require_inject_f2fs_command node i_links
>  _require_command "$(type -P socket)" socket
>  
> @@ -106,7 +107,7 @@ ino=`stat -c '%i' $filename`
>  $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
>  stat $filename >> $seqres.full
>  rm $filename
> -$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
> +_scratch_shutdown -f

Great! Glad to see fs specific code being replaced by common helper.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  sleep 6
>  check_links 1 0 $ino
>  
> -- 
> 2.49.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
